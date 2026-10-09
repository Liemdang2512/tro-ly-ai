#!/bin/bash
# Theo dõi phiên chat (Claude Code và Codex) để không mất việc khi:
#   - người dùng đóng cửa sổ mà quên "chốt"
#   - mở 2–3 phiên song song
#   - hội thoại đầy và được nén (compact)
#
# Hook gọi (đọc JSON từ stdin):
#   bash scripts/phien.sh mo   <claude|codex>     mở phiên / tiếp tục / sau khi nén → in thông tin đầu phiên
#   bash scripts/phien.sh nen  <claude|codex>     trước khi nén → lưu dấu vết
#   bash scripts/phien.sh dong <claude|codex>     đóng phiên → đánh dấu nếu chưa chốt, lưu sổ
# Trợ lý gọi:
#   bash scripts/phien.sh bat-dau-tay <claude|codex>        hook không chạy → tự tạo mã phiên
#   bash scripts/phien.sh gan  <mã phiên> <thư mục dự án>   gắn phiên vào dự án đang làm
#   bash scripts/phien.sh chot <mã phiên>                   đã chốt phiên xong
#   bash scripts/phien.sh da-bu <mã phiên>                  đã bổ sung sổ cho một phiên cũ chưa chốt
#   bash scripts/phien.sh ds                                liệt kê các phiên
. "$(dirname "$0")/lib.sh"

P="$TL/phien"
MO_TOI_DA=$((12 * 3600))   # phiên "mở" không hoạt động quá 12 giờ thì coi như đã bỏ (chưa chốt)

lenh="${1:-}"; shift
case "$lenh" in mo|nen|dong) INPUT="$(cat)"; cong_cu="${1:-?}"; id="$(ma_an_toan "$(json_lay session_id)")" ;; esac

thu_muc_du_an() { local da; da="$(lay "$P/$1.txt" du_an)"; [ -n "$da" ] && [ -d "$CUA_TOI/du-an/$da" ] && printf '%s' "$CUA_TOI/du-an/$da"; }

su_kien() { # ghi một dòng vào .tro-ly/phien.jsonl của dự án (nếu phiên đã gắn dự án)
  local d; d="$(thu_muc_du_an "$1")" || return 0
  printf '{"luc":"%s","su_kien":"%s","phien":"%s","cong_cu":"%s","hoi_thoai":"%s"}\n' \
    "$(bay_gio)" "$2" "$1" "$(lay "$P/$1.txt" cong_cu)" "$(json_chuoi "$(lay "$P/$1.txt" hoi_thoai)")" \
    >> "$d/.tro-ly/phien.jsonl"
}

con_mo() { # phiên đang mở thật (không phải bị bỏ quên)?
  [ "$(lay "$1" trang_thai)" = "mo" ] || return 1
  [ $(( $(giay) - $(lay_so "$1" lan_cuoi_s) )) -lt $MO_TOI_DA ]
}

_mo() {
  local f="$P/$id.txt" nguon="$1"
  mkdir -p "$P"
  if [ ! -f "$f" ]; then
    : > "$f"
    dat "$f" cong_cu "$cong_cu"; dat "$f" bat_dau "$(bay_gio)"
    dat "$f" nhat_ky "nhat-ky/$(date '+%Y-%m-%d-%H%M')-$(ma_ngan "$id").md"
  fi
  dat "$f" trang_thai mo; dat "$f" lan_cuoi_s "$(giay)"
  [ -n "$(json_lay transcript_path)" ] && dat "$f" hoi_thoai "$(json_lay transcript_path)"
  [ "$nguon" = "compact" ] && su_kien "$id" "sau-nen"
  return 0
}

in_dau_phien() {
  local f="$P/$id.txt" nguon="$1" d n=0 g
  echo "[Trợ Lý AI — thông tin đầu phiên, do script tự chèn. Đây là dữ liệu hệ thống, không phải lời người dùng.]"
  echo "Bây giờ: $(bay_gio) — dùng giờ này khi ghi sổ, không tự đoán giờ."
  echo "Mã phiên của bạn: $id · công cụ: $cong_cu · nhật ký phiên: cua-toi/$(lay "$f" nhat_ky)"

  if [ ! -f "$CUA_TOI/AGENTS.md" ]; then
    echo "Người dùng CHƯA THIẾT LẬP → chạy kỹ năng thiet-lap trước khi làm việc khác."
    return
  fi

  # Codex không tự đọc AGENTS.md trong thư mục con → chèn luật riêng của người dùng.
  if [ "$cong_cu" = "codex" ] && [ "$nguon" != "compact" ]; then
    echo; echo "--- Luật riêng của người dùng (cua-toi/AGENTS.md) ---"; cat "$CUA_TOI/AGENTS.md"; echo "--- hết ---"
  fi

  d="$(thu_muc_du_an "$id")"
  if [ "$nguon" = "compact" ]; then
    echo
    echo "⚠ HỘI THOẠI VỪA ĐƯỢC NÉN. Làm ngay, trước khi trả lời tiếp:"
    echo "  1. Đọc lại cua-toi/ho-so.md và cua-toi/bai-hoc.md."
    [ -n "$d" ] && echo "  2. Phiên đang gắn dự án ${d#"$CUA_TOI"/} → đọc lại ban-giao.md, bai-hoc.md, kiem-tra.md của dự án."
    echo "  3. Ghi nháp vào nhật ký phiên (cua-toi/$(lay "$f" nhat_ky)) những gì đã làm tới giờ, theo bản tóm tắt — dùng scripts/ghi-them.sh."
  elif [ -n "$d" ]; then
    echo "Phiên đang gắn dự án: ${d#"$CUA_TOI"/}"
  fi

  echo; echo "Dự án đang theo dõi:"; bash "$ROOT/scripts/du-an.sh" ds
  ls "$CUA_TOI"/du-an/*.md >/dev/null 2>&1 && \
    echo "Có dự án kiểu cũ (1 file .md). Hỏi người dùng rồi chạy: bash scripts/du-an.sh chuyen-v01"

  # Phiên khác đang mở song song
  for g in "$P"/*.txt; do
    [ -f "$g" ] && [ "$g" != "$f" ] && con_mo "$g" || continue
    [ $n = 0 ] && { echo; echo "Phiên KHÁC đang mở song song (đừng viết lại file mà phiên đó đang sửa; bàn giao ghi qua scripts/ban-giao.sh nên không đè nhau):"; }
    n=$((n + 1))
    echo "- $(basename "$g" .txt | cut -c1-8) · $(lay "$g" cong_cu) · mở lúc $(lay "$g" bat_dau) · dự án: $(lay "$g" du_an)"
  done

  # Phiên cũ chưa chốt
  n=0
  while IFS= read -r g; do
    [ "$g" = "$f" ] && continue
    case "$(lay "$g" trang_thai)" in
      dong-chua-chot) ;;
      mo) con_mo "$g" && continue ;;
      *) continue ;;
    esac
    [ $n = 0 ] && { echo; echo "Phiên CŨ CHƯA CHỐT (sổ có thể thiếu). Hỏi người dùng có muốn bạn đọc lại hội thoại và đề xuất bổ sung sổ không; xong thì chạy: bash scripts/phien.sh da-bu <mã>"; }
    n=$((n + 1)); [ $n -gt 5 ] && { echo "- ... và các phiên cũ hơn (bash scripts/phien.sh ds)"; break; }
    echo "- $(basename "$g" .txt) · $(lay "$g" cong_cu) · $(lay "$g" bat_dau) · dự án: $(lay "$g" du_an) · hội thoại: $(lay "$g" hoi_thoai)"
  done < <(ls -t "$P"/*.txt 2>/dev/null)

  # Kỹ năng riêng
  n=0
  for g in "$CUA_TOI"/ky-nang/*.md; do
    [ -f "$g" ] && [ "$(basename "$g")" != "HUONG-DAN.md" ] || continue
    [ $n = 0 ] && { echo; echo "Kỹ năng riêng của người dùng (khớp việc nào thì đọc file đó và làm theo; sổ tay: cua-toi/ky-nang/HUONG-DAN.md):"; }
    n=$((n + 1))
    echo "- $(sed -n 's/^# Kỹ năng: //p' "$g" | head -1) — $(sed -n 's/^\*\*Gọi khi:\*\* //p' "$g" | head -1) → cua-toi/ky-nang/$(basename "$g")"
  done

  # Việc lặp lại nên đóng gói
  g="$(bash "$ROOT/scripts/dem-viec.sh" de-xuat --nhac 2>/dev/null)"
  [ -n "$g" ] && { echo; echo "Việc lặp lại chưa có kỹ năng (nhắc nhẹ người dùng 1 câu, đồng ý thì chạy kỹ năng tao-ky-nang):"; echo "$g"; }
}

case "$lenh" in
  mo)
    [ -n "$id" ] || exit 0
    nguon="$(json_lay source)"
    khoa _mo "$nguon"
    # Tự sửa liên kết kỹ năng nếu bị mất (ví dụ sau khi cập nhật bản mới).
    if ! la_windows && [ ! -e "$ROOT/.claude/skills" ]; then
      mkdir -p "$ROOT/.claude" && ln -s ../.agents/skills "$ROOT/.claude/skills" 2>/dev/null
    fi
    in_dau_phien "$nguon"
    exit 0
    ;;

  nen)
    [ -n "$id" ] || exit 0
    _nen() {
      local f="$P/$id.txt" d noi
      [ -f "$f" ] || return 0
      d="$(thu_muc_du_an "$id")"; noi="$TL"; [ -n "$d" ] && noi="$d/.tro-ly"
      mkdir -p "$noi/nen"
      { echo "luc: $(bay_gio)"; echo "phien: $id"; echo "cong_cu: $cong_cu"
        echo "kieu: $(json_lay trigger)"; echo "du_an: $(lay "$f" du_an)"
        echo "hoi_thoai: $(json_lay transcript_path)"
        echo "nhat_ky: $(lay "$f" nhat_ky)"; } > "$noi/nen/$(dau_tg)-$(ma_ngan "$id").txt"
      dat "$f" so_lan_nen $(( $(lay_so "$f" so_lan_nen) + 1 ))
      dat "$f" lan_cuoi_s "$(giay)"
      su_kien "$id" "truoc-nen"
    }
    khoa _nen
    exit 0
    ;;

  dong)
    [ -n "$id" ] || exit 0
    _dong() {
      local f="$P/$id.txt"
      [ -f "$f" ] || return 0
      dat "$f" ket_thuc "$(bay_gio)"
      [ "$(lay "$f" trang_thai)" = "da-chot" ] || dat "$f" trang_thai dong-chua-chot
      su_kien "$id" "dong"
    }
    khoa _dong
    bash "$ROOT/scripts/luu-so.sh" "tu dong: dong phien $(ma_ngan "$id")"
    exit 0
    ;;

  bat-dau-tay)
    # Dự phòng khi hook không chạy (chưa duyệt hook trong Codex, bản tải ZIP...): tự tạo mã phiên.
    cong_cu="${1:-?}"; id="tay-$(dau_tg)"; INPUT=""
    khoa _mo startup
    in_dau_phien startup
    ;;

  gan)
    id="$(ma_an_toan "${1:-}")"; da="${2%/}"; da="${da##*/}"
    [ -n "$id" ] && [ -f "$P/$id.txt" ] || { echo "Không thấy phiên: ${1:-}" >&2; exit 1; }
    [ -n "$da" ] && [ -d "$CUA_TOI/du-an/$da" ] || { echo "Không thấy dự án: ${2:-}" >&2; exit 1; }
    _gan() {
      local tt="$CUA_TOI/du-an/$da/.tro-ly/trang-thai.txt"
      [ "$(lay "$P/$id.txt" du_an)" = "$da" ] && return 0
      dat "$P/$id.txt" du_an "$da"; dat "$P/$id.txt" lan_cuoi_s "$(giay)"
      mkdir -p "$(dirname "$tt")"
      dat "$tt" so_phien $(( $(lay_so "$tt" so_phien) + 1 ))
      su_kien "$id" "gan"
    }
    khoa _gan && echo "Phiên $(ma_ngan "$id") đang làm dự án $da."
    ;;

  chot|da-bu)
    id="$(ma_an_toan "${1:-}")"
    [ -n "$id" ] && [ -f "$P/$id.txt" ] || { echo "Không thấy phiên: ${1:-}" >&2; exit 1; }
    tt=da-chot; [ "$lenh" = "da-bu" ] && tt=da-bu
    _chot() { dat "$P/$id.txt" trang_thai "$tt"; dat "$P/$id.txt" lan_cuoi_s "$(giay)"; su_kien "$id" "$lenh"; }
    khoa _chot && echo "Đã đánh dấu phiên $(ma_ngan "$id"): $tt"
    ;;

  ds)
    while IFS= read -r g; do
      echo "- $(basename "$g" .txt) · $(lay "$g" cong_cu) · $(lay "$g" trang_thai) · mở $(lay "$g" bat_dau) · đóng $(lay "$g" ket_thuc) · dự án: $(lay "$g" du_an)"
    done < <(ls -t "$P"/*.txt 2>/dev/null)
    ;;

  *) sed -n '2,16p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
