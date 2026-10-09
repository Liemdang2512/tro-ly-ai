#!/bin/bash
# Thêm nội dung vào CUỐI một file trong cua-toi/, có khóa nên nhiều phiên ghi cùng lúc không mất dòng.
# Dùng cho file "chỉ thêm": tien-do.md, quyet-dinh.md, bai-hoc.md, nhật ký...
# Cách dùng:
#   bash scripts/ghi-them.sh cua-toi/du-an/01_x/tien-do.md <<'EOF'
#   nội dung
#   EOF
. "$(dirname "$0")/lib.sh"

f="$(trong_cua_toi "${1:-}")" || exit 1
noi_dung="$(cat)"
[ -n "$noi_dung" ] || { echo "Không có nội dung để ghi." >&2; exit 1; }

_ghi() {
  mkdir -p "$(dirname "$f")"
  # File chưa kết thúc bằng xuống dòng thì thêm, để dòng mới không dính vào dòng cũ.
  if [ -s "$f" ] && [ -n "$(tail -c 1 "$f")" ]; then printf '\n' >> "$f"; fi
  printf '%s\n' "$noi_dung" >> "$f"
}
khoa _ghi && echo "Đã ghi vào ${f#"$CUA_TOI"/}"
