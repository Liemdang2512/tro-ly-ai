# 20 · Mô hình huấn luyện — Prompt được nâng cấp bằng số đo, không bằng cảm giác

Mỗi vòng: thu → rút luật → viết vào prompt → kiểm thử → dùng thật → đo → Sếp duyệt. Chỉ phát hành bản mới khi có chỉ số tốt lên và không chỉ số nào xấu đi.

Nguồn: Sổ tay làm việc với Sếp v2.1 (12/10/2026), đúc kết từ 430 tin nhắn Telegram của Sếp #260 → #1413 (02/10 → 12/10/2026).

## Vòng 7 bước

| # | Bước | Làm gì | Ghi ở |
|---|---|---|---|
| 1 | Thu | Tin nhắn Sếp, lỗi, kết quả kiểm thử trong ngày | Nhật ký phiên |
| 2 | Rút luật | Mỗi lần Sếp sửa → 1 luật có mã L.., kèm tin gốc | 16_SO_TAY_LUAT |
| 3 | Viết vào prompt | Sửa prompt, tăng phiên bản, ghi khác gì bản cũ | 14_PROMPT_TONG |
| 4 | Kiểm thử | Chạy 10 tình huống T01–T10 (+ tình huống mới), chấm đạt / không | 19_KIEM_THU |
| 5 | Dùng thật | 1 tuần làm việc với prompt mới | — |
| 6 | Đo | 6 chỉ số của bảng điểm; báo 17:47 hằng ngày, rà thứ Hai | 20_MO_HINH_HUAN_LUYEN |
| 7 | Sếp duyệt | Có chỉ số tốt lên và không chỉ số nào xấu đi → phát hành cho mọi agent | 09_CAI_TIEN_HANG_NGAY |

## Bảng điểm theo phiên bản

| Chỉ số | Cách đo | v1.0 · đo từ 02–12/10 | Mục tiêu v2.1 | v2.1 · đo sau 1 tuần |
|---|---|---|---|---|
| Tình huống kiểm thử đạt ngay lần đầu | 10 tình huống T01–T10, chấm đạt / không đạt | 2/10 = 20% | ≥ 8/10 | Chưa đo |
| Chỗ hở em tự phát hiện | lỗi em tự bắt ÷ tổng lỗi trong nhật ký | 2/26 = 8% | ≥ 80% | Chưa đo |
| Lần Sếp phải sửa / ngày làm việc | lỗi do Sếp phát hiện ÷ số ngày có trao đổi | 24/8 = 3,0 | ≤ 0,5 | Chưa đo |
| Lần Sếp nhắc "kiểm tra lại" | đếm tin có từ khoá [Ước] | 20 tin / 8 ngày | 0 – em tự gửi kết quả kiểm | Chưa đo |
| Lần Sếp gọi "Alo / Đâu r" | đếm tin | 10 tin | 0 – xác nhận + giờ dự kiến | Chưa đo |
| Thời gian từ lúc giao đến lúc Sếp OK | giờ tin giao → giờ tin OK, ghi trong nhật ký phiên | Chưa đo (chưa ghi giờ giao / OK) | Bắt đầu đo từ v2.1 | Chưa đo |

Mốc v1.0 lấy từ nhật ký lỗi và 430 tin nhắn thật [Nguồn: tin nhắn #260 → #1418]. Cột v2.1 điền sau 1 tuần dùng thật, báo trong rà tuần thứ Hai.
