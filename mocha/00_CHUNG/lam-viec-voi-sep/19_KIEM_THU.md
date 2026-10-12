# 19 · Bộ kiểm thử — 10 tình huống thật – trợ lý đúng phải làm gì

Lấy từ chính tin nhắn của Sếp. Cột cuối là kết quả lần đầu thực tế của em trong 02–12/10: 2/10 đạt. Mỗi bản prompt mới chạy lại 10 tình huống này trước khi phát hành.

Nguồn: Sổ tay làm việc với Sếp v2.1 (12/10/2026), đúc kết từ 430 tin nhắn Telegram của Sếp #260 → #1413 (02/10 → 12/10/2026).

| Mã | Sếp nói | Đúng phải làm | Không đạt nếu | Luật | Lần đầu thực tế |
|---|---|---|---|---|---|
| T01 #262 | Bạn gửi nhiều sheet quá tôi đọc thì hiểu sơ nhưng mà không biết bắt đầu từ đâu | Gom về 1 file / 1 link, có mục "bắt đầu từ đây", checklist việc theo thứ tự | Gửi thêm sheet, giải thích thêm | L10 · L15 | Không đạt (E01) |
| T02 #1153 | Tôi đang hơi hoang mang… bản đa dự án không hiểu bắt đầu từ đâu | Dừng mở rộng, thu về 1 dự án, 1 điểm bắt đầu, 1 ví dụ; hỏi lại bằng giả thuyết | Giải thích thêm bản đa dự án | L04 · L30 | Không đạt (E16) |
| T03 #559 | Cho 1 cái form excel quy trình chuẩn… đừng diễn giải nữa action luôn | Trả ngay file form điền được, giải thích tối đa 3 dòng | Trả lời bằng đoạn giải thích | L09 | Không đạt (E06) |
| T04 #637 | Sao flow là đi từ kế hoạch mục tiêu → kết quả? Hiện đang như vận đơn | Vẽ lại theo mục tiêu → kết quả, giải thích vì sao bản cũ sai | Sửa màu / chữ, giữ cấu trúc cũ | L03 | Không đạt (E08) |
| T05 #769 | Hãy kiểm tra lại 1 lần nữa chuyên nghiệp | Gửi kết quả kiểm (số phép, lỗi) + chỗ hở tự thấy (vd thiếu định mức G00–G10) trước khi Sếp nêu | Trả lời "đã chuẩn" không kèm chứng cứ | L21 · L26 | Không đạt (E10) |
| T06 #977 | Bạn tự gợi ý phương án tốt nhất cho 7 điểm, trên benchmark, rồi làm chốt | Đề xuất 1 phương án mỗi điểm có căn cứ, gom thành 1 lần chốt | Hỏi lại Sếp từng điểm | L07 · L19 | Đạt (#987 "Ok chạy chốt đi") |
| T07 #1041 | Gửi duyệt… duyệt OK rồi mới đưa hẳn vào file tổng | Dựng bản riêng + link duyệt, không ghép file tổng | Ghép thẳng vào file tổng | L24 | Đạt (dùng lớp vá riêng) |
| T08 #1253 | Các cột dữ liệu đang hơi sơ sài hay ẩn khuất ở đâu mà tôi không biết | Mở rộng đủ trường + phép tính + bản final theo 8 tiêu chí làm kĩ, rồi tự rà phòng khác cùng lỗi | Chỉ thêm vài cột ở 1 màn | L11 · L26 | Không đạt (E20, lặp ở E22) |
| T09 #1220 | Thư viện phải có đủ biểu mẫu đi kèm không ghi chung chung… thiếu liên phòng | Biểu mẫu cụ thể từng quy trình + sơ đồ liên phòng bấm được + file Excel | Thêm danh mục tên biểu mẫu | L13 | Không đạt (E19, lặp ở E22) |
| T10 #1418 | Chỗ nhân sự sơ sài… full option, rà 1 lần nữa | Rà theo chuỗi chuẩn nhân sự đủ hạng mục + rà cả 8 phòng cùng tiêu chí, báo 1 lần | Chỉ thêm màn nhân sự Sếp vừa nêu | L13 · L26 | Không đạt lần đầu (E26) · đợt C xử lý |
