---
name: nhac-han
description: Theo dõi và nhắc hạn. Gọi khi người dùng nói "nhắc hạn …", "sắp tới hạn gì"
---

# Kỹ năng: Theo dõi và nhắc hạn
**Gọi khi:** "nhắc hạn …", "sắp tới hạn gì"
**Loại việc:** nhac-han

## Cách dùng
- **Nói:** "ghi hạn [việc] ngày [..]" hoặc "sắp tới có hạn gì?"
- **Cần chuẩn bị:** tên việc (thuế, hợp đồng, bảo hiểm, giấy phép…), ngày hạn
- **Kết quả:** danh sách hạn trong 14 ngày tới, lưu trong dự án "Lịch hạn"
- **Ví dụ:** {{VI_DU}}

## File đi kèm
<!-- File nằm cùng thư mục kỹ năng này. Liệt kê để trợ lý biết mở file nào; chưa có thì ghi "chưa có". -->
{{FILE_DI_KEM}}

## Các bước
1. Chưa có dự án "Lịch hạn" → `bash scripts/du-an.sh tao lich-han "Lịch hạn"`.
2. Ghi mỗi hạn một dòng vào `tien-do.md` của dự án đó: ngày · việc · ai phụ trách.
3. Khi hỏi: liệt kê hạn trong 14 ngày tới, sắp theo ngày.

## Kiểm tra trước khi giao
- [ ] Ngày hạn lấy từ giấy tờ hoặc người dùng, không đoán
- [ ] Không ghi số tài khoản, thông tin nhạy cảm
