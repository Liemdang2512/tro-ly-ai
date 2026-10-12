---
name: ghi-nho
description: Ghi một thông tin vào đúng chỗ trong sổ nhớ của người dùng sau khi họ đồng ý. Dùng khi người dùng nói "nhớ cái này", "ghi lại", "lưu ý giùm", "lần sau nhớ…", hoặc khi họ sửa cách bạn làm việc.
---

# Ghi nhớ

1. **Kiểm tra an toàn trước tiên.** Nội dung có mật khẩu, OTP, số thẻ/tài khoản, API key, CCCD, hoặc thuộc danh sách "không ghi nhớ" trong `cua-toi/AGENTS.md` → **không ghi**, giải thích ngắn lý do.
2. **Phân loại** (xem bảng Bộ nhớ trong `AGENTS.md` gốc):
   - Sở thích, cách làm việc → `cua-toi/ho-so.md` (mục phù hợp)
   - Thuật ngữ, tên người, sản phẩm → mục Từ điển trong `cua-toi/ho-so.md`
   - Luật mới kiểu "từ giờ luôn / không bao giờ…" → mục Luật riêng trong `cua-toi/AGENTS.md`
   - Thuộc một dự án:
     - bối cảnh, mục tiêu, người liên quan → `du-an/<NN_ten>/tong-quan.md`
     - quyết định → `du-an/<NN_ten>/quyet-dinh.md`
     - lỗi, bài học → `du-an/<NN_ten>/bai-hoc.md`
     - tiến độ → `du-an/<NN_ten>/tien-do.md`
   - Quyết định chung, không thuộc dự án nào → `cua-toi/quyet-dinh.md`
   - Người dùng sửa lỗi của bạn, không riêng dự án nào → `cua-toi/bai-hoc.md`
3. **Đề xuất** đúng 1–2 dòng: *"Em sẽ ghi vào [sổ tay cách làm việc / dự án X / sổ quyết định / sổ bài học]: '<nội dung viết lại gọn>'. Được không ạ?"*
4. Người dùng đồng ý → ghi:
   - File "chỉ thêm" (quyết định, bài học, tiến độ) → thêm **một dòng mới ở cuối** qua `bash scripts/ghi-them.sh <file>`, kèm ngày hôm nay. Không sửa dòng cũ.
   - File khác (hồ sơ, tổng quan, luật riêng) → **đọc lại file ngay trước khi sửa**, chỉ sửa đúng mục đó, không viết lại cả file. Có thể đang có phiên khác mở song song.
5. Thông tin mới **mâu thuẫn** với điều đã ghi → chỉ ra dòng cũ, hỏi giữ cái nào. Chỉ sửa dòng cũ khi người dùng nói rõ.
6. Xác nhận ngắn: *"Em ghi rồi ạ."* rồi chạy `bash scripts/luu-so.sh "ghi-nho: <tóm tắt 5 chữ>"`.
