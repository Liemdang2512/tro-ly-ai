#!/bin/bash
# Quản lý thư mục dự án trong cua-toi/du-an/.
#   bash scripts/du-an.sh tao <ten-khong-dau> "<Tên hiển thị>"   tạo dự án mới từ mau/du-an/
#   bash scripts/du-an.sh ds [--tat-ca]                          liệt kê dự án (mặc định: chưa xong)
#   bash scripts/du-an.sh tim <từ khóa>                          tìm thư mục dự án theo tên
#   bash scripts/du-an.sh dat <thư mục> <khóa> "<giá trị>"       cập nhật trạng thái
#        khóa: ten · trang_thai (dang-chay|tam-dung|da-xong) · han_chot · buoc_tiep
#   bash scripts/du-an.sh chuyen-v01                             chuyển dự án kiểu cũ (1 file .md) sang thư mục
. "$(dirname "$0")/lib.sh"

DA="$CUA_TOI/du-an"
MAU="$ROOT/mau/du-an"

thu_muc_da() { # nhận "01_x", "du-an/01_x", "cua-toi/du-an/01_x" hoặc đường dẫn đầy đủ
  local p="${1%/}"
  p="${p##*/}"
  [ -n "$p" ] && [ -d "$DA/$p" ] || { echo "Không thấy dự án: $1" >&2; return 1; }
  printf '%s' "$DA/$p"
}

so_tiep() {
  local max=0 n d
  for d in "$DA"/[0-9][0-9]_*/; do
    [ -d "$d" ] || continue
    n="$(basename "$d" | cut -c1-2)"; n=$((10#$n))
    [ "$n" -gt "$max" ] && max=$n
  done
  printf '%02d' $((max + 1))
}

_dien_mau() { # thay {{...}} trong một file
  local f="$1" t="$1.tmp.$$" r="${ten_hien_thi//&/\\&}"
  sed -e "s|{{TEN_DU_AN}}|$r|g" -e "s|{{NGAY}}|$(hom_nay)|g" "$f" > "$t" && mv "$t" "$f"
}

_tao() {
  local f
  mkdir -p "$DA"
  d="$DA/$(so_tiep)_$slug"
  mkdir -p "$d/tai-lieu" "$d/san-pham" "$d/.tro-ly/nen"
  cp "$MAU"/*.md "$d/"
  for f in "$d"/*.md; do _dien_mau "$f"; done
  touch "$d/tai-lieu/.gitkeep" "$d/san-pham/.gitkeep" "$d/.tro-ly/nen/.gitkeep" "$d/.tro-ly/phien.jsonl"
  local tt="$d/.tro-ly/trang-thai.txt"
  : > "$tt"
  dat "$tt" ten "$ten_hien_thi"; dat "$tt" trang_thai dang-chay
  dat "$tt" han_chot ""; dat "$tt" buoc_tiep ""
  dat "$tt" tao_luc "$(bay_gio)"; dat "$tt" cap_nhat "$(bay_gio)"; dat "$tt" so_phien 0
}

case "${1:-}" in
  tao)
    slug="${2:-}"; ten_hien_thi="${3:-$2}"
    printf '%s' "$slug" | grep -Eq '^[a-z0-9][a-z0-9-]*$' \
      || { echo "Tên thư mục chỉ gồm chữ thường không dấu, số và gạch nối. Ví dụ: bao-gia-cong-ty-x" >&2; exit 1; }
    ten_hien_thi="${ten_hien_thi//|/-}"
    khoa _tao || exit 1
    echo "Đã tạo dự án: ${d#"$CUA_TOI"/}"
    ;;

  ds)
    co=0
    for d in "$DA"/*/; do
      tt="$d.tro-ly/trang-thai.txt"; [ -f "$tt" ] || continue
      s="$(lay "$tt" trang_thai)"
      [ "${2:-}" != "--tat-ca" ] && [ "$s" = "da-xong" ] && continue
      co=1
      printf -- '- %s · %s · %s · bước tiếp: %s · hạn: %s · cập nhật: %s\n' \
        "$(basename "$d")" "$(lay "$tt" ten)" "$s" "$(lay "$tt" buoc_tiep)" \
        "$(lay "$tt" han_chot)" "$(lay "$tt" cap_nhat)"
    done
    [ $co = 1 ] || echo "(chưa có dự án nào)"
    ;;

  tim)
    tu="${2:-}"; [ -n "$tu" ] || { echo "Cần từ khóa." >&2; exit 1; }
    for d in "$DA"/*/; do
      tt="$d.tro-ly/trang-thai.txt"; [ -f "$tt" ] || continue
      if printf '%s %s' "$(basename "$d")" "$(lay "$tt" ten)" | grep -qi -- "$tu"; then
        echo "cua-toi/du-an/$(basename "$d")"
      fi
    done
    ;;

  dat)
    d="$(thu_muc_da "${2:-}")" || exit 1
    k="${3:-}"; v="${4:-}"
    case "$k" in
      ten|han_chot|buoc_tiep) ;;
      trang_thai) case "$v" in dang-chay|tam-dung|da-xong) ;; *) echo "trang_thai: dang-chay | tam-dung | da-xong" >&2; exit 1 ;; esac ;;
      *) echo "Khóa không hợp lệ: $k (ten, trang_thai, han_chot, buoc_tiep)" >&2; exit 1 ;;
    esac
    _dat() { dat "$d/.tro-ly/trang-thai.txt" "$k" "$v" && dat "$d/.tro-ly/trang-thai.txt" cap_nhat "$(bay_gio)"; }
    khoa _dat && echo "Đã cập nhật $k cho $(basename "$d")"
    ;;

  chuyen-v01)
    ls "$DA"/*.md >/dev/null 2>&1 || { echo "Không có dự án kiểu cũ cần chuyển."; exit 0; }
    bash "$ROOT/scripts/luu-so.sh" "truoc khi chuyen du an sang thu muc (v0.2)"
    for f in "$DA"/*.md; do
      slug="$(basename "$f" .md)"
      ten_hien_thi="$(sed -n 's/^# Dự án: //p' "$f" | head -1)"; ten_hien_thi="${ten_hien_thi:-$slug}"
      ten_hien_thi="${ten_hien_thi//|/-}"
      khoa _tao || exit 1
      cu="$(cat "$f")"
      # Nội dung cũ thành tổng quan; phần tiến độ cũ thành khối bàn giao đầu tiên.
      { printf '# Tổng quan — %s\n\n> Chuyển từ sổ dự án cũ ngày %s. Nội dung gốc giữ nguyên bên dưới.\n\n' "$ten_hien_thi" "$(hom_nay)"
        printf '%s\n' "$cu" | sed '1{/^# /d;}'; } > "$d/tong-quan.md"
      tien_do="$(printf '%s\n' "$cu" | grep -E '^- \*\*(Đang ở|Còn dở|Bước tiếp theo):\*\*')"
      printf '%s\n%s\n' "Chuyển từ sổ dự án cũ (v0.1)." "$tien_do" \
        | TRO_LY_PHIEN_TEN="chuyển đổi" bash "$ROOT/scripts/ban-giao.sh" ghi "$d" "chuyen-v01" >/dev/null
      tt="$d/.tro-ly/trang-thai.txt"
      case "$(sed -n 's/^\*\*Trạng thái:\*\* //p' "$f" | head -1)" in
        Tạm*) dat "$tt" trang_thai tam-dung ;; Đã*) dat "$tt" trang_thai da-xong ;;
      esac
      dat "$tt" han_chot "$(sed -n 's/^\*\*Hạn chót:\*\* //p' "$f" | head -1)"
      dat "$tt" buoc_tiep "$(printf '%s\n' "$cu" | sed -n 's/^- \*\*Bước tiếp theo:\*\* //p' | head -1)"
      # Giữ file cũ (không xóa), dời vào .tro-ly/v01/
      mkdir -p "$TL/v01"; mv "$f" "$TL/v01/"
      # Sửa đường dẫn trong bảng dự án của cua-toi/AGENTS.md
      if [ -f "$CUA_TOI/AGENTS.md" ]; then
        t="$CUA_TOI/AGENTS.md.tmp.$$"
        sed "s|du-an/$slug\.md|du-an/$(basename "$d")/|g" "$CUA_TOI/AGENTS.md" > "$t" && mv "$t" "$CUA_TOI/AGENTS.md"
      fi
      echo "Đã chuyển: $slug.md → du-an/$(basename "$d")/"
    done
    bash "$ROOT/scripts/luu-so.sh" "chuyen du an sang thu muc (v0.2)"
    ;;

  *) sed -n '2,9p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
