#!/bin/bash
# Bàn giao (handoff) của một dự án: MỖI PHIÊN MỘT KHỐI RIÊNG trong ban-giao.md.
# 2–3 phiên làm song song trên cùng dự án thì mỗi phiên chỉ ghi khối của mình, không đè khối của phiên khác.
#
#   bash scripts/ban-giao.sh ghi <thư mục dự án> <mã phiên> [--thay <mã1,mã2>] <<'EOF'
#   **Mục tiêu phiên:** ...
#   **Đã làm:** ...
#   **File liên quan:** ...
#   **Kiểm tra:** ...
#   **Còn dở / rủi ro:** ...
#   **Bước tiếp:** ...
#   EOF
#
# --thay: khối của các phiên CŨ mà phiên này đã làm tiếp / đã hết hiệu lực. Các khối đó được dời sang
#         .tro-ly/ban-giao-cu.md (không xóa). Khối của phiên khác đang mở thì không được thay.
. "$(dirname "$0")/lib.sh"

[ "${1:-}" = "ghi" ] || { sed -n '2,17p' "$0" | sed 's/^# \{0,1\}//'; exit 1; }
d="${2%/}"; d="$CUA_TOI/du-an/${d##*/}"
[ -d "$d" ] || { echo "Không thấy dự án: $2" >&2; exit 1; }
id="$(ma_an_toan "${3:-}")"; [ -n "$id" ] || { echo "Thiếu mã phiên." >&2; exit 1; }
thay=""
[ "${4:-}" = "--thay" ] && thay="$(printf '%s' "${5:-}" | tr -cd 'A-Za-z0-9._,-')"
noi_dung="$(cat)"; [ -n "$noi_dung" ] || { echo "Không có nội dung bàn giao." >&2; exit 1; }

f="$d/ban-giao.md"; cu="$d/.tro-ly/ban-giao-cu.md"
pf="$TL/phien/$id.txt"
cong_cu="$(lay "$pf" cong_cu)"; cong_cu="${TRO_LY_PHIEN_TEN:-${cong_cu:-?}}"

# Không cho thay khối của phiên khác đang mở (nó còn đang làm).
thay_ok=""
for m in ${thay//,/ }; do
  [ "$m" = "$id" ] && continue
  if [ "$(lay "$TL/phien/$m.txt" trang_thai)" = "mo" ]; then
    echo "Bỏ qua --thay $m: phiên đó đang mở." >&2
  else
    thay_ok="$thay_ok,$m"
  fi
done

_ghi() {
  mkdir -p "$d/.tro-ly"
  [ -f "$f" ] || printf '# Bàn giao — %s\n\n' "$(lay "$d/.tro-ly/trang-thai.txt" ten)" > "$f"
  local moi="$f.moi.$$" kq="$f.tmp.$$"
  { printf '<!-- khoi:%s -->\n' "$id"
    printf '### %s · %s · phiên %s\n\n' "$(bay_gio)" "$cong_cu" "$(ma_ngan "$id")"
    printf '%s\n' "$noi_dung"
    printf '<!-- /khoi:%s -->\n' "$id"; } > "$moi"
  [ -n "$thay_ok" ] && [ ! -f "$cu" ] && printf '# Bàn giao cũ (đã được thay)\n\n' > "$cu"
  awk -v id="$id" -v thay="$thay_ok," -v moi="$moi" -v cu="$cu" -v luc="$(bay_gio)" -v ai="$(ma_ngan "$id")" '
    function chen() { while ((getline l < moi) > 0) print l; close(moi); print ""; da_chen = 1 }
    /^<!-- khoi:/ {
      b = $0; sub(/^<!-- khoi:/, "", b); sub(/ -->.*/, "", b)
      if (!da_chen) chen()
      trong = 1; bo = (b == id); luu = (index(thay, "," b ",") > 0)
      if (luu) print "> Thay bởi phiên " ai " lúc " luc >> cu
    }
    { if (!trong) { print; next }
      if (luu) print >> cu; else if (!bo) print }
    /^<!-- \/khoi:/ { trong = 0; if (luu) print "" >> cu }
    END { if (!da_chen) chen() }
  ' "$f" | cat -s > "$kq" && mv "$kq" "$f"
  rm -f "$moi"
  printf '{"luc":"%s","su_kien":"ban-giao","phien":"%s","thay":"%s"}\n' \
    "$(bay_gio)" "$id" "$(json_chuoi "${thay_ok#,}")" >> "$d/.tro-ly/phien.jsonl"
}
khoa _ghi && echo "Đã ghi bàn giao của phiên $(ma_ngan "$id") vào du-an/$(basename "$d")/ban-giao.md"
