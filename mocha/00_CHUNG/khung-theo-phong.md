# Khung chuẩn MOCHA theo từng phòng

Rút từ `KHUNG_CHUAN_AI_HOA_MOCHA_V3.xlsx` (sheet C, F, 05, 03, I). Agent dùng để soạn câu hỏi nhận việc **đúng ngữ cảnh MOCHA**.
Đây là **đề xuất của khung**, chưa phải sự thật của phòng — mọi con số/ngưỡng/người phải hỏi lại sếp xác nhận.

## Luật chung của khung (mọi phòng)
- 4 cái MỘT: một mã cho một thứ · một nơi nhập cho một con số · một người chịu trách nhiệm · một giờ cố định phải có số.
- Nhịp giờ cứng: 9h số dư đầu ngày · 16h chốt đề xuất chi · ads & đơn chốt trước 10h hôm sau · thứ 2 họp kế hoạch chi tuần · ngày 05 khoá sổ · ngày 25 ra P&L.
- 6 khoá xương sống mỗi giao dịch: pháp nhân · nhãn con · kênh · mã SP · mã chiến dịch · nhân viên (xem Sheet A khung).
- AI chỉ ĐỌC dữ liệu; mọi thay đổi đi qua người duyệt có tên. Không ghi thẳng vào danh mục, không chuyển tiền, không đăng nội dung chưa duyệt.
- Cấp tự động hoá: 0 thủ công · 1 trợ lý · 2 tự động quy trình · 3 agent thực thi có giới hạn · 4 tối ưu/đề xuất · 5 năng lực mới.
- Mỗi skill: Mục đích → Đầu vào → Các bước → Luật → Đầu ra mẫu → Kiểm tra → Người duyệt.
- Phiếu kiến thức 7 cột mỗi phòng cần: ① SOP các bước thật ② 3–5 ví dụ đầu ra tốt nhất ③ luật "nếu… thì…" ④ ngưỡng bằng số ⑤ công cụ + quyền đọc ⑥ người duyệt đầu ra AI.

## Dự án số hoá
**Kỹ năng AI khung đề xuất:**
- S01 Khảo sát 12 mục: Đi lần lượt 12 mục: hỏi theo Checklist, xin file theo mã D, chạy phép thử, chấm điểm, báo mục kế tiếp · dữ liệu: Sheet 01 · Checklist · Thu thập · duyệt: Trưởng dự án · bắt đầu khi: Ngay
**Điều lệ dự án (sheet D):** tên "MOCHA – Chuẩn hoá dữ liệu & AI hoá vận hành" · phạm vi 90 ngày đầu: Tài chính ↔ Bán hàng (FB tự vận hành + CSKH) · ngoài phạm vi: đổi phần mềm lớn/ERP · CEO điền: người tài trợ, trưởng dự án, mục tiêu nghiệm thu, ngân sách, ngày khởi động.
**RACI:** CEO (tài trợ, chốt mục tiêu/ngưỡng, ngồi buổi giải phẫu, ~3 giờ/tuần) · Trưởng dự án số hoá (điều phối B0–B8, báo 6 chỉ số, không kiêm người kiểm, ~20 giờ/tuần) · Người giữ mã (danh mục gốc, cấp mã, phép thử, báo thẳng CEO, không thuộc kế toán) · Người kiểm (kiểm 20 khoản chi lớn nhất/tháng) · Đầu mối mỗi phòng (file, SOP, duyệt skill phòng mình, ~2 giờ/tuần) · AI (đọc, dựng bảng, đề xuất; không ghi thẳng danh mục, không chuyển tiền, không đăng nội dung chưa duyệt).
**5 cổng nghiệm thu:** 1 Khởi động (điều lệ, 3 vai có tên, 1 mục tiêu số) · 2 Hiện trạng (biết từng con số ở đâu, ai giữ; đủ file thô 3 tháng) · 3 Quy trình & mã (SOP ký; phép thử 01–08 = 0 lỗi) · 4 Tự động (ngưỡng bằng số; ≥ 90% dữ liệu tự cập nhật đúng hạn) · 5 AI vận hành (skill pilot đúng ≥ 95%, giờ tiết kiệm đo được, bản tin 9h chạy đều). Người ký: CEO.
**6 chỉ số dự án báo CEO mỗi tháng** (không ai báo = dự án đã dừng): lỗi phép thử tồn = 0 · mã cấp sai = 0 · bộ dữ liệu đúng hạn ≥ 95% · khoản chi đủ chuỗi DX→LC→BT 100% · giờ copy-dán giảm ≥ 50% · số skill đang dùng theo kế hoạch.
**Lộ trình 6 giai đoạn (~14 tuần, sheet 02, không chạy 2 GĐ cùng lúc):** GĐ01 mở sổ quyết định (tuần 1) → GĐ02 kiểm kê thô & đo độ bẩn, thu file D01–D29 (tuần 2–3) → GĐ03 giải phẫu từng phòng, mỗi phòng 90 phút 8 câu Q1–Q8, chấm /24 (tuần 4–5) → GĐ04 bộ chiều & 15 bộ mã, phép thử 01–05 = 0 (tuần 6–9) → GĐ05 nối quy trình bằng chứng từ có mã, 4 đợt: tiền ra → đơn & tiền vào → hàng → người (tuần 10–14) → GĐ06 bộ kiểm chạy mỗi đêm & 6 chỉ số (từ tuần 8).
**Khung 12 mục (sheet 01):** NỀN 1 pháp nhân · 2 sơ đồ tổ chức · 3 phòng ban · 4 bộ mã · 5 phân quyền → LUỒNG 6 tài chính · 7 hàng-kho · 8 kênh bán & khách · 9 quy trình liên phòng · 10 công cụ → NGỌN 11 KPI & kế hoạch · 12 báo cáo. Mỗi mục: HỎI → XIN FILE → CHUẨN HOÁ → KIỂM; chấm 0–3 (tổng /36).
**Rủi ro hay gặp:** mua phần mềm trước khi sạch dữ liệu · người giữ mã kiêm việc "khi rảnh" · cho AI ghi thẳng vào dữ liệu · làm tất cả phòng cùng lúc · dữ liệu khách hàng lên AI cloud khi chưa chốt chính sách.
**Mục tiêu 12 tháng (sheet A):** bản tin AI 9h cho CEO ≥ 95% ngày · giờ copy-dán-đối chiếu giảm ≥ 50% · P&L nhãn × kênh ra ngày 05 thay vì 25+ · lệch đối soát < 0,5% · ≥ 50% việc lặp lại chạy không cần người khởi động.

## Người giữ mã
**Kỹ năng AI khung đề xuất:**
- S02 Kiểm dữ liệu mỗi đêm: Chạy 20 phép thử, sáng 07:30 gửi danh sách dòng lỗi (chỉ khi có lỗi) · dữ liệu: Danh mục gốc + 6 bảng giao dịch · duyệt: Người kiểm · bắt đầu khi: Mục 4 ≥ 2
- S14 Cấp mã đề xuất: Nhận phiếu xin mã, đề xuất mã theo cú pháp, tra trùng; người giữ mã duyệt · dữ liệu: Danh mục gốc · duyệt: Người giữ mã · bắt đầu khi: Mục 4 = 3
**Việc cần tự động hoá (sheet F):**
- Kiểm dữ liệu mỗi đêm (Ngày, ~3 giờ/tuần): 02:00 → chạy 20 phép thử → 07:30 báo lỗi · dữ liệu: Danh mục gốc + giao dịch
**KPI khung đề xuất (sheet 05):**
- Lỗi phép thử tồn: Tổng dòng vi phạm 20 phép thử · nguồn Bộ kiểm T1 · Ngày · đọc để: Sửa dữ liệu
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục pháp nhân: nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã PN, tên, MST, vai trò, TK ngân hàng
- Danh mục nhãn mẹ / nhãn con: nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã, tên, nhãn mẹ, pháp nhân sở hữu, ngành
- Danh mục sản phẩm (SKU) + ánh xạ mã sàn: nhập ở File danh mục gốc · owner Người giữ mã (theo phiếu xin) · hạn Trong ngày · cột bắt buộc: mã SP, tên, nhóm, nhãn con, quy cách, mã trên từng sàn, giá niêm yết · KHÔNG có giá vốn & tồn
- Danh mục nhà cung cấp (VEN/SUB/SRV, gồm KOL): nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã, loại, tên, MST, điều khoản TT
- Danh mục khoản mục chi phí: nhập ở File danh mục gốc · owner Kế toán + người giữ mã · hạn — · cột bắt buộc: mã, nhóm, dòng P&L · nhãn KHÔNG nằm trong mã
- Danh mục kho & kênh/gian hàng: nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã, tên, pháp nhân đứng tên, nền tảng
- Danh mục phòng ban & nhân viên: nhập ở File danh mục gốc (HR cấp NV) · owner HR + người giữ mã · hạn Trong ngày · cột bắt buộc: mã NV, phòng, quản lý trực tiếp, pháp nhân ký HĐ
- Bảng ánh xạ mã cũ → mới: nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã cũ, nguồn, mã mới, ngày hiệu lực
- Sổ quyết định: nhập ở ECOM 01_SO_QUYET_DINH · owner CEO / người giữ mã · hạn Trong ngày · cột bắt buộc: số, ngày, nội dung, phạm vi, người ký, phép thử

## Tài chính
**Kỹ năng AI khung đề xuất:**
- S03 Đối soát sao kê ↔ sổ quỹ ↔ chứng từ: Ghép sao kê với đề xuất/lệnh chi/bút toán; báo dòng lệch, dòng không mã · dữ liệu: SAO_KE · GD_CHI · duyệt: Kế toán trưởng · bắt đầu khi: Mục 6 ≥ 2
**Việc cần tự động hoá (sheet F):**
- Đối soát sao kê & số dư 9h (Ngày, ~3 giờ/tuần): Sao kê về → AI ghép chứng từ, báo dòng không mã; 9h gửi số dư · dữ liệu: SAO_KE · GD_CHI
- Xếp lịch chi tuần (Tuần, ~2 giờ/tuần): Thứ 2 → AI xếp ưu tiên chi theo số dư & hạn TT → CEO duyệt · dữ liệu: GD_CHI · công nợ
**KPI khung đề xuất (sheet 05):**
- Số dư báo đúng 9h: Số ngày báo trước 9h ÷ ngày làm việc · nguồn SAO_KE · Ngày · đọc để: Lịch chi
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Sao kê ngân hàng: nhập ở Internet banking (tải tự động/ hằng ngày) · owner Tài chính · hạn 09:00 · cột bắt buộc: ngày, TK, số tiền, nội dung, mã chứng từ
- Số dư đầu ngày theo pháp nhân: nhập ở TÍNH từ SAO_KE · owner Tài chính · hạn 09:00 · cột bắt buộc: —
- Dòng tiền 13 tuần: nhập ở TÍNH từ GD_CHI, GD_TIENVAO, công nợ · owner Tài chính · hạn Thứ 2 · cột bắt buộc: —

## CEO
**Kỹ năng AI khung đề xuất:**
- S04 Bản tin sáng 9h: Số dư theo pháp nhân · đơn & DT hôm qua · ads vs định mức · việc chờ duyệt · cảnh báo · dữ liệu: SAO_KE · GD_DONHANG · GD_ADS · Barem V5 · duyệt: CEO · bắt đầu khi: B6 xong
- S15 Hỏi đáp điều hành: Trả lời "nhãn nào nuôi nhãn nào", "tuần tới cần bao nhiêu tiền", "vì sao ROAS giảm" – kèm đường dẫn về dòng gốc · dữ liệu: Toàn bộ lớp báo cáo · duyệt: CEO · bắt đầu khi: Mục 11, 12 = 3
**Việc cần tự động hoá (sheet F):**
- Bản tin sáng & hỏi đáp điều hành (Ngày, ~3 giờ/tuần): 09:00 → AI gửi bản tin; CEO hỏi trực tiếp, AI trả lời kèm dòng gốc · dữ liệu: Toàn bộ
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Đối soát sàn / COD (tiền vào): nhập ở Báo cáo đối soát sàn + hãng VC · owner Kế toán · hạn Trong 2 ngày sau kỳ · cột bắt buộc: kỳ, mã đơn, số tiền, phí bị trừ, TK nhận
- Sao kê ngân hàng: nhập ở Internet banking (tải tự động/ hằng ngày) · owner Tài chính · hạn 09:00 · cột bắt buộc: ngày, TK, số tiền, nội dung, mã chứng từ
- Lương, thưởng, hoa hồng: nhập ở Bảng lương · owner HR · hạn Ngày 05 · cột bắt buộc: kỳ, mã NV, phòng, nhãn con, lương cứng, hoa hồng, BH
- Số dư đầu ngày theo pháp nhân: nhập ở TÍNH từ SAO_KE · owner Tài chính · hạn 09:00 · cột bắt buộc: —
- Dòng tiền 13 tuần: nhập ở TÍNH từ GD_CHI, GD_TIENVAO, công nợ · owner Tài chính · hạn Thứ 2 · cột bắt buộc: —
- P&L nhãn con × kênh: nhập ở TÍNH từ các bảng giao dịch · owner Kế toán · hạn Ngày 25 · cột bắt buộc: —
- Kế hoạch kinh doanh – barem (KH / TT / ĐM): nhập ở Barem V5: Tab 1 nhập, Tab 2–4 công thức · owner PM · CEO duyệt · hạn Ngày 05 · cột bắt buộc: Xem file Barem V5
- Sổ quyết định: nhập ở ECOM 01_SO_QUYET_DINH · owner CEO / người giữ mã · hạn Trong ngày · cột bắt buộc: số, ngày, nội dung, phạm vi, người ký, phép thử

## Ads
**Kỹ năng AI khung đề xuất:**
- S05 Báo cáo & cảnh báo ads ngày: ROAS, CPA, CPL theo nhãn con × kênh × chiến dịch; báo khi lệch định mức hoặc giải ngân > đặt thầu · dữ liệu: GD_ADS · GD_DONHANG · Barem V5 · duyệt: Trưởng MKT · bắt đầu khi: Mục 8 ≥ 2
**Việc cần tự động hoá (sheet F):**
- Theo dõi campaign/adset/ad (Liên tục, ~3 giờ/tuần): Mỗi giờ → AI đọc chỉ số, so định mức → cảnh báo; tắt ad vượt CPA trong hạn mức; Lead duyệt scale · dữ liệu: GD_ADS
- Báo cáo ads ngày (Ngày, ~2 giờ/tuần): 10:00 → AI gom đa kênh theo nhãn con × chiến dịch → gửi Lead · dữ liệu: GD_ADS · GD_DONHANG
- Phân bổ ngân sách giữa kênh/nguồn (Tuần, ~4 giờ/tuần): Thứ 2 → AI tính ROAS biên từng nguồn, đề xuất chia NS trong trần → Lead chọn · dữ liệu: GD_ADS · Barem V5
**KPI khung đề xuất (sheet 05):**
- ROAS: DT (trừ CSKH) ÷ chi ads · nguồn GD_ADS + GD_DONHANG · Ngày · đọc để: Tăng/giảm ngân sách theo nguồn
- CPA: chi ads ÷ (đơn − đơn mua lại) · nguồn GD_ADS + GD_DONHANG · Ngày · đọc để: Cắt / nhân chiến dịch
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Chi phí quảng cáo: nhập ở Ads Manager từng nền tảng (xuất/connector) · owner Ads · hạn 10:00 hôm sau · cột bắt buộc: ngày, TK ads, kênh, mã chiến dịch, nhãn con, chi phí, đơn ghi nhận
- Booking KOL/KOC & media: nhập ở Tracker booking · owner Booking · hạn Trong ngày · cột bắt buộc: ngày chốt, mã KOL, tier, SKU, giá, video cam kết/nhận, link, đã TT
- Tồn kho hiện tại: nhập ở TÍNH từ GD_NHAPXUAT – không nhập tay · owner Kho · hạn — · cột bắt buộc: —

## Sale
**Kỹ năng AI khung đề xuất:**
- S06 Phân data & kịch bản chốt: Chia lead theo luật, gợi ý kịch bản theo tệp/sản phẩm, báo tỷ lệ chốt từng người · dữ liệu: Pancake/CRM · kịch bản mẫu tốt nhất · duyệt: Trưởng Sale · bắt đầu khi: SOP Sale xong
**Việc cần tự động hoá (sheet F):**
- Chấm điểm & chia lead (Liên tục, ~3 giờ/tuần): Lead mới → AI chấm điểm, chia theo luật, gợi ý kịch bản · dữ liệu: Pancake/CRM
- Tóm tắt hội thoại & nhắc follow-up (Ngày, ~3 giờ/tuần): Hết ca → AI tóm tắt, tạo việc follow-up · dữ liệu: Pancake
**KPI khung đề xuất (sheet 05):**
- Tỷ lệ chốt sale: Đơn ÷ lead liên hệ được · nguồn GD_DONHANG + CRM · Ngày · đọc để: Phân data, đào tạo
- Tỷ lệ quay vòng: Khách quay lại ÷ tổng data · nguồn GD_CSKH + GD_DONHANG · Tháng · đọc để: Kịch bản chăm sóc
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục khách hàng: nhập ở OMS / CRM (máy cấp) · owner CSKH · hạn — · cột bắt buộc: mã KH, SĐT, nguồn, ngày mua đầu
- Giao dịch đơn hàng (kể cả hoàn): nhập ở OMS / Pancake / Seller Center · owner Vận hành sàn · Sale · hạn 23:00 chốt ngày · cột bắt buộc: ngày, mã đơn, kênh, mã SP, SL, giá, nhãn con, mã chiến dịch, NV chốt, mã KH, trạng thái

## CSKH
**Kỹ năng AI khung đề xuất:**
- S07 Lịch chăm quay vòng: Lập danh sách khách đến chu kỳ mua lại mỗi ngày, gợi ý ưu đãi, đo tỷ lệ chốt CSKH · dữ liệu: GD_DONHANG · GD_CSKH · giả định quay vòng · duyệt: Trưởng CSKH · bắt đầu khi: Mã khách hàng chuẩn
**Việc cần tự động hoá (sheet F):**
- Trả lời cấp 1, tra đơn (Liên tục, ~6 giờ/tuần): Tin nhắn vào → AI trả lời FAQ/tra đơn; khiếu nại, hoàn tiền → người · dữ liệu: OMS · FAQ · chính sách
- Lịch chăm quay vòng (Ngày, ~3 giờ/tuần): 07:00 → AI lập danh sách khách tới chu kỳ + gợi ý ưu đãi → người gọi · dữ liệu: GD_DONHANG · GD_CSKH
**KPI khung đề xuất (sheet 05):**
- Tỷ lệ chốt sale: Đơn ÷ lead liên hệ được · nguồn GD_DONHANG + CRM · Ngày · đọc để: Phân data, đào tạo
- Tỷ lệ quay vòng: Khách quay lại ÷ tổng data · nguồn GD_CSKH + GD_DONHANG · Tháng · đọc để: Kịch bản chăm sóc
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục khách hàng: nhập ở OMS / CRM (máy cấp) · owner CSKH · hạn — · cột bắt buộc: mã KH, SĐT, nguồn, ngày mua đầu
- Nhật ký CSKH / cuộc gọi: nhập ở Tổng đài / CRM · owner CSKH · hạn Cuối ngày · cột bắt buộc: ngày giờ, mã KH, NV, thời lượng, kết quả, đơn mua lại

## Booking
**Kỹ năng AI khung đề xuất:**
- S08 Tracker booking & chấm winner: Theo dõi creator, hạn trả mẫu, usable; chấm tệp/tuyến/tier thắng; đề xuất book tiếp · dữ liệu: GD_BOOKING · GD_ADS · duyệt: Booking Lead · bắt đầu khi: Mã KOL + chiến dịch
**Việc cần tự động hoá (sheet F):**
- Sàng lọc & chấm KOL/KOC (Tuần, ~4 giờ/tuần): AI thu thập, chấm điểm theo tệp/tier → shortlist → người deal · dữ liệu: Danh mục KOL · GD_BOOKING
- Nhắc deadline & thu video (Ngày, ~2 giờ/tuần): Tới hạn → AI nhắc KOC, cập nhật tracker · dữ liệu: GD_BOOKING
**KPI khung đề xuất (sheet 05):**
- Booking / tuần · usable rate: creator ÷ tuần · video dùng ÷ video nhận · nguồn GD_BOOKING · Tuần · đọc để: Tệp/tuyến/tier nào giữ
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục nhà cung cấp (VEN/SUB/SRV, gồm KOL): nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã, loại, tên, MST, điều khoản TT
- Booking KOL/KOC & media: nhập ở Tracker booking · owner Booking · hạn Trong ngày · cột bắt buộc: ngày chốt, mã KOL, tier, SKU, giá, video cam kết/nhận, link, đã TT

## Media / Marketing
**Kỹ năng AI khung đề xuất:**
- S09 Brief nội dung & soát luật QC: Viết brief từ concept/hook thắng; soát claim mỹ phẩm/TPCN trước khi chạy · dữ liệu: Thư viện media · danh sách claim cấm · duyệt: Trưởng Media · bắt đầu khi: SOP Media xong
- S18 Sản xuất biến thể tự động: Footage thô → dựng, subtitle, resize, caption theo kênh, gắn mã concept (Pilot Line Nám) · dữ liệu: Drive media · thư viện concept · duyệt: Lead Media · bắt đầu khi: Pilot tuần 2
**Việc cần tự động hoá (sheet F):**
- Research concept win (Tuần, ~4 giờ/tuần): Video có kết quả → AI bóc hook/angle/offer/CTA của win/lose → thư viện concept có mã · dữ liệu: GD_ADS · thư viện media
- Brief & shot-list (Theo đợt, ~3 giờ/tuần): Concept duyệt → AI sinh kịch bản, bối cảnh, shot-list, caption → Lead duyệt, soát claim · dữ liệu: Thư viện concept · claim được phép
- Dựng, subtitle, resize, biến thể (Ngày, ~5 giờ/tuần): Footage thô vào thư mục → AI dựng & ra phiên bản theo kênh, gắn mã concept–campaign · dữ liệu: Drive media
**KPI khung đề xuất (sheet 05):**
- Booking / tuần · usable rate: creator ÷ tuần · video dùng ÷ video nhận · nguồn GD_BOOKING · Tuần · đọc để: Tệp/tuyến/tier nào giữ

## Kế toán
**Kỹ năng AI khung đề xuất:**
- S10 Đối soát sàn/COD & P&L nhãn × kênh: Ghép đơn giao thành công ↔ tiền về; dựng P&L theo 6 khoá · dữ liệu: GD_DONHANG · GD_TIENVAO · GD_CHI · duyệt: Kế toán trưởng · bắt đầu khi: Mục 6, 8 = 3
**Việc cần tự động hoá (sheet F):**
- Đối soát sàn / COD (Theo kỳ, ~4 giờ/tuần): File đối soát về → AI ghép đơn ↔ tiền → báo lệch · dữ liệu: GD_DONHANG · GD_TIENVAO
- P&L nhãn × kênh (Tháng, ~6 giờ/tuần): Khoá sổ → AI dựng P&L theo 6 khoá → kế toán trưởng duyệt · dữ liệu: Mọi bảng giao dịch
**KPI khung đề xuất (sheet 05):**
- Ngày khoá sổ: Ngày khoá sổ tháng trước · nguồn Sổ KT · Tháng · đọc để: Đúng mốc 05
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục pháp nhân: nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã PN, tên, MST, vai trò, TK ngân hàng
- Danh mục khoản mục chi phí: nhập ở File danh mục gốc · owner Kế toán + người giữ mã · hạn — · cột bắt buộc: mã, nhóm, dòng P&L · nhãn KHÔNG nằm trong mã
- Đối soát sàn / COD (tiền vào): nhập ở Báo cáo đối soát sàn + hãng VC · owner Kế toán · hạn Trong 2 ngày sau kỳ · cột bắt buộc: kỳ, mã đơn, số tiền, phí bị trừ, TK nhận
- Đề xuất → Lệnh chi → Bút toán: nhập ở Form đề xuất chi (1 nơi duy nhất) + phần mềm KT · owner Phòng đề xuất · người duyệt · kế toán · hạn 16:00 chốt ĐX · cột bắt buộc: mã DX, phòng, khoản mục, nhãn con, số tiền, người duyệt, căn cứ
- P&L nhãn con × kênh: nhập ở TÍNH từ các bảng giao dịch · owner Kế toán · hạn Ngày 25 · cột bắt buộc: —

## Kho
**Kỹ năng AI khung đề xuất:**
- S11 Đề xuất nhập & cảnh báo tồn: Đề xuất đơn mua theo tồn + tốc độ bán; cảnh báo sắp hết (dừng ads), cận date · dữ liệu: GD_NHAPXUAT · GD_DONHANG · duyệt: Trưởng Kho · bắt đầu khi: Mục 7 ≥ 2
**Việc cần tự động hoá (sheet F):**
- Đề xuất nhập hàng (Tuần, ~2 giờ/tuần): AI tính tồn + tốc độ bán + lead time → đề xuất PO → thu mua duyệt · dữ liệu: GD_NHAPXUAT · GD_DONHANG
- Cảnh báo sắp hết / cận date (Ngày, ~1 giờ/tuần): Tồn < ngưỡng → báo Ads dừng/giảm; cận date → đề xuất xả · dữ liệu: GD_NHAPXUAT
**KPI khung đề xuất (sheet 05):**
- Lệch tồn sổ – thực: |tồn sổ − tồn kiểm| ÷ tồn sổ · nguồn GD_NHAPXUAT + kiểm kê · Tháng · đọc để: Siết quy trình lô
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục kho & kênh/gian hàng: nhập ở File danh mục gốc · owner Người giữ mã · hạn Trong ngày · cột bắt buộc: mã, tên, pháp nhân đứng tên, nền tảng
- Nhập – xuất kho theo lô: nhập ở Phần mềm/ file kho · owner Kho · hạn Trong ngày · cột bắt buộc: ngày, phiếu, mã SP, số lô, HSD, kho, SL, đơn giá nhập
- Tồn kho hiện tại: nhập ở TÍNH từ GD_NHAPXUAT – không nhập tay · owner Kho · hạn — · cột bắt buộc: —

## PM
**Kỹ năng AI khung đề xuất:**
- S12 Lập & kiểm barem kế hoạch: Từ mục tiêu → nền tảng → nguồn → NS → KPI → định biên; kiểm 11 ô; đề xuất áp NS GĐ2 theo số test · dữ liệu: Barem V5 · duyệt: CEO · bắt đầu khi: B5 xong
**Việc cần tự động hoá (sheet F):**
- Lập & kiểm barem kế hoạch (Tháng, ~4 giờ/tuần): Ngày 05 → AI cập nhật TT, kiểm 11 ô, đề xuất áp NS GĐ sau · dữ liệu: Barem V5
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Chi phí quảng cáo: nhập ở Ads Manager từng nền tảng (xuất/connector) · owner Ads · hạn 10:00 hôm sau · cột bắt buộc: ngày, TK ads, kênh, mã chiến dịch, nhãn con, chi phí, đơn ghi nhận
- Nhật ký CSKH / cuộc gọi: nhập ở Tổng đài / CRM · owner CSKH · hạn Cuối ngày · cột bắt buộc: ngày giờ, mã KH, NV, thời lượng, kết quả, đơn mua lại
- KPI ngày Ads / Sale / CSKH / Booking: nhập ở TÍNH từ GD_ADS, GD_DONHANG, GD_CSKH, GD_BOOKING · owner PM · hạn 10:00 hôm sau · cột bắt buộc: —
- Kế hoạch kinh doanh – barem (KH / TT / ĐM): nhập ở Barem V5: Tab 1 nhập, Tab 2–4 công thức · owner PM · CEO duyệt · hạn Ngày 05 · cột bắt buộc: Xem file Barem V5

## HR / Nhân sự
**Kỹ năng AI khung đề xuất:**
- S13 Định biên & JD: Tính FTE từ khối lượng việc; soạn JD từ SOP · dữ liệu: Barem V5 · SOP · duyệt: HR · bắt đầu khi: SOP các phòng
**Việc cần tự động hoá (sheet F):**
- Định biên & JD (Quý, ~3 giờ/tuần): Khối lượng việc → AI tính FTE, soạn JD từ SOP → HR duyệt · dữ liệu: Barem V5 · SOP
**KPI khung đề xuất (sheet 05):**
- Chi phí NS ÷ DT: Tổng lương+BH ÷ DT · nguồn GD_LUONG · Tháng · đọc để: Định biên
**Bộ dữ liệu liên quan (sheet 03 — hệ nguồn · giờ):**
- Danh mục phòng ban & nhân viên: nhập ở File danh mục gốc (HR cấp NV) · owner HR + người giữ mã · hạn Trong ngày · cột bắt buộc: mã NV, phòng, quản lý trực tiếp, pháp nhân ký HĐ
- Lương, thưởng, hoa hồng: nhập ở Bảng lương · owner HR · hạn Ngày 05 · cột bắt buộc: kỳ, mã NV, phòng, nhãn con, lương cứng, hoa hồng, BH

## R&D / Phát triển sản phẩm
**Kỹ năng AI khung đề xuất:**
- S16 Pipeline phát triển sản phẩm: Chấm cơ hội, nghiên cứu, brief + P&L sơ bộ, so báo giá, soát claim, cấp mã, lập barem ra mắt (Sheet I) · dữ liệu: GD_DONHANG · thư viện đối thủ · Barem V5 · duyệt: PM · CEO · bắt đầu khi: Mục 4, 11 ≥ 2
**Việc cần tự động hoá (sheet F):**
- Pipeline phát triển SP (Liên tục, ~6 giờ/tuần): Xem mẫu đầy đủ ở Sheet I · dữ liệu: Xem Sheet I
**KPI khung đề xuất (sheet 05):**
- Tiến độ SKU mới: % hoàn thành theo pipeline · nguồn Thu thập MAU_SP_PHAT_TRIEN · Tuần · đọc để: Ra mắt / dừng SKU
**Pipeline 9 bước (sheet I):**
- 1. Cơ hội: kích hoạt Hằng tuần / có trend mới · AI: Quét dữ liệu bán, review, comment, call sale, đối thủ, trend; chấm điểm cơ hội theo quy mô · người quyết: PM chọn 1–3 cơ hội đáng làm · SLA 2 ngày
- 2. Nghiên cứu: kích hoạt Cơ hội được chọn · AI: Tổng hợp phân khúc, giá P25/median/P75, claim đối thủ, ICP, pain; dựng mục 01 Thị trường c · người quyết: PM kiểm định kết luận · SLA 5 ngày
- 3. Brief sản phẩm: kích hoạt Kết luận được duyệt · AI: Soạn brief: công thức mục tiêu, USP/RTB, giá đích, giá vốn trần, bao bì, combo, AOV; tính  · người quyết: CEO/PM duyệt brief · SLA 3 ngày
- 4. R&D / nhà máy: kích hoạt Brief duyệt · AI: So sánh báo giá nhà máy, lập bảng so sánh, nhắc tiến độ mẫu, ghi nhận phản hồi test · người quyết: R&D chọn nhà máy, đánh giá mẫu thật · SLA Theo nhà máy
- 5. Mẫu & test: kích hoạt Mẫu về · AI: Tổng hợp phản hồi test người dùng/KOC, chấm theo tiêu chí brief · người quyết: R&D + PM duyệt mẫu cuối · SLA 7 ngày
- 6. Bao bì – pháp lý – công bố: kích hoạt Mẫu chốt · AI: Soát claim theo danh sách được phép/cấm, chuẩn bị hồ sơ công bố, nhắc hạn · người quyết: Pháp chế ký claim & hồ sơ · SLA Theo cơ quan
- 7. Cấp mã & PO: kích hoạt Công bố có số · AI: Đề xuất mã SKU/biến thể/BOM theo cú pháp, tra trùng; đề xuất SL PO theo dự báo · người quyết: Người giữ mã duyệt mã · thu mua duyệt PO · SLA 1 ngày
- 8. Kế hoạch ra mắt: kích hoạt PO đặt · AI: Lập barem dự án mới (ADN line): mục tiêu → kênh → nguồn → NS → booking/media plan · người quyết: PM chốt, CEO duyệt gói NS · SLA 3 ngày
- 9. Ra mắt & học: kích hoạt Hàng về kho · AI: Theo dõi 2 tuần đầu, chấm concept/kênh win, đề xuất scale/sửa · người quyết: PM quyết scale · SLA 2 tuần

## Công ty
**Kỹ năng AI khung đề xuất:**
- S17 AI cố vấn 3 tầng: Đề xuất dự án (tuần), phòng (tháng), công ty (tháng/quý) theo mẫu chuẩn (Sheet H) · dữ liệu: Sheet G · Barem V5 · Sheet 05 · dòng tiền · duyệt: CEO · bắt đầu khi: Sheet G có số thật

## Gia công B2B
(Khung chưa có dòng riêng cho phòng này — dựa vào nghiên cứu nghiệp vụ: OEM/ODM, báo giá, làm mẫu, hợp đồng, công bố sản phẩm cho khách, sản xuất, giao hàng, công nợ.)
