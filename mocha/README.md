# mocha/ — huấn luyện agent phòng ban MOCHA

Phần **chung** để agent các phòng tự học và tự soạn câu hỏi nhận việc. Không chứa dữ liệu phòng, token, ID nhóm hay tên bot (những thứ đó nằm trong `cua-toi/MOCHA_AI/` trên từng máy, không lên repo).

| File | Vai trò |
|---|---|
| `00_CHUNG/tu-hoc.md` | Luật tự học: mời nhận việc, tự ghi sổ việc, học từ lần sửa, hỏi bù, đóng gói việc lặp lần 3, rà tuần; ưu tiên luật riêng của phòng khi trái nhau |
| `00_CHUNG/setup-phong.md` | Quy trình nhận việc: đọc phòng → nghiên cứu + tư duy hệ thống soạn câu riêng → cho chọn hỏi trực tiếp / điền Excel |
| `00_CHUNG/cau-hoi-nhan-viec.csv` | Ngân hàng câu hỏi chung (+ câu riêng mẫu dự phòng) |
| `00_CHUNG/phieu.py` | Tạo / đọc phiếu Excel, liệt kê câu của phòng (chỉ cần Python có sẵn) |
| `00_CHUNG/khung-theo-phong.md` | Khung chuẩn MOCHA V3 rút theo từng phòng |
| `00_CHUNG/cai-dat/them-tu-hoc.sh` | Bật/cập nhật luật cho mọi phòng (chép vào `.luat-chung/` của phòng, chỉ thêm) |
| `cap-nhat-mocha.sh` | Chép các file trên vào `cua-toi/MOCHA_AI/00_CHUNG/` (sao lưu bản cũ) rồi chạy `them-tu-hoc.sh` |

**Luồng cập nhật:** sửa file ở đây → đưa lên `main` → máy dùng bấm `CAP-NHAT.command` → tự chạy `cap-nhat-mocha.sh` → đóng cửa sổ bot, bấm `KHOI-DONG-TAT-CA.command`.
Đây là **nguồn gốc duy nhất** của các file trên; bản trong `cua-toi/MOCHA_AI/00_CHUNG/` là bản chép, sửa tay ở đó sẽ bị thay (có sao lưu trong `00_CHUNG/sao-luu/`).
