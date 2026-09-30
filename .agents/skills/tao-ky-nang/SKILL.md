---
name: tao-ky-nang
description: Đóng gói một việc lặp lại của người dùng thành kỹ năng riêng (file quy trình trong cua-toi/ky-nang/) để lần sau chỉ cần gọi tên. Dùng khi người dùng nói "tạo kỹ năng", "lần sau cứ làm vậy", hoặc khi một việc đã lặp lại từ 3 lần.
---

# Tạo kỹ năng riêng

1. **Hỏi tối đa 5 câu** (bỏ câu nào đã rõ từ phiên vừa làm):
   1. Việc này tên là gì, anh/chị sẽ gọi nó bằng câu nào? (ví dụ "làm báo cáo tuần")
   2. Đầu vào là gì? (email, file, số liệu dán vào, thông tin cần hỏi…)
   3. Các bước anh/chị thường làm, theo thứ tự?
   4. Kết quả trông thế nào? (có mẫu cũ thì dán vào — tốt nhất)
   5. Làm sao biết kết quả **đạt**? Những lỗi hay gặp?
2. **Viết file** `cua-toi/ky-nang/<ten-khong-dau-gach-noi>.md` theo khuôn:
   ```markdown
   # Kỹ năng: <Tên>
   **Gọi khi:** "<câu gọi>", "<cách nói khác>"
   **Đầu vào cần có:** … (thiếu thì hỏi người dùng trước)

   ## Các bước
   1. …

   ## Mẫu kết quả
   …

   ## Kiểm tra trước khi giao
   - [ ] …
   - [ ] Số liệu có nguồn, không bịa
   ```
3. **Đăng ký** vào bảng Kỹ năng riêng trong `cua-toi/AGENTS.md`: `| "<câu gọi>" | cua-toi/ky-nang/<ten>.md |`.
4. **Chạy thử ngay** với dữ liệu thật (hoặc ví dụ người dùng đưa). Người dùng góp ý → sửa file kỹ năng.
5. Nếu `cua-toi/.git` tồn tại: `git -C cua-toi add -A && git -C cua-toi commit -m "ky-nang: <ten>"`.

Không sửa `.agents/skills/` hay `goi/` — kỹ năng riêng luôn nằm trong `cua-toi/ky-nang/`.
