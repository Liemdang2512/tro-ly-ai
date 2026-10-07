#!/usr/bin/env bash
# Bật / cập nhật luật tự học cho mọi phòng: ./them-tu-hoc.sh  (hoặc vài phòng: ./them-tu-hoc.sh 05_ADS 10_KE_TOAN)
# Mỗi lần chạy:
#   - chép 00_CHUNG/{tu-hoc.md,setup-phong.md,cau-hoi-nhan-viec.csv,phieu.py,khung-theo-phong.md} vào <phòng>/.luat-chung/ (bản sao do script quản lý, không sửa tay)
#   - lần đầu: thêm 1 mục cuối AGENTS.md (sao lưu trước) + tạo so-viec.md nếu chưa có
# Không sửa/xóa gì khác. Chạy lại nhiều lần vẫn an toàn. Sửa luật: sửa file trong 00_CHUNG rồi chạy lại script.
# (Claude Code không tự nạp file nằm ngoài thư mục phòng, nên luật phải có bản sao bên trong phòng.)
set -eu
MOCHA="$(cd "$(dirname "$0")/../.." && pwd)"
LUAT=(tu-hoc.md setup-phong.md cau-hoi-nhan-viec.csv phieu.py khung-theo-phong.md)
DAU="<!-- tu-hoc -->"
BK="$MOCHA/00_CHUNG/sao-luu/$(date +%Y%m%d-%H%M%S)"
for f in "${LUAT[@]}"; do
  [ -f "$MOCHA/00_CHUNG/$f" ] || { echo "Thiếu 00_CHUNG/$f — chép file này vào trước."; exit 1; }
done

if [ $# -gt 0 ]; then phong=("$@"); else
  # mọi thư mục phòng có AGENTS.md (kể cả phòng tự đặt tên khác kiểu NN_TEN), trừ 00_CHUNG
  phong=(); for d in "$MOCHA"/*/; do d="${d%/}"; d="${d##*/}"; [ "$d" = 00_CHUNG ] || [ ! -f "$MOCHA/$d/AGENTS.md" ] || phong+=("$d"); done
fi

for p in "${phong[@]}"; do
  d="$MOCHA/$p"
  if [ ! -f "$d/AGENTS.md" ]; then echo "⏭  $p: không có AGENTS.md, bỏ qua"; continue; fi

  mkdir -p "$d/.luat-chung"
  for f in "${LUAT[@]}"; do cp "$MOCHA/00_CHUNG/$f" "$d/.luat-chung/$f"; done

  if grep -qF "$DAU" "$d/AGENTS.md"; then echo "✓  $p: cập nhật luật"; else
    mkdir -p "$BK/$p" && cp "$d/AGENTS.md" "$BK/$p/AGENTS.md"
    cat >> "$d/AGENTS.md" <<EOF

$DAU
## Tự học (luật chung, bắt buộc)
Áp dụng đầy đủ luật dưới đây trong mọi phiên: tự ghi \`so-viec.md\`, học từ lần sửa, hỏi bù đúng lúc, đóng gói việc lặp lần thứ 3, rà tuần. Nhận việc (gửi phiếu Excel): \`.luat-chung/setup-phong.md\`.
Thư mục \`.luat-chung/\` do người quản trị AI cập nhật — không sửa.

@.luat-chung/tu-hoc.md
EOF
    echo "＋ $p: đã bật tự học"
  fi

  if [ ! -f "$d/so-viec.md" ]; then
    cat > "$d/so-viec.md" <<'EOF'
# Sổ việc

Agent tự ghi mỗi việc đã làm (luật `.luat-chung/tu-hoc.md`, vòng 1). Chỉ thêm dòng, không sửa/xóa dòng cũ.

| Ngày | Loại việc | Việc | Đầu vào | Đầu ra | Kết quả |
|---|---|---|---|---|---|
EOF
    echo "   $p: tạo so-viec.md"
  fi
done
[ -d "$BK" ] && echo "Bản sao lưu AGENTS.md: $BK"
echo "Xong. Đóng cửa sổ Terminal của các phòng đang chạy, rồi bấm KHOI-DONG-TAT-CA.command để bot đọc luật mới."
