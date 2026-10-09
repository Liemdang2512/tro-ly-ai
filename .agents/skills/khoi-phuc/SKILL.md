---
name: khoi-phuc
description: Đưa sổ nhớ (hoặc một file trong sổ) về bản cũ một cách an toàn, không mất lịch sử. Dùng khi người dùng nói "khôi phục", "lấy lại bản hôm qua", "ghi nhầm rồi", "trả lại như cũ".
---

# Khôi phục sổ

Chỉ dùng `scripts/khoi-phuc.sh`. **Không** tự chạy `git reset`, `git checkout`, `git clean`, `git rebase` trong `cua-toi/`. Các lệnh đó có thể xóa mất phần ghi sau thời điểm khôi phục.

1. **Xác định phạm vi:** cả sổ hay một file (ví dụ `du-an/01_bao-gia/ban-giao.md`)? Về thời điểm nào?
2. **Xem lịch sử:** `bash scripts/khoi-phuc.sh lich-su [đường dẫn]`. Đưa người dùng tối đa 5 mốc gần thời điểm họ nói, viết bằng lời thường: "09:30 hôm qua — chốt phiên báo giá".
3. **Cho xem trước** khi khôi phục một file: `bash scripts/khoi-phuc.sh xem <mã> <đường dẫn>`, rồi tóm tắt khác biệt so với hiện tại.
4. **Hỏi lại rõ ràng:** *"Em sẽ đưa <file / cả sổ> về bản lúc <giờ>. Phần ghi sau thời điểm đó trong <file> sẽ bị thay, nhưng vẫn còn trong lịch sử nếu cần lấy lại. Làm nhé?"*
5. Người dùng đồng ý → `bash scripts/khoi-phuc.sh ve <mã> [đường dẫn]`. Script tự lưu bản hiện tại trước, rồi mới khôi phục.
6. Ghi một dòng vào nhật ký phiên: "Khôi phục <file> về bản <giờ>".

Lưu ý:
- File tạo **sau** thời điểm khôi phục vẫn giữ nguyên, không bị xóa.
- Tài liệu gốc trong `tai-lieu/` không nằm trong lịch sử nên không khôi phục được. Báo rõ cho người dùng nếu họ hỏi.
- Máy chưa có git thì không khôi phục được. Báo người dùng và gợi ý nhờ người quản trị.
