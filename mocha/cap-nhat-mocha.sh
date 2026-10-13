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
chmod +x "$DEST/cai-dat/them-tu-hoc.sh"
# bộ "Làm việc với Sếp" v2.1 từng nằm trong repo; nay bộ chỉ ở du-lieu/huan-luyen/ của phòng → cất bản chép cũ
if [ -d "$DEST/lam-viec-voi-sep" ] && [ ! -d "$SRC/lam-viec-voi-sep" ]; then
  mkdir -p "$BK" && mv "$DEST/lam-viec-voi-sep" "$BK/lam-viec-voi-sep" && doi=$((doi + 1))
  echo "MOCHA: đã cất bộ v2.1 cũ ở 00_CHUNG vào $BK"
fi

echo "MOCHA: cập nhật $doi file huấn luyện."
[ -d "$BK" ] && echo "MOCHA: bản cũ đã sao lưu ở $BK"
bash "$DEST/cai-dat/them-tu-hoc.sh" | grep -v '^✓\|^Xong\. Đóng cửa sổ' || true

# Lịch báo cáo 17:47 / thứ Hai 08:33 (tu-hoc.md vòng 7): bot khởi động kèm lời nhắn "đặt lịch" + mã nhóm.
# chay.sh nằm trên từng máy (không trong repo) → sửa đúng dòng exec, sao lưu trước, chạy lại không sửa lần 2.
CHAY="$DEST/cai-dat/chay.sh"
if [ -f "$CHAY" ] && ! grep -q "tu-hoc.md vòng 7" "$CHAY"; then
  mkdir -p "$BK" && cp "$CHAY" "$BK/chay.sh"
  if python3 - "$CHAY" <<'PY'
import sys
p = sys.argv[1]
s = open(p, encoding="utf-8").read()
cu = 'exec claude --permission-mode "$mode" --channels plugin:telegram@claude-plugins-official\n'
moi = ('GID="$(sed -n \'s/^GROUP_ID=//p\' "$HERE/nhom.conf" 2>/dev/null | tr -d \'[:space:]\')"\n'
       # lời nhắn phải đứng trước --channels (tùy chọn này nhận nhiều giá trị, sẽ nuốt lời nhắn đứng sau)
       'exec claude "Khởi động phiên: đặt lịch báo cáo theo .luat-chung/tu-hoc.md vòng 7. chat_id nhóm: $GID. Không gửi gì lên Telegram lúc này." '
       '--permission-mode "$mode" --channels plugin:telegram@claude-plugins-official\n')
if s.count(cu) != 1: sys.exit(1)
open(p, "w", encoding="utf-8").write(s.replace(cu, moi))
PY
  then echo "MOCHA: chay.sh — bot khởi động sẽ tự đặt lịch báo cáo (bản cũ: $BK/chay.sh)."; doi=$((doi + 1))
  else echo "MOCHA: ⚠ chay.sh khác mẫu, chưa gắn lịch báo cáo — nhờ người quản trị sửa tay theo tu-hoc.md vòng 7."; fi
fi

# Có thay đổi → tắt các bot phòng đang chạy rồi mở lại đúng những phòng đó, để bot đọc luật mới.
# Bot nhận ra qua cờ --channels plugin:telegram và thư mục làm việc nằm trong cua-toi/MOCHA_AI/<phòng>.
[ "$doi" -gt 0 ] || exit 0
MOCHA="$(dirname "$DEST")"; mo=(); pids=()
for pid in $(pgrep -f -- "--channels plugin:telegram" || true); do
  cwd="$(lsof -a -p "$pid" -d cwd -Fn 2>/dev/null | sed -n 's/^n//p')"
  case "$cwd" in "$MOCHA"/*) p="${cwd#"$MOCHA"/}"; [ "$p" = "${p%%/*}" ] && { mo+=("$p"); pids+=("$pid"); } ;; esac
done
[ ${#mo[@]} -gt 0 ] || { echo "MOCHA: không có bot phòng nào đang chạy — bấm KHOI-DONG-TAT-CA.command khi cần."; exit 0; }
echo "MOCHA: khởi động lại ${#mo[@]} bot để đọc luật mới: ${mo[*]}"
kill "${pids[@]}" 2>/dev/null || true
for _ in 1 2 3 4 5 6 7 8 9 10; do
  con=0; for pid in "${pids[@]}"; do kill -0 "$pid" 2>/dev/null && con=1; done
  [ "$con" = 0 ] && break; sleep 1
done
bash "$DEST/cai-dat/khoi-dong-tat-ca.sh" "${mo[@]}"
