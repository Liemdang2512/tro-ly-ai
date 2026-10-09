#!/bin/bash
# Trợ Lý AI — bấm đúp để lấy bản mới nhất. Không đụng tới dữ liệu trong cua-toi/.
cd "$(dirname "$0")" || exit 1
done_msg() { printf '\n%s\n\nNhấn Enter để đóng cửa sổ.' "$1"; read -r _; }

if [ -d .git ] && xcode-select -p >/dev/null 2>&1; then
  if git pull --ff-only; then
    bash scripts/nang-cap.sh
    done_msg "✅ Đã cập nhật. Dữ liệu cá nhân (cua-toi) giữ nguyên."
  else
    done_msg "❌ Chưa cập nhật được (có thể do mất mạng hoặc file lõi bị sửa tay). Hãy nhờ người quản trị."
  fi
else
  done_msg "Thư mục này được tải dạng file nén nên không tự cập nhật được.
Cách cập nhật: tải bản mới về → chép thư mục 'cua-toi' từ bản cũ sang bản mới → bấm đúp CAI-DAT.command trong bản mới.
Lần sau nên cài bằng dòng lệnh git clone trong README để cập nhật tự động."
fi
