# mocha/ — huấn luyện agent phòng ban MOCHA

Phần **chung** để agent các phòng tự học và tự soạn câu hỏi nhận việc. Không chứa dữ liệu phòng, token, ID nhóm hay tên bot (những thứ đó nằm trong `cua-toi/MOCHA_AI/` trên từng máy, không lên repo).

| File | Vai trò |
|---|---|
| `00_CHUNG/tu-hoc.md` | Luật tự học: mời nhận việc, tự ghi sổ việc, học từ lần sửa, hỏi bù, đóng gói việc lặp lần 3, rà tuần; ưu tiên luật riêng của phòng khi trái nhau |
| `00_CHUNG/setup-phong.md` | Quy trình nhận việc: đọc phòng → nghiên cứu + tư duy hệ thống soạn câu riêng → cho chọn hỏi trực tiếp / điền Excel |
| `00_CHUNG/cau-hoi-nhan-viec.csv` | Ngân hàng câu hỏi chung (+ câu riêng mẫu dự phòng) |
| `00_CHUNG/phieu.py` | Tạo / đọc phiếu Excel, liệt kê câu của phòng (chỉ cần Python có sẵn) |
| `00_CHUNG/khung-theo-phong.md` | Khung chuẩn MOCHA V3 rút theo từng phòng |
| `00_CHUNG/kiem-chung.md` | Kiểm chứng độc lập: AI thứ hai kiểm file/nghiên cứu trước khi giao (câu lệnh hệ thống, cách gọi, cấu trúc báo cáo kiểm) |
| `00_CHUNG/mau-mo-hinh-kinh-doanh.md`, `mau-phong-cach-thuong-hieu.md` | Bản mẫu hồ sơ công ty (M1–M10). Bản thật ở `cua-toi/MOCHA_AI/00_CHUNG/`, không lên repo |
| `00_CHUNG/lam-viec-voi-sep/` | Sổ tay làm việc với Sếp v2.1: prompt tổng bản đầy đủ (tự nạp vào mọi phòng, luật nền bắt buộc), sổ luật, nhật ký lỗi, kiểm thử, quyết định đã chốt. Đọc `00_MUC_LUC.md` trước |
| `00_CHUNG/cai-dat/them-tu-hoc.sh` | Bật/cập nhật luật cho mọi phòng (chép vào `.luat-chung/` của phòng, chỉ thêm) |
| `cap-nhat-mocha.sh` | Chép các file trên vào `cua-toi/MOCHA_AI/00_CHUNG/` (sao lưu bản cũ), chạy `them-tu-hoc.sh`, và gắn lời nhắn khởi động vào `chay.sh` để bot tự đặt lịch báo cáo 17:47 / thứ Hai 08:33 (`tu-hoc.md` vòng 7) |

**Luồng cập nhật:** sửa file ở đây → đưa lên `main` → máy dùng bấm `CAP-NHAT.command` (không cần tắt bot) → tự chạy `cap-nhat-mocha.sh` → có thay đổi thì tự tắt và mở lại các bot phòng đang chạy. Bot nào đang tắt thì vẫn tắt; mở bằng `KHOI-DONG-TAT-CA.command` khi cần.
Đây là **nguồn gốc duy nhất** của các file trên; bản trong `cua-toi/MOCHA_AI/00_CHUNG/` là bản chép, sửa tay ở đó sẽ bị thay (có sao lưu trong `00_CHUNG/sao-luu/`).
