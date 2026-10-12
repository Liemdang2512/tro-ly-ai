#!/usr/bin/env bash
# Cập nhật phần huấn luyện agent phòng ban MOCHA từ repo vào cua-toi/MOCHA_AI (tự chạy sau CAP-NHAT.command).
# - Chép các file trong mocha/00_CHUNG/ vào cua-toi/MOCHA_AI/00_CHUNG/; file cũ khác bản mới được sao lưu trước.
# - Chạy them-tu-hoc.sh: bật/cập nhật luật tự học cho mọi phòng (chỉ thêm, không xóa dữ liệu phòng).
# Máy không có cua-toi/MOCHA_AI → bỏ qua, không làm gì.
set -eu
REPO="$(cd "$(dirname "$0")/.." && pwd)"
SRC="$REPO/mocha/00_CHUNG"
DEST="$REPO/cua-toi/MOCHA_AI/00_CHUNG"
[ -d "$DEST" ] || { echo "(Không có cua-toi/MOCHA_AI trên máy này — bỏ qua phần agent phòng ban.)"; exit 0; }

BK="$DEST/sao-luu/$(date +%Y%m%d-%H%M%S)-cap-nhat"
doi=0
while IFS= read -r f; do
  rel="${f#"$SRC"/}"
  if [ -f "$DEST/$rel" ] && ! cmp -s "$f" "$DEST/$rel"; then
    mkdir -p "$BK/$(dirname "$rel")" && cp "$DEST/$rel" "$BK/$rel"
  fi
  if ! cmp -s "$f" "$DEST/$rel" 2>/dev/null; then
    mkdir -p "$DEST/$(dirname "$rel")" && cp "$f" "$DEST/$rel"; doi=$((doi + 1))
  fi
done < <(find "$SRC" -type f ! -name .DS_Store)
chmod +x "$DEST/cai-dat/them-tu-hoc.sh" "$DEST/cai-dat/bao-cao-dinh-ky.sh" "$DEST/cai-dat/cai-lich-bao-cao.sh"

echo "MOCHA: cập nhật $doi file huấn luyện."
[ -d "$BK" ] && echo "MOCHA: bản cũ đã sao lưu ở $BK"
bash "$DEST/cai-dat/them-tu-hoc.sh" | grep -v '^✓' || true
# lịch báo cáo 17:47 / thứ Hai 08:33: tự cài trên máy có bot phòng (tắt: cai-dat/cai-lich-bao-cao.sh tat)
bash "$DEST/cai-dat/cai-lich-bao-cao.sh" tu-dong || echo "MOCHA: chưa cài được lịch báo cáo (xem 00_CHUNG/nhat-ky-lich/)."
