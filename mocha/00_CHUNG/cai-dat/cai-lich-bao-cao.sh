#!/usr/bin/env bash
# Cài / tắt lịch báo cáo của các phòng MOCHA trên máy đang chạy bot (macOS):
#   ./cai-lich-bao-cao.sh bat   — báo cáo cuối ngày 17:47 mỗi ngày + rà tuần thứ Hai 08:33
#   ./cai-lich-bao-cao.sh tat   — gỡ lịch (cập nhật sau sẽ không tự bật lại)
#   ./cai-lich-bao-cao.sh xem   — xem lịch đang cài
# Máy ngủ đúng giờ → chạy bù khi máy thức. Máy tắt → bỏ lượt đó.
set -eu
HERE="$(cd "$(dirname "$0")" && pwd)"
LA="$HOME/Library/LaunchAgents"
TAT="$HERE/.lich-da-tat"
[ "$(uname)" = Darwin ] || { echo "Lịch báo cáo hiện chỉ cài được trên macOS."; exit 0; }

go() { launchctl bootout "gui/$(id -u)/$1" 2>/dev/null || true; rm -f "$LA/$1.plist"; }

case "${1:-xem}" in
  bat)
    CLAUDE_BIN="$(command -v claude || true)"
    [ -n "$CLAUDE_BIN" ] || { echo "Không thấy lệnh claude trên máy — chưa cài lịch."; exit 1; }
    case "$HERE" in "$HOME"/Desktop/*|"$HOME"/Documents/*|"$HOME"/Downloads/*|*"Mobile Documents"*)
      echo "⚠ Thư mục MOCHA nằm trong Desktop/Documents/Downloads/iCloud: macOS có thể chặn lịch chạy nền đọc file ở đây."
      echo "  Nếu báo cáo không tới, xem nhật ký trong 00_CHUNG/nhat-ky-lich/ (lỗi 'Operation not permitted')." ;;
    esac
    rm -f "$TAT"; mkdir -p "$LA" "$HERE/../nhat-ky-lich"
    for loai in ngay tuan; do
      nhan="vn.mocha.bao-cao-$loai"
      if [ $loai = ngay ]; then gio="<key>Hour</key><integer>17</integer><key>Minute</key><integer>47</integer>"
      else gio="<key>Weekday</key><integer>1</integer><key>Hour</key><integer>8</integer><key>Minute</key><integer>33</integer>"; fi
      go "$nhan"
      cat > "$LA/$nhan.plist" <<EOF
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0"><dict>
  <key>Label</key><string>$nhan</string>
  <key>ProgramArguments</key><array><string>/bin/bash</string><string>$HERE/bao-cao-dinh-ky.sh</string><string>$loai</string></array>
  <key>StartCalendarInterval</key><dict>$gio</dict>
  <key>EnvironmentVariables</key><dict><key>PATH</key><string>$(dirname "$CLAUDE_BIN"):/usr/local/bin:/opt/homebrew/bin:/usr/bin:/bin</string><key>LANG</key><string>en_US.UTF-8</string></dict>
  <key>StandardOutPath</key><string>$HERE/../nhat-ky-lich/launchd.log</string>
  <key>StandardErrorPath</key><string>$HERE/../nhat-ky-lich/launchd.log</string>
</dict></plist>
EOF
      launchctl bootstrap "gui/$(id -u)" "$LA/$nhan.plist"
    done
    echo "Đã cài lịch: báo cáo cuối ngày 17:47 · rà tuần thứ Hai 08:33 (mọi phòng có bot, gửi vào topic của phòng)." ;;
  tat)
    go vn.mocha.bao-cao-ngay; go vn.mocha.bao-cao-tuan; touch "$TAT"
    echo "Đã tắt lịch báo cáo. Bật lại: ./cai-lich-bao-cao.sh bat" ;;
  tu-dong)   # gọi từ cập nhật: chỉ cài trên máy có bot phòng, khi chưa cài và người dùng chưa tắt
    ls "$HOME"/.claude/channels/mocha/*/.env >/dev/null 2>&1 || exit 0
    [ -f "$TAT" ] || [ -f "$LA/vn.mocha.bao-cao-ngay.plist" ] || bash "$0" bat ;;
  xem)
    for n in vn.mocha.bao-cao-ngay vn.mocha.bao-cao-tuan; do
      if launchctl print "gui/$(id -u)/$n" >/dev/null 2>&1; then echo "✓ $n đang bật"; else echo "✗ $n chưa cài"; fi
    done ;;
  *) echo "Dùng: bat | tat | xem"; exit 1 ;;
esac
