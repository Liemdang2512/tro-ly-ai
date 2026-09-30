---
name: ghi-nho
description: Ghi một thông tin vào đúng chỗ trong sổ nhớ của người dùng sau khi họ đồng ý. Dùng khi người dùng nói "nhớ cái này", "ghi lại", "lưu ý giùm", "lần sau nhớ…", hoặc khi họ sửa cách bạn làm việc.
---

# Ghi nhớ

1. **Kiểm tra an toàn trước tiên:** nội dung có mật khẩu, OTP, số thẻ/tài khoản, API key, CCCD, hoặc thuộc danh sách "không ghi nhớ" trong `cua-toi/AGENTS.md`? → **không ghi**, giải thích ngắn lý do.
2. **Phân loại** (xem bảng Bộ nhớ trong `AGENTS.md` gốc):
   - Sở thích / cách làm việc → `cua-toi/ho-so.md` (mục phù hợp)
   - Liên quan một dự án → `cua-toi/du-an/<ten>.md`
   - Một quyết định đã chốt → `cua-toi/quyet-dinh.md`
   - Người dùng sửa lỗi của bạn → `cua-toi/bai-hoc.md`
   - Luật mới kiểu "từ giờ luôn/không bao giờ…" → mục Luật riêng trong `cua-toi/AGENTS.md`
   - Thuật ngữ, tên người, sản phẩm → mục Từ điển trong `cua-toi/ho-so.md`
3. **Đề xuất**, đúng 1–2 dòng: *"Em sẽ ghi vào [sổ tay cách làm việc / dự án X / sổ quyết định / sổ bài học]: '<nội dung viết lại gọn>'. Được không ạ?"*
4. Đồng ý → ghi. Với `quyet-dinh.md` và `bai-hoc.md`: thêm dòng mới vào cuối bảng, kèm ngày hôm nay. Không sửa dòng cũ.
5. Thông tin mới **mâu thuẫn** với thứ đã ghi → chỉ ra dòng cũ, hỏi giữ cái nào; chỉ sửa dòng cũ khi người dùng nói rõ.
6. Xác nhận ngắn: *"Em ghi rồi ạ."* Nếu `cua-toi/.git` tồn tại: `git -C cua-toi add -A && git -C cua-toi commit -m "ghi-nho: <tóm tắt 5 chữ>"`.
