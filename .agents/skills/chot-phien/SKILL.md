---
name: chot-phien
description: Tóm tắt phiên làm việc và cập nhật sổ nhớ (dự án, quyết định, bài học, nhật ký). Dùng khi người dùng nói "chốt", "xong", "hết giờ", "tạm dừng", "mai làm tiếp".
---

# Chốt phiên

1. **Tóm tắt** phiên trong 3–5 gạch đầu dòng: đã làm gì, kết quả chính, còn dở gì.
2. **Liệt kê đề xuất cập nhật sổ** (chỉ những gì thật sự thay đổi, bỏ qua mục trống):
   ```
   Em đề xuất cập nhật sổ:
   • Dự án <tên>: Đang ở → … ; Bước tiếp → …
   • Quyết định mới: <nội dung> — lý do: … — ai chốt: …
   • Bài học: <điều anh/chị đã sửa em trong phiên>
   • Việc lặp lại em thấy có thể làm thành kỹ năng: <tên việc>   (nếu có)
   Ghi vào sổ nhé?
   ```
3. Người dùng đồng ý (hoặc sửa) → ghi theo luật trong `AGENTS.md` gốc (chỉ thêm dòng mới ở quyết định/bài học). Dự án mới chưa có file → tạo từ `mau/cua-toi/du-an.md` và thêm vào bảng dự án trong `cua-toi/AGENTS.md`.
4. **Luôn ghi nhật ký** (không cần hỏi): thêm vào cuối `cua-toi/nhat-ky/<YYYY-MM-DD>.md`:
   ```
   ## <HH:MM> — <chủ đề phiên>
   - <3–5 dòng tóm tắt>
   - Bước tiếp: …
   ```
5. Nếu `cua-toi/.git` tồn tại: `git -C cua-toi add -A && git -C cua-toi commit -m "chot-phien: <chủ đề>"`.
6. Kết thúc bằng 1 dòng: *"Đã lưu. Lần sau anh/chị chỉ cần nói 'tiếp tục <tên việc>'."*
