#!/bin/bash
# Kiểm tra tự động cho v0.2: dự án dạng thư mục, bàn giao theo phiên, nhiều phiên song song,
# nén hội thoại, phiên chưa chốt, đếm việc lặp lại, chuyển dữ liệu v0.1, khôi phục.
# Chạy: bash tests/test-v02.sh   (trên Mac hoặc Git Bash). Không đụng tới cua-toi/ thật.
set -u
NGUON="$(cd "$(dirname "$0")/.." && pwd)"
TMP="$(mktemp -d)"; R="$TMP/Tro ly test"          # có dấu cách để bắt lỗi đường dẫn
mkdir -p "$R"
( cd "$NGUON" && ls -A | grep -vxE 'cua-toi|\.git|\.harness' | tr '\n' '\0' | xargs -0 tar --exclude=.claude/skills -cf - ) | ( cd "$R" && tar -xf - )
C="$R/cua-toi"; S="$R/scripts"
dat=0; truot=0
ok()   { dat=$((dat + 1)); echo "  ✅ $1"; }
hong() { truot=$((truot + 1)); echo "  ❌ $1"; }
kt()   { if eval "$2"; then ok "$1"; else hong "$1"; fi; }
mo()   { printf '{"session_id":"%s","transcript_path":"/tmp/hoi thoai/%s.jsonl","source":"%s"}' "$1" "$1" "${3:-startup}" | bash "$S/phien.sh" mo "$2"; }
dong() { printf '{"session_id":"%s"}' "$1" | bash "$S/phien.sh" dong "${2:-claude}" >/dev/null 2>&1; }

echo "1. Cài đặt / nâng cấp"
bash "$S/nang-cap.sh" >/dev/null; bash "$S/nang-cap.sh" >/dev/null
kt "liên kết .claude/skills trỏ về .agents/skills" '[ -f "$R/.claude/skills/chot-phien/SKILL.md" ]'
kt "cua-toi có lưu lịch sử" '[ -d "$C/.git" ]'
kt ".gitignore của cua-toi không bị lặp dòng khi chạy 2 lần" '[ "$(grep -cx "tai-lieu/" "$C/.gitignore")" = 1 ]'

echo "2. Chưa thiết lập"
kt "đầu phiên báo chưa thiết lập" 'mo s0 claude | grep -q "CHƯA THIẾT LẬP"'
echo "# Riêng của Test" > "$C/AGENTS.md"
bash "$S/nang-cap.sh" >/dev/null
kt "đã thiết lập thì có sổ tay kỹ năng" '[ -f "$C/ky-nang/HUONG-DAN.md" ]'

echo "3. Dự án"
bash "$S/du-an.sh" tao bao-gia "Báo giá & công ty X" >/dev/null
bash "$S/du-an.sh" tao bao-cao "Báo cáo tuần" >/dev/null
kt "đánh số 01, 02" '[ -d "$C/du-an/01_bao-gia" ] && [ -d "$C/du-an/02_bao-cao" ]'
kt "đủ file khung" 'for f in tong-quan ban-giao tien-do quyet-dinh bai-hoc kiem-tra; do [ -f "$C/du-an/01_bao-gia/$f.md" ] || exit 1; done'
kt "không sót {{…}} trong mẫu" '! grep -rq "{{" "$C/du-an/01_bao-gia"'
kt "tên có ký tự & giữ nguyên" 'grep -q "Báo giá & công ty X" "$C/du-an/01_bao-gia/tong-quan.md"'
kt "từ chối tên thư mục có dấu" '! bash "$S/du-an.sh" tao "báo-giá" x 2>/dev/null'
bash "$S/du-an.sh" dat 01_bao-gia buoc_tiep "Gửi bản nháp" >/dev/null
kt "ds hiện bước tiếp" 'bash "$S/du-an.sh" ds | grep -q "Gửi bản nháp"'
kt "tìm dự án theo tên" '[ "$(bash "$S/du-an.sh" tim "báo giá")" = "cua-toi/du-an/01_bao-gia" ]'

echo "4. Ba phiên song song (Claude, Codex, Claude)"
mo a1 claude >/dev/null; mo b2 codex >/dev/null
out="$(mo c3 claude)"
kt "phiên mới thấy 2 phiên khác đang mở" '[ "$(printf "%s" "$out" | grep -c "^- [ab][12] ·")" = 2 ]'
kt "Codex được chèn luật riêng" 'mo b2 codex resume | grep -q "Riêng của Test"'
for p in a1 b2 c3; do bash "$S/phien.sh" gan $p 01_bao-gia >/dev/null; done
for vong in 1 2 3 4 5; do
  for p in a1 b2 c3; do printf '**Đã làm:** %s vòng %s\n**Bước tiếp:** tiếp %s\n' $p $vong $p | bash "$S/ban-giao.sh" ghi 01_bao-gia $p >/dev/null & done
  wait
done
BG="$C/du-an/01_bao-gia/ban-giao.md"
kt "bàn giao có đúng 3 khối (không đè, không trùng)" '[ "$(grep -c "^<!-- khoi:" "$BG")" = 3 ]'
kt "mỗi khối giữ bản mới nhất của phiên đó" 'for p in a1 b2 c3; do grep -q "$p vòng 5" "$BG" || exit 1; done'
kt "không còn file tạm" '! ls "$C/du-an/01_bao-gia/" | grep -q "tmp\|moi"'
for p in a1 b2 c3; do for i in $(seq 1 20); do echo "- $p dòng $i" | bash "$S/ghi-them.sh" "cua-toi/du-an/01_bao-gia/tien-do.md" >/dev/null & done; done; wait
kt "ghi-them song song đủ 60 dòng" '[ "$(grep -c "^- [abc][123] dòng" "$C/du-an/01_bao-gia/tien-do.md")" = 60 ]'
for p in a1 b2 c3; do bash "$S/luu-so.sh" "luu $p" & done; wait
kt "lưu sổ song song không lỗi, sổ sạch" '[ -z "$(git -C "$C" status --porcelain)" ]'
kt "không thay được khối của phiên đang mở" 'echo x | bash "$S/ban-giao.sh" ghi 01_bao-gia a1 --thay b2 2>&1 | grep -q "đang mở" && grep -q "khoi:b2" "$BG"'

echo "5. Nén hội thoại"
printf '{"session_id":"a1","trigger":"auto","transcript_path":"/tmp/x.jsonl"}' | bash "$S/phien.sh" nen claude
kt "lưu dấu vết nén trong thư mục dự án" 'ls "$C/du-an/01_bao-gia/.tro-ly/nen/" | grep -q "a1.txt"'
out="$(mo a1 claude compact)"
kt "sau nén: nhắc đọc lại + chỉ đúng dự án" 'printf "%s" "$out" | grep -q "VỪA ĐƯỢC NÉN" && printf "%s" "$out" | grep -q "du-an/01_bao-gia"'
kt "sự kiện nén ghi vào phien.jsonl" 'grep -q "\"truoc-nen\"" "$C/du-an/01_bao-gia/.tro-ly/phien.jsonl"'

echo "6. Đóng phiên khi chưa chốt"
bash "$S/phien.sh" chot a1 >/dev/null; dong a1; dong b2 codex
out="$(mo d4 claude)"
kt "b2 (đóng chưa chốt) được nhắc bù sổ" 'printf "%s" "$out" | sed -n "/CHƯA CHỐT/,\$p" | grep -q "^- b2 "'
kt "a1 (đã chốt) không bị nhắc" '! printf "%s" "$out" | sed -n "/CHƯA CHỐT/,\$p" | grep -q "^- a1 "'
echo y | bash "$S/ban-giao.sh" ghi 01_bao-gia c3 --thay b2 >/dev/null 2>&1
kt "thay khối của phiên đã đóng → dời sang ban-giao-cu.md" '! grep -q "khoi:b2" "$BG" && grep -q "b2 vòng 5" "$C/du-an/01_bao-gia/.tro-ly/ban-giao-cu.md"'
bash "$S/phien.sh" da-bu b2 >/dev/null
kt "bù sổ xong thì thôi nhắc" '! mo e5 claude | grep -q "^- b2 "'
kt "đóng phiên tự lưu lịch sử" 'git -C "$C" log --oneline | grep -q "dong phien"'
kt "hook không có mã phiên thì im lặng, không lỗi" 'echo "{}" | bash "$S/phien.sh" dong claude; [ $? = 0 ]'
kt "dự phòng khi hook không chạy" 'bash "$S/phien.sh" bat-dau-tay codex | grep -q "Mã phiên của bạn: tay-"'

echo "7. Việc lặp lại → kỹ năng"
for i in 1 2; do bash "$S/dem-viec.sh" ghi bao-gia 01_bao-gia "lần $i" >/dev/null; done
kt "2 lần chưa đề xuất" '[ -z "$(bash "$S/dem-viec.sh" de-xuat)" ]'
bash "$S/dem-viec.sh" ghi bao-gia 01_bao-gia "lần 3" >/dev/null
kt "3 lần thì đề xuất" 'bash "$S/dem-viec.sh" de-xuat | grep -q "bao-gia: 3 lần"'
kt "đầu phiên có nhắc" 'mo f6 claude | grep -q "bao-gia: 3 lần"'
kt "trong 7 ngày không nhắc lại lúc mở phiên" '! mo g7 claude | grep -q "bao-gia: 3 lần"'
bash "$S/ky-nang.sh" tao bao-gia >/dev/null
kt "có kỹ năng rồi thì thôi đề xuất" '[ -z "$(bash "$S/dem-viec.sh" de-xuat)" ]'
kt "đầu phiên liệt kê kỹ năng riêng + câu gọi" 'mo h8 claude | grep -q "Làm báo giá — \"làm báo giá cho"'
for i in 1 2 3; do bash "$S/dem-viec.sh" ghi tra-loi-khach - "x" >/dev/null; done
bash "$S/dem-viec.sh" khong tra-loi-khach >/dev/null
kt "người dùng từ chối thì thôi đề xuất" '[ -z "$(bash "$S/dem-viec.sh" de-xuat)" ]'

echo "7b. Kỹ năng dạng thư mục"
kt "tạo từ mẫu trùng tên: có SKILL.md + phần đầu chuẩn" '[ -f "$C/ky-nang/bao-gia/SKILL.md" ] && head -2 "$C/ky-nang/bao-gia/SKILL.md" | grep -q "^name: bao-gia"'
kt "không tạo trùng kỹ năng đã có" '! bash "$S/ky-nang.sh" tao bao-gia 2>/dev/null'
bash "$S/ky-nang.sh" tao gui-hoa-don >/dev/null
kt "không có mẫu trùng tên → dùng khung trống, điền sẵn tên loại việc" 'grep -q "^name: gui-hoa-don" "$C/ky-nang/gui-hoa-don/SKILL.md" && grep -q "{{TEN}}" "$C/ky-nang/gui-hoa-don/SKILL.md"'
printf '# Kỹ năng: Báo cáo cũ\n**Gọi khi:** "làm báo cáo cũ"\n\nNội dung cũ\n' > "$C/ky-nang/bao-cao-cu.md"
printf '| "làm báo cáo cũ" | cua-toi/ky-nang/bao-cao-cu.md |\n' >> "$C/AGENTS.md"
printf -- '- file: `ky-nang/bao-cao-cu.md`\n' >> "$C/ky-nang/HUONG-DAN.md"
bash "$S/nang-cap.sh" >/dev/null
kt "nâng cấp tự chuyển kỹ năng kiểu cũ sang thư mục, giữ nội dung" '[ ! -f "$C/ky-nang/bao-cao-cu.md" ] && grep -q "Nội dung cũ" "$C/ky-nang/bao-cao-cu/SKILL.md" && grep -q "^name: bao-cao-cu" "$C/ky-nang/bao-cao-cu/SKILL.md"'
kt "đường dẫn trong AGENTS.md và sổ tay được sửa theo" 'grep -q "ky-nang/bao-cao-cu/SKILL.md" "$C/AGENTS.md" && grep -q "ky-nang/bao-cao-cu/SKILL.md" "$C/ky-nang/HUONG-DAN.md"'
kt "sổ tay HUONG-DAN không bị coi là kỹ năng" '! bash "$S/ky-nang.sh" ds | grep -q "HUONG-DAN"'
kt "đầu phiên liệt kê cả kỹ năng vừa chuyển" 'mo k9 claude | grep -q "Báo cáo cũ — \"làm báo cáo cũ\""'

echo "8. Chuyển dữ liệu v0.1"
cat > "$C/du-an/hop-dong-y.md" <<'EOF'
# Dự án: Hợp đồng Y

**Trạng thái:** Tạm dừng
**Hạn chót:** 2026-12-01

## Mục tiêu
Ký hợp đồng Y

## Tiến độ
- **Đang ở:** chờ pháp chế
- **Còn dở:** phụ lục 2
- **Bước tiếp theo:** gọi anh Nam
EOF
printf '| Hợp đồng Y | du-an/hop-dong-y.md | Tạm dừng |\n' >> "$C/AGENTS.md"
bash "$S/du-an.sh" chuyen-v01 >/dev/null
D="$C/du-an/03_hop-dong-y"
kt "tạo thư mục 03_hop-dong-y" '[ -d "$D" ]'
kt "giữ trạng thái, hạn, bước tiếp" 'bash "$S/du-an.sh" ds --tat-ca | grep "03_hop-dong-y" | grep -q "tam-dung.*gọi anh Nam.*2026-12-01"'
kt "tiến độ cũ thành khối bàn giao đầu tiên" 'grep -q "Còn dở:\*\* phụ lục 2" "$D/ban-giao.md"'
kt "file cũ được giữ trong .tro-ly/v01, không xóa" '[ -f "$C/.tro-ly/v01/hop-dong-y.md" ] && [ ! -f "$C/du-an/hop-dong-y.md" ]'
kt "bảng dự án trong AGENTS.md trỏ thư mục mới" 'grep -q "du-an/03_hop-dong-y/" "$C/AGENTS.md"'

echo "9. Khôi phục"
bash "$S/luu-so.sh" "moc" >/dev/null
ma="$(git -C "$C" rev-parse --short HEAD)"
echo "SỬA NHẦM" > "$C/du-an/01_bao-gia/tong-quan.md"; bash "$S/luu-so.sh" "sua nham" >/dev/null
bash "$S/khoi-phuc.sh" ve "$ma" du-an/01_bao-gia/tong-quan.md >/dev/null
kt "khôi phục đúng nội dung cũ" 'grep -q "Tổng quan" "$C/du-an/01_bao-gia/tong-quan.md"'
kt "bản sửa nhầm vẫn còn trong lịch sử" 'git -C "$C" log --oneline | grep -q "sua nham"'
kt "chặn đường dẫn ra ngoài cua-toi" '! bash "$S/khoi-phuc.sh" xem "$ma" ../AGENTS.md 2>/dev/null'

echo
echo "Kết quả: $dat đạt · $truot hỏng   (thư mục thử: $TMP)"
[ $truot = 0 ]
