#!/bin/bash
# Chuẩn bị / sửa cấu trúc sau khi cài hoặc cập nhật. Chạy lại nhiều lần vẫn an toàn,
# không ghi đè dữ liệu người dùng. Được gọi bởi CAI-DAT, MO-TRO-LY, CAP-NHAT (Mac và Windows).
. "$(dirname "$0")/lib.sh"

mkdir -p "$CUA_TOI" "$TL/phien"

# 1. Claude Code đọc kỹ năng ở .claude/skills → trỏ về .agents/skills (bản gốc duy nhất, Codex đọc thẳng).
#    Trên Windows, bộ cài PowerShell tạo junction thay cho lệnh này.
if ! la_windows; then
  if [ ! -L "$ROOT/.claude/skills" ] && [ ! -d "$ROOT/.claude/skills" ]; then
    mkdir -p "$ROOT/.claude"
    rm -f "$ROOT/.claude/skills"   # bản tải ZIP cũ có thể để lại file chữ thay cho liên kết
    ln -s ../.agents/skills "$ROOT/.claude/skills"
  fi
fi

# 2. Lưu lịch sử cho cua-toi/ (để khôi phục khi cần).
co_git=0
if command -v git >/dev/null 2>&1; then
  if la_windows || [ "$(uname -s)" != "Darwin" ] || xcode-select -p >/dev/null 2>&1; then co_git=1; fi
fi
if [ $co_git = 1 ] && [ ! -d "$CUA_TOI/.git" ]; then
  git -C "$CUA_TOI" init -q
  git -C "$CUA_TOI" config user.name "Tro Ly AI"
  git -C "$CUA_TOI" config user.email "tro-ly-ai@localhost"
  echo "✅ Đã bật lưu lịch sử cho dữ liệu cá nhân."
fi

# 3. Những thứ không đưa vào lịch sử: khóa tạm, tài liệu gốc người dùng đưa (thường nặng).
gi="$CUA_TOI/.gitignore"
for dong in '.tro-ly/khoa/' '*.tmp.*' '*.moi.*' 'tai-lieu/' 'du-an/*/tai-lieu/' '.DS_Store'; do
  grep -qxF "$dong" "$gi" 2>/dev/null || echo "$dong" >> "$gi"
done

# 4. Người dùng đã thiết lập: bổ sung sổ tay kỹ năng nếu chưa có.
if [ -f "$CUA_TOI/AGENTS.md" ]; then
  mkdir -p "$CUA_TOI/ky-nang"
  [ -f "$CUA_TOI/ky-nang/HUONG-DAN.md" ] || cp "$ROOT/mau/cua-toi/ky-nang-HUONG-DAN.md" "$CUA_TOI/ky-nang/HUONG-DAN.md"
fi
exit 0
