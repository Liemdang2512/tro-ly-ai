---
name: bao-gia
description: Làm báo giá. Gọi khi người dùng nói "làm báo giá cho …", "báo giá …"
---

# Kỹ năng: Làm báo giá
**Gọi khi:** "làm báo giá cho …", "báo giá …"
**Loại việc:** bao-gia

## Cách dùng
- **Nói:** "làm báo giá cho [khách], [sản phẩm/dịch vụ], [số lượng]"
- **Cần chuẩn bị:** bảng giá hiện hành và mẫu báo giá của công ty (để trong thư mục kỹ năng này, hoặc dán vào), chính sách chiết khấu
- **Kết quả:** bản báo giá theo mẫu công ty, lưu trong `san-pham/` của dự án khách đó
- **Ví dụ:** {{VI_DU}}

## File đi kèm
<!-- File nằm cùng thư mục kỹ năng này. Liệt kê để trợ lý biết mở file nào; chưa có thì ghi "chưa có". -->
{{FILE_DI_KEM}}

## Đầu vào cần có
Khách hàng · sản phẩm/dịch vụ · số lượng · bảng giá hiện hành. Thiếu bảng giá → hỏi, **không tự đặt giá**.

## Các bước
1. Lấy giá **chỉ** từ bảng giá hiện hành, ghi rõ bảng giá ngày nào.
2. Tính: số lượng × đơn giá → chiết khấu → VAT → tổng.
3. Điền: hiệu lực báo giá · điều kiện thanh toán · thời gian giao.
4. Tự cộng lại tổng một lần nữa trước khi đưa.
5. Liệt kê những điểm đang **hứa với khách** (giá, giao hàng, bảo hành) để người dùng xem lại.

## Kiểm tra trước khi giao
- [ ] Giá, chiết khấu, điều khoản đúng tài liệu hiện hành, không tự bịa
- [ ] Tổng đã cộng lại
- [ ] Tên khách, ngày, số lượng đúng
- [ ] Không hứa ngoài chính sách công ty
- [ ] Chỉ soạn sẵn, người dùng tự gửi
