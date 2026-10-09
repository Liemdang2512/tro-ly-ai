---
name: tao-ky-nang
description: Đóng gói một việc lặp lại của người dùng thành kỹ năng riêng (cua-toi/ky-nang/) kèm hướng dẫn cách dùng, để lần sau chỉ cần gọi tên. Dùng khi người dùng nói "tạo kỹ năng", "lần sau cứ làm vậy", khi máy đếm thấy một việc đã làm từ 3 lần và người dùng đồng ý đóng gói, hoặc lúc thiết lập lần đầu.
---

# Tạo kỹ năng riêng

## 1. Đặt tên loại việc
Tên loại việc = tên file kỹ năng: chữ thường không dấu, gạch nối (`bao-gia`, `bao-cao-tuan`).
Chạy `bash scripts/dem-viec.sh loai`. Việc này đã có tên trong danh sách → **dùng đúng tên đó**, để máy biết việc đã có kỹ năng và thôi đề xuất.

## 2. Tìm mẫu có sẵn
Chạy `ls mau/ky-nang/`. Có mẫu khớp (báo giá, báo cáo tuần, trả lời khách, tóm tắt họp…) → đọc mẫu làm khung, chỉ hỏi những phần riêng của người dùng. Không có mẫu khớp → dùng khung `mau/ky-nang/_khung.md`.

## 3. Hỏi tối đa 5 câu
Bỏ những câu đã rõ: xem các lần làm trước bằng mô tả trong `cua-toi/.tro-ly/viec-lap-lai.tsv`, `tien-do.md` của dự án liên quan, và nhật ký.
1. Anh/chị sẽ gọi việc này bằng câu nào? (ví dụ "làm báo giá cho …")
2. Đầu vào là gì? (email, file, số liệu dán vào, bảng giá…). Tài liệu dùng đi dùng lại thì để ở đâu?
3. Các bước anh/chị thường làm, theo thứ tự?
4. Kết quả trông thế nào? Có mẫu cũ thì dán vào, đây là cách tốt nhất.
5. Làm sao biết kết quả **đạt**? Lỗi hay gặp là gì?

## 4. Viết file `cua-toi/ky-nang/<loai-viec>.md`
Theo khung. **Bắt buộc** có mục `## Cách dùng` ngay dưới tiêu đề, đủ 4 dòng:
- **Nói:** câu gọi chính + 1–2 cách nói khác
- **Cần chuẩn bị:** thông tin hoặc file phải có, và để ở đâu
- **Kết quả:** trông thế nào, file lưu ở đâu (thường là `du-an/<NN_ten>/san-pham/`)
- **Ví dụ:** một câu gọi thật, lấy từ lần làm trước của chính người dùng

Giữ đúng 2 dòng đầu `# Kỹ năng: <Tên>` và `**Gọi khi:** …`. Script đọc 2 dòng này để giới thiệu kỹ năng ở đầu mỗi phiên.

## 5. Ghi ở 3 chỗ
1. Bảng **Kỹ năng riêng** trong `cua-toi/AGENTS.md`: `| "<câu gọi>" | cua-toi/ky-nang/<loai-viec>.md |`
2. **Sổ tay** `cua-toi/ky-nang/HUONG-DAN.md` (chưa có thì chép từ `mau/cua-toi/ky-nang-HUONG-DAN.md`). Thêm 1 mục theo khuôn trong file đó.
3. **Nhật ký phiên:** dòng "Tạo kỹ năng <Tên>" (qua `scripts/ghi-them.sh`).

## 6. Chạy thử ngay
Dùng dữ liệu thật, hoặc ví dụ người dùng đưa. Người dùng góp ý → sửa file kỹ năng. Cách gọi hoặc đầu vào thay đổi thì sửa luôn mục `Cách dùng` và sổ tay.

## 7. Lưu và báo
`bash scripts/luu-so.sh "ky-nang: <loai-viec>"`. Sau đó báo đúng khuôn:
> Đã tạo kỹ năng **<Tên>**. Lần sau anh/chị chỉ cần nói: *"<câu gọi>"*.
> Cần chuẩn bị: <…>. Kết quả nằm ở: <…>.
> Muốn xem các việc em làm được: hỏi *"em biết làm những gì?"* hoặc mở `cua-toi/ky-nang/HUONG-DAN.md`.

Không sửa `.agents/skills/`, `mau/` hay `goi/`. Kỹ năng riêng luôn nằm trong `cua-toi/ky-nang/`.
