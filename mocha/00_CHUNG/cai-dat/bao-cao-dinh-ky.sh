#!/usr/bin/env bash
# Báo cáo theo lịch của mọi phòng, gửi vào topic Telegram của từng phòng (lịch do cai-lich-bao-cao.sh cài).
#   ./bao-cao-dinh-ky.sh ngay            — báo cáo cuối ngày (17:47), mọi phòng có bot
#   ./bao-cao-dinh-ky.sh tuan 10_KE_TOAN — rà tuần (thứ Hai 08:33), chỉ phòng đã nêu
#   GUI=0 ./bao-cao-dinh-ky.sh ngay ...  — chỉ soạn và lưu, không gửi
# Mỗi phòng: mở 1 phiên Claude riêng, chỉ được đọc file, Telegram tắt hẳn (không giành tin nhắn của bot đang chạy).
# Bản báo cáo lưu ở <phòng>/bao-cao/, rồi bot của phòng gửi vào đúng topic. Phiên bot đang chạy không bị đụng tới.
set -u
HERE="$(cd "$(dirname "$0")" && pwd)"
MOCHA="$(cd "$HERE/../.." && pwd)"
loai="${1:?Cách dùng: bao-cao-dinh-ky.sh ngay|tuan [phòng…]}"; shift
HOM_NAY="$(date +%F)"
NK="$MOCHA/00_CHUNG/nhat-ky-lich"; mkdir -p "$NK"; LOG="$NK/$HOM_NAY.log"
GROUP_ID="$(sed -n 's/^GROUP_ID=//p' "$HERE/nhom.conf" 2>/dev/null | tr -d '[:space:]')"
[ -n "$GROUP_ID" ] || { echo "Thiếu GROUP_ID trong $HERE/nhom.conf" | tee -a "$LOG"; exit 1; }

case "$loai" in
  ngay) TEN="bao-cao-ngay"; LENH="Đến giờ báo cáo cuối ngày (17:47) theo prompt tổng v2.1, mục ghi_nho_va_cai_tien. Hôm nay là $HOM_NAY.
Đọc: so-viec.md (các dòng ngày hôm nay), nhat-ky/ và bao-cao/ của hôm nay, quyet-dinh.md nếu cần.
Viết báo cáo gửi Sếp. Chỉ in nội dung báo cáo, văn bản thường (không bảng, không markdown), dưới 3000 ký tự:
- Dòng đầu: BÁO CÁO NGÀY <ngày/tháng> – Phòng <tên phòng>
- Đã xong · Đang làm · Chờ Sếp chốt
- Tối đa 3 đề xuất cải tiến prompt, mỗi đề xuất kèm dẫn chứng tin nhắn trong ngày (không có thì bỏ mục này)
Sổ việc hôm nay không có dòng nào: in đúng 2 dòng, dòng đầu như trên, dòng 2 'Hôm nay phòng chưa có việc nào ghi trong sổ việc.'
Chỉ dựa vào file, không bịa việc, số, tên." ;;
  tuan) TEN="ra-tuan"; LENH="Đến giờ rà tuần (thứ Hai 08:33). Hôm nay là $HOM_NAY.
Làm đúng vòng 5 trong .luat-chung/tu-hoc.md (5 mục) cho 7 ngày gần nhất, thêm mục 6 'Chỉ số tự chấm' theo prompt tổng v2.1: % chỗ hở em tự phát hiện · số lần Sếp nhắc lại cùng 1 điều · số lần 'Alo / Đâu r' · số vòng sửa trước khi Sếp OK. Chỉ số nào không có dữ liệu trong file thì ghi 'chưa đo', không ước.
Chỉ in nội dung báo cáo, văn bản thường (không bảng, không markdown), dưới 3500 ký tự. Dòng đầu: RÀ TUẦN <ngày/tháng> – Phòng <tên phòng>.
Chỉ dựa vào file, không bịa việc, số, tên." ;;
  *) echo "Loại phải là ngay hoặc tuan"; exit 1 ;;
esac

if [ $# -gt 0 ]; then ds=("$@"); else
  ds=(); while IFS=, read -r _ma dir _bot _topic || [ -n "$dir" ]; do [ "$dir" = thu_muc ] || [ -z "$dir" ] || ds+=("$dir"); done < "$HERE/rooms.csv"
fi

mot_phong() {
  local dir="$1" topic st out tam rong
  topic="$(awk -F, -v d="$dir" '$2==d{print $4}' "$HERE/rooms.csv" | tr -d '[:space:]')"
  st="$HOME/.claude/channels/mocha/$dir"
  [ -n "$topic" ] && [ -s "$st/.env" ] && [ -d "$MOCHA/$dir" ] || { echo "$(date +%T) ⏭  $dir: chưa có bot/topic, bỏ qua" >> "$LOG"; return; }
  mkdir -p "$MOCHA/$dir/bao-cao"
  out="$MOCHA/$dir/bao-cao/${HOM_NAY}_${TEN}.md"; tam="$out.tam"; rong="$(mktemp -d)"
  ( cd "$MOCHA/$dir" && TELEGRAM_STATE_DIR="$rong" claude -p "$LENH" \
      --strict-mcp-config --settings '{"enabledPlugins":{"telegram@claude-plugins-official":false}}' \
      --allowedTools Read Glob Grep \
      --disallowedTools Bash Write Edit NotebookEdit WebFetch WebSearch ) > "$tam" 2>> "$LOG"
  rmdir "$rong" 2>/dev/null
  if [ ! -s "$tam" ]; then echo "$(date +%T) ✗  $dir: không soạn được báo cáo" >> "$LOG"; rm -f "$tam"; return; fi
  mv "$tam" "$out"
  if [ "${GUI:-1}" = 0 ]; then echo "$(date +%T) ✓  $dir: đã soạn (không gửi) → $out" >> "$LOG"; return; fi
  # token đọc qua biến môi trường, không đưa lên dòng lệnh
  if TOKEN="$(sed -n 's/^TELEGRAM_BOT_TOKEN=//p' "$st/.env")" CHAT="$GROUP_ID" THREAD="$topic" FILE="$out" python3 - 2>> "$LOG" <<'PY'
import json, os, urllib.request
text = open(os.environ["FILE"], encoding="utf-8").read().strip()
parts, cur = [], ""
for line in text.splitlines(keepends=True):          # Telegram giới hạn 4096 ký tự / tin
    while len(line) > 3800: parts.append(line[:3800]); line = line[3800:]
    if len(cur) + len(line) > 3800: parts.append(cur); cur = ""
    cur += line
parts.append(cur)
url = "https://api.telegram.org/bot%s/sendMessage" % os.environ["TOKEN"].strip()
for p in parts:
    body = json.dumps({"chat_id": int(os.environ["CHAT"]), "message_thread_id": int(os.environ["THREAD"]), "text": p}).encode()
    r = json.load(urllib.request.urlopen(urllib.request.Request(url, body, {"Content-Type": "application/json"}), timeout=30))
    if not r.get("ok"): raise SystemExit("Telegram từ chối: %s" % r.get("description"))
PY
  then echo "$(date +%T) ✓  $dir: đã gửi → $out" >> "$LOG"
  else echo "$(date +%T) ✗  $dir: soạn xong nhưng gửi lỗi (bản lưu: $out)" >> "$LOG"; fi
}

echo "$(date +%T) == $TEN: ${#ds[@]} phòng" >> "$LOG"
# chạy 3 phòng cùng lúc cho nhanh, không làm máy quá tải
i=0
for dir in "${ds[@]}"; do
  mot_phong "$dir" & i=$((i + 1))
  [ $((i % 3)) -eq 0 ] && wait
done
wait
echo "$(date +%T) == xong" >> "$LOG"
tail -n $(( ${#ds[@]} + 2 )) "$LOG"
