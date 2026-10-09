# Kỹ năng: Làm báo giá
**Gọi khi:** "làm báo giá cho …", "báo giá …"
**Loại việc:** bao-gia

## Cách dùng
- **Nói:** "làm báo giá cho [khách], [sản phẩm/dịch vụ], [số lượng]"
- **Cần chuẩn bị:** bảng giá hiện hành (để trong `cua-toi/tai-lieu/` hoặc dán vào), chính sách chiết khấu, mẫu báo giá cũ nếu có
- **Kết quả:** bản báo giá theo mẫu công ty, lưu trong `san-pham/` của dự án khách đó
- **Ví dụ:** {{VI_DU}}

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
