#!/bin/bash
# Trợ Lý AI — bấm đúp file này để cài đặt (chỉ dành cho máy Mac).
# Chạy lại nhiều lần vẫn an toàn: không ghi đè dữ liệu trong cua-toi/.

cd "$(dirname "$0")" || exit 1
bold() { printf '\n\033[1m%s\033[0m\n' "$1"; }
fail() { printf '\n❌ %s\n\nNhấn Enter để đóng cửa sổ.' "$1"; read -r _; exit 1; }

bold "=== Cài đặt Trợ Lý AI ==="
[ "$(uname)" = "Darwin" ] || fail "Bản cài này chỉ dành cho máy Mac."
[ -f AGENTS.md ] || fail "Không thấy file AGENTS.md. Hãy để file cài đặt nằm nguyên trong thư mục Trợ Lý AI."

# 1. Claude Code
export PATH="$HOME/.local/bin:$PATH"
if command -v claude >/dev/null 2>&1; then
  echo "✅ Đã có Claude Code."
else
  bold "Đang cài Claude Code (cần Internet, khoảng 1–2 phút)..."
  curl -fsSL https://claude.ai/install.sh | bash || fail "Cài Claude Code không thành công. Kiểm tra Internet rồi bấm đúp lại file này."
  export PATH="$HOME/.local/bin:$PATH"
  command -v claude >/dev/null 2>&1 || fail "Đã cài xong nhưng chưa nhận lệnh. Đóng cửa sổ này rồi bấm đúp lại file cài đặt."
  echo "✅ Đã cài Claude Code."
fi

# 2. Cảnh báo nếu thư mục đang nằm trong vùng đồng bộ đám mây (iCloud/OneDrive/Dropbox/Google Drive).
#    Đồng bộ dễ làm hỏng lịch sử của sổ và sinh file trùng kiểu "ho-so 2.md".
dong_bo=""
case "$PWD" in
  *"Mobile Documents"*|*CloudStorage*|*OneDrive*|*Dropbox*|*"Google Drive"*) dong_bo=1 ;;
  "$HOME/Documents"*|"$HOME/Desktop"*)
    [ -d "$HOME/Library/Mobile Documents/com~apple~CloudDocs/Documents" ] && dong_bo=1 ;;
esac
if [ -n "$dong_bo" ]; then
  bold "⚠️  Thư mục này có vẻ đang được iCloud/OneDrive/Dropbox đồng bộ."
  echo "Nên chuyển thư mục Trợ Lý AI ra chỗ không đồng bộ, ví dụ: $HOME/tro-ly-ai"
  printf "Vẫn tiếp tục cài ở đây? (c = có, Enter = dừng lại): "; read -r tl
  [ "$tl" = "c" ] || fail "Đã dừng. Chuyển thư mục rồi bấm đúp lại file cài đặt."
fi

# 3. Liên kết kỹ năng, lưu lịch sử cho cua-toi/, cấu trúc thư mục.
bash scripts/nang-cap.sh

chmod +x MO-TRO-LY.command CAP-NHAT.command 2>/dev/null

# 4. Mở trợ lý
if [ -f cua-toi/AGENTS.md ]; then
  bold "Đã thiết lập từ trước. Đang mở trợ lý..."
  exec claude "tiếp tục"
else
  bold "Đang mở trợ lý để thiết lập lần đầu."
  echo "Lần đầu sẽ mở trình duyệt để đăng nhập tài khoản Claude — đăng nhập xong quay lại cửa sổ này."
  echo "Nếu được hỏi có tin tưởng thư mục này không, chọn Yes (Có)."
  exec claude "thiết lập"
fi
