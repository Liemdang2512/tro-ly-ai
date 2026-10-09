#!/bin/bash
# Lưu lịch sử thay đổi của cua-toi/ (để khôi phục khi cần).
# Cách dùng: bash scripts/luu-so.sh "<lời nhắn>" [file trong cua-toi ...]
#   Không ghi file → lưu mọi thay đổi. Có ghi file → chỉ lưu đúng các file đó
#   (dùng khi nhiều phiên chạy song song, để không lưu nhầm phần đang dở của phiên khác).
. "$(dirname "$0")/lib.sh"

[ -d "$CUA_TOI/.git" ] || exit 0
command -v git >/dev/null 2>&1 || exit 0
msg="${1:-luu so}"; shift

files=()
for f in "$@"; do p="$(trong_cua_toi "$f")" || exit 1; files+=("$p"); done

_luu() {
  local g=(git -C "$CUA_TOI" -c user.name="Tro Ly AI" -c user.email="tro-ly-ai@localhost" -c commit.gpgsign=false)
  if [ ${#files[@]} -gt 0 ]; then "${g[@]}" add -A -- "${files[@]}"; else "${g[@]}" add -A; fi || return 1
  "${g[@]}" diff --cached --quiet && return 0
  "${g[@]}" commit -q -m "$msg"
}

# Thử lại khi git đang bận (index.lock do chương trình khác giữ).
for lan in 1 2 3; do
  khoa _luu 2>/dev/null && exit 0
  sleep "$lan"
done
echo "Chưa lưu được lịch sử (git đang bận). Dữ liệu vẫn nằm trong file, lần lưu sau sẽ gom vào." >&2
exit 0
