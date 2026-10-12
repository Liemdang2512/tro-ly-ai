#!/bin/bash
# Khôi phục sổ về bản cũ — AN TOÀN: không xóa lịch sử, chỉ tạo thêm một bản lưu mới.
#   bash scripts/khoi-phuc.sh lich-su [đường dẫn trong cua-toi]     30 lần lưu gần nhất
#   bash scripts/khoi-phuc.sh xem <mã> <đường dẫn>                   xem nội dung file ở bản cũ
#   bash scripts/khoi-phuc.sh ve <mã> [đường dẫn]                    đưa file (hoặc cả sổ) về bản cũ
# Lưu ý: "ve" ghi đè nội dung file hiện tại bằng bản cũ; file mới tạo sau thời điểm đó vẫn giữ nguyên.
. "$(dirname "$0")/lib.sh"

[ -d "$CUA_TOI/.git" ] || { echo "Sổ chưa bật lưu lịch sử (máy chưa có git) nên không khôi phục được." >&2; exit 1; }
g=(git -C "$CUA_TOI" -c user.name="Tro Ly AI" -c user.email="tro-ly-ai@localhost" -c commit.gpgsign=false)

duong_dan() { # chuyển đường dẫn người dùng đưa thành đường dẫn tương đối trong cua-toi
  local p; p="$(trong_cua_toi "$1")" || return 1; printf '%s' "${p#"$CUA_TOI"/}"
}
ma_hop_le() { "${g[@]}" rev-parse --verify -q "$1^{commit}" >/dev/null || { echo "Không có bản lưu mã: $1" >&2; return 1; }; }

case "${1:-}" in
  lich-su)
    p=(); [ -n "${2:-}" ] && { r="$(duong_dan "$2")" || exit 1; p=(-- "$r"); }
    "${g[@]}" log -n 30 --date=format:'%Y-%m-%d %H:%M' --pretty='%h  %ad  %s' "${p[@]}"
    ;;
  xem)
    ma_hop_le "${2:-}" || exit 1
    r="$(duong_dan "${3:-}")" || exit 1
    "${g[@]}" show "$2:$r"
    ;;
  ve)
    ma_hop_le "${2:-}" || exit 1
    r="."; [ -n "${3:-}" ] && { r="$(duong_dan "$3")" || exit 1; }
    bash "$ROOT/scripts/luu-so.sh" "truoc khi khoi phuc ve $2"
    _ve() { "${g[@]}" checkout "$2" -- "$r"; }
    khoa _ve "$@" || exit 1
    bash "$ROOT/scripts/luu-so.sh" "khoi phuc: $r ve ban $2"
    echo "Đã khôi phục $r về bản $2. Bản trước khi khôi phục vẫn còn trong lịch sử."
    ;;
  *) sed -n '2,6p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
