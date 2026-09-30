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

# 2. Claude Code đọc kỹ năng ở .claude/skills — trỏ về .agents/skills (chuẩn dùng chung cho mọi AI)
mkdir -p .claude
if [ ! -L .claude/skills ] && [ ! -d .claude/skills ]; then
  rm -f .claude/skills
  ln -s ../.agents/skills .claude/skills
fi

# 3. Thư mục riêng của người dùng + lưu lịch sử thay đổi (để khôi phục khi cần)
mkdir -p cua-toi
if xcode-select -p >/dev/null 2>&1 && [ ! -d cua-toi/.git ]; then
  git -C cua-toi init -q
  git -C cua-toi config user.name "Tro Ly AI"
  git -C cua-toi config user.email "tro-ly-ai@localhost"
  echo "✅ Đã bật lưu lịch sử cho dữ liệu cá nhân."
fi

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
