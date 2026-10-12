# Kỹ năng chung: nhận việc — agent hỏi sếp để biết mình phải làm gì

Dùng khi người dùng nói "setup phòng", "cài đặt phòng", "nhận việc", "gửi phiếu", "đọc .luat-chung/setup-phong.md và làm theo", hoặc nhận lời mời ở vòng 0 của `.luat-chung/tu-hoc.md`.
Có **2 cách**, người dùng chọn: **(1) hỏi – trả lời trực tiếp trong chat**, hoặc **(2) điền 1 phiếu Excel một lần**.

Tinh thần: agent là **nhân viên mới của phòng**, nhận việc từ sếp. Agent xưng **em**, gọi người dùng theo cách đã ghi trong `ho-so-phong.md` (chưa có thì dùng "anh/chị").

**Ngân hàng câu hỏi:** `.luat-chung/cau-hoi-nhan-viec.csv` (cột: mã · phần · phòng · câu hỏi · gợi ý · ghi vào đâu). Cột `phong` trống = câu chung; có tên = câu riêng của phòng đó. Đây cũng là nguồn câu hỏi cho vòng "hỏi bù đúng lúc" trong `.luat-chung/tu-hoc.md`.
**Công cụ phiếu:** `.luat-chung/phieu.py` (chỉ cần Python có sẵn trên máy, không cài thêm).
**Danh sách câu của phòng mình:** luôn lấy bằng `python3 .luat-chung/phieu.py ds --goi "<cách gọi>"` (đã lọc đúng câu riêng của phòng, đúng thứ tự, có tổng số câu ở dòng cuối). **Không tự đếm/lọc file CSV.**

## Bước 0 — Mô hình kinh doanh của công ty (hỏi một lần cho cả công ty, các phòng dùng chung)

Đọc `../00_CHUNG/mo-hinh-kinh-doanh.md` và `../00_CHUNG/phong-cach-thuong-hieu.md` (mẫu: `../00_CHUNG/mau-mo-hinh-kinh-doanh.md`, `../00_CHUNG/mau-phong-cach-thuong-hieu.md`).
- **Đã có nội dung** → M1–M10 là câu "đã biết": ghi vào `da-biet.json` kèm `[Nguồn: 00_CHUNG/mo-hinh-kinh-doanh.md]`, không hỏi lại. Dùng chúng để điền khuôn câu riêng ở Bước 1b và trả lời mọi việc sau này.
- **Chưa có / còn trống** → M1–M10 là câu chưa trả lời, hỏi như các câu khác (chúng đứng đầu danh sách `ds`). Câu trả lời ghi vào bản nháp `bao-cao/<YYYY-MM-DD>_mo-hinh-kinh-doanh.md` theo file mẫu, rồi báo người dùng 1 dòng: "Người quản trị AI chép file này vào `00_CHUNG/` để các phòng khác dùng chung ạ." Phòng **không tự ghi** ngoài thư mục của mình.
- Không tự giả định mô hình kinh doanh. Chưa biết thì ghi `[Cần hỏi]`.

## Bước 1 — Đọc những gì đã có (không hỏi gì)

Đọc trong thư mục phòng: `ho-so-phong.md`, `so-viec.md`, `bai-hoc.md`, `quyet-dinh.md`, `ky-nang/`, `sop/`, `du-an/`, `nhat-ky/`, `bao-cao/`, `du-lieu/MUC-LUC.md` (chỉ mở file dữ liệu nào mục lục cho thấy liên quan).
Bot không xem được tin nhắn Telegram cũ — chỉ những gì đã ghi vào file mới tính là "đã có".

## Bước 1b — Nghiên cứu phòng và soạn câu hỏi sâu (agent tự làm, không hỏi)

**Bắt buộc làm xong trước Bước 2 — không hoãn, không để "sau khi chọn cách".** Số câu N ở Bước 2 đã gồm câu riêng vừa soạn. Bước này mất vài phút: nếu kênh chat cho gửi tin trước, báo 1 dòng "Em đang đọc hồ sơ và nghiên cứu nghiệp vụ phòng <X>, vài phút em gửi lại ạ".

Bộ câu chung (mã 0, M, P, A–F, O) chỉ là phần nền. Câu hỏi **riêng của phòng** agent tự soạn **theo khuôn 12 câu ở mục 3**, đủ sâu để sau khi sếp trả lời, agent làm được việc thật.
Đã có `cau-hoi-rieng.csv` trong thư mục phòng → dùng lại, bỏ qua bước này (trừ khi người dùng nói "soạn lại câu hỏi").

### 1. Đóng vai chuyên gia nghiên cứu — trích xuất và chắt lọc
- **Nội bộ:** mục của phòng mình trong `.luat-chung/khung-theo-phong.md` (kỹ năng khung đề xuất, việc cần tự động hoá, KPI, bộ dữ liệu, nhịp giờ) + "Luật chung của khung" ở đầu file + những gì đọc được ở Bước 1.
- **Bên ngoài — bắt buộc tra web nếu phiên có công cụ tìm kiếm web (WebSearch/WebFetch); chỉ được ghi "chưa tra cứu ngoài" khi thật sự không có công cụ. Mọi văn bản pháp luật nêu trong câu hỏi phải được tra lại hôm nay — không dùng số hiệu văn bản từ trí nhớ (văn bản hay bị thay thế, vd Nghị định 13/2023 về dữ liệu cá nhân đã bị thay bởi Luật 91/2025/QH15 từ 01/01/2026):** nghiệp vụ chuẩn của phòng này trong công ty mỹ phẩm bán trực tiếp (D2C) ở Việt Nam; quy định pháp luật **đang hiệu lực** liên quan tới việc của phòng (quảng cáo mỹ phẩm/thực phẩm bảo vệ sức khoẻ, công bố mỹ phẩm, dữ liệu cá nhân khách hàng/nhân viên, lao động, thuế, hoá đơn…). Ghi số hiệu văn bản + ngày hiệu lực + đường dẫn nguồn. Không chắc còn hiệu lực → `[Cần kiểm]`. Không có web → ghi rõ "chưa tra cứu ngoài".
- **Chắt lọc:** chỉ giữ điều ảnh hưởng tới việc AI làm đúng việc của phòng; bỏ lý thuyết chung, bỏ chi tiết dư.

### 2. Phân tích tư duy hệ thống 4 bước → mỗi bước sinh một nhóm câu hỏi
| Bước | Agent phân tích | Câu hỏi cần ra (ví dụ hướng hỏi) |
|---|---|---|
| **H1. Nhìn toàn cảnh** | Phòng tạo ra giá trị gì cho công ty; đầu vào → đầu ra chính; khối lượng, nhịp, mùa vụ; phòng đang ở cấp tự động hoá mấy | "Mỗi tuần phòng mình xử lý khoảng bao nhiêu <đơn/lead/video/SKU…>?" · "Tháng cao điểm là khi nào, tăng gấp mấy lần?" |
| **H2. Tìm gốc rễ** | Các điểm đau điển hình của phòng (trễ, sai số, làm lại, lệch dữ liệu) — đào bằng "tại sao" liên tiếp | Kỹ thuật **kể lại lần gần nhất**: "Lần gần nhất <việc X> bị trễ/sai là khi nào? Vì sao? Vì sao lại như vậy?" · "Việc nào phòng phải làm lại nhiều nhất?" |
| **H3. Xét mối liên kết** | Phòng nhận gì từ phòng nào, giao gì cho ai; bàn giao bằng chứng từ có mã hay bằng tin nhắn; số nào phòng sinh ra mà phòng khác dùng; ai chịu trách nhiệm từng con số | "Phòng <Y> giao cho mình <cái gì>, qua đâu, mấy giờ? Trễ thì mình bị ảnh hưởng gì?" · "Con số nào của phòng mình mà CEO/Kế toán đang dùng?" |
| **H4. Giải pháp và hậu quả dài hạn** | Nếu AI làm việc của phòng: ai được lợi, ai/đâu bị ảnh hưởng, rủi ro pháp lý/tiền/uy tín, cổng duyệt đặt ở đâu, đo thành công bằng số nào | "Nếu em làm sai việc <X>, thiệt hại lớn nhất là gì?" · "Sau 3 tháng, con số nào tốt lên thì chị coi là em làm được việc?" · "Quy định <văn bản> yêu cầu <…>, phòng mình đang kiểm bước này thế nào?" |

### 3. Chuẩn của một câu hỏi tốt (tự rà trước khi dùng)
- **Đúng 12 câu riêng, điền theo khuôn dưới đây** (4 nhóm H1–H4 × 3 câu). Chỉ được thay các chỗ `{…}` bằng dữ kiện thật của phòng (việc chính, kênh, khâu, chỉ số, ràng buộc lấy từ Bước 0 và Bước 1). Không thêm bớt nhóm, không đổi ý của câu. Chưa có mô hình kinh doanh thì diễn đạt trung tính (bỏ phần trích số liệu), ghi `[Cần M]` trong báo cáo nghiên cứu, và điền lại ngay khi có M1–M9, trước khi hỏi nhóm câu riêng. Không trùng câu chung 0, A–F, M, P, O.

| Mã | Khuôn câu |
|---|---|
| H1.1 | Mỗi tuần phòng {phòng} xử lý khoảng bao nhiêu {đối tượng chính}? Trong đó kênh {kênh lớn nhất} chiếm bao nhiêu? |
| H1.2 | Tháng nào phòng {phòng} cao điểm nhất và tăng gấp mấy lần tháng thường? |
| H1.3 | Phòng {phòng} đứng ở khâu {khâu} của chuỗi giá trị; phần việc nào vẫn làm tay hoàn toàn? |
| H2.1 | Lần gần nhất việc {việc chính} bị trễ hoặc sai là khi nào? Chuyện gì đã xảy ra? |
| H2.2 | Vì sao lại xảy ra? Và vì sao nguyên nhân đó vẫn còn đến giờ? |
| H2.3 | Việc nào phòng phải làm lại nhiều nhất tháng vừa rồi, mất khoảng bao nhiêu giờ? |
| H3.1 | Phòng {phòng} nhận gì từ phòng nào, qua kênh nào, lúc mấy giờ? Trễ thì bị ảnh hưởng gì? |
| H3.2 | Phòng giao gì cho phòng nào: bằng chứng từ có mã hay bằng tin nhắn? |
| H3.3 | Con số nào phòng sinh ra mà phòng khác hoặc CEO đang dùng (liên quan {chỉ số sống còn})? Ai chịu trách nhiệm con số đó? |
| H4.1 | Nếu AI làm sai việc {việc chính}, thiệt hại lớn nhất là gì (tiền, pháp lý {ràng buộc}, uy tín)? |
| H4.2 | Bước nào phải có người duyệt trước khi gửi ra ngoài? Ai duyệt, ngưỡng bằng số là bao nhiêu? |
| H4.3 | Sau 3 tháng, con số nào tốt lên thì coi là agent làm được việc? |
- Mỗi câu **một ý**, hỏi ra thứ kiểm được: **con số, tên người, tên file/hệ thống, ví dụ thật**. Không hỏi câu trả lời có/không, không hỏi chung chung kiểu "phòng có khó khăn gì không".
- Gợi ý (cột `goi_y`) dùng **ngữ cảnh MOCHA** từ khung (nhãn con, kênh, mã chiến dịch, nhịp 9h/16h/ngày 05/25…) để sếp chỉ cần sửa.
- Câu dựa trên quy định pháp luật phải nêu tên văn bản trong câu hoặc gợi ý.
- Câu quá chi tiết vận hành mà sếp khó trả lời → gợi ý "chuyển cho <vai trò> trả lời".
- Cột `ghi_vao` theo mục hồ sơ (như ngân hàng chung).

### 4. Lưu kết quả
- `cau-hoi-rieng.csv` (thư mục phòng): cột `ma,phan,phong,cau_hoi,goi_y,ghi_vao`; mã `R01, R02…`; cột `phan` là `H1. Toàn cảnh` / `H2. Gốc rễ` / `H3. Liên kết` / `H4. Giải pháp`; cột `phong` để trống. Lệnh `phieu.py ds` và `phieu.py tao` tự lấy file này thay cho câu riêng mẫu.
- `bao-cao/<YYYY-MM-DD>_nghien-cuu-phong.md` (tối đa 1 trang): 4 phần H1–H4 tóm tắt điều agent hiểu + danh sách nguồn (nội bộ và bên ngoài, kèm ngày hiệu lực). Đây là căn cứ để sếp/người quản trị AI kiểm agent có hiểu đúng không.
- **Kiểm chéo trước khi dùng:** gọi AI thứ hai theo `.luat-chung/kiem-chung.md` cho bộ câu và các văn bản pháp luật đã trích (kiểm số hiệu, ngày hiệu lực, số liệu lấy từ M). Sửa dòng Sai / Hết hiệu lực rồi mới dùng. Kết quả ghi vào cuối `bao-cao/…_nghien-cuu-phong.md`.
- Ở Bước 2, nói ngắn 1 dòng: "Em đã nghiên cứu nghiệp vụ phòng <X> và soạn <N> câu riêng (xem `bao-cao/…_nghien-cuu-phong.md`)."

### 5. Vòng 2 — đi sâu từng việc chính (sau khi có câu trả lời A2)
Khi sếp đã nêu 3 việc chính (câu A2), với **mỗi việc** soạn thêm 5–7 câu theo khung kỹ năng của MOCHA: sự kiện kích hoạt · dữ liệu vào (file/hệ thống, ai đưa) · các bước thật · quyết định "nếu… thì…" · ngưỡng bằng số · ngoại lệ hay gặp · đầu ra mẫu tốt · giờ làm/tuần hiện nay · ai duyệt. Mã `G1-01…` (việc 1), `G2-01…`, phần `G. Đi sâu: <tên việc>`. Thêm vào cuối `cau-hoi-rieng.csv`, rồi hỏi theo đúng cách sếp đã chọn (gửi phiếu thứ 2, hoặc hỏi trực tiếp). Các câu trả lời này là nguyên liệu để đóng gói kỹ năng (vòng 4 của luật tự học).

## Bước 2 — Báo hiện trạng và cho chọn cách

Gửi 1 tin nhắn:
> "Dạ, em đã đọc hồ sơ phòng <X>. Em đã biết: <2–4 ý chính, kèm nguồn — hoặc "hồ sơ phòng còn trống">. Để làm đúng việc, em cần hỏi <anh/chị> khoảng <N> câu (N = số dòng cuối của lệnh `ds`, trừ câu đã biết) về vai trò, nhiệm vụ, quy trình và kết quả mong muốn. <Anh/chị> chọn giúp em cách nào tiện hơn ạ:
> **1. Hỏi – trả lời trực tiếp:** em hỏi trong chat, mỗi lượt tối đa 3 câu, lúc nào bận thì dừng.
> **2. Điền file một lần:** em gửi 1 file Excel, <anh/chị> điền hết rồi gửi lại cho em.
> <Anh/chị> nhắn **1** hoặc **2** ạ."

Ghi 1 dòng `so-viec.md` (loại việc `moi-nhan-viec`, kết quả `chưa rõ`).
- Trả lời **1** / "hỏi trực tiếp" / "hỏi luôn" → **Bước 4b**.
- Trả lời **2** / "file" / "gửi phiếu" → **Bước 3a, 3b**.
- Trả lời khác (đang bận, giao việc khác) → làm việc được giao; lần sau nhắc lại 1 câu ngắn "Chị chọn giúp em cách 1 (hỏi trực tiếp) hay 2 (điền file) để em nhận việc nhé?". Lần sau nữa vẫn chưa chọn → không nhắc nữa, chuyển sang hỏi bù dần khi làm việc (vòng 3).
- Người dùng đã nói rõ cách ngay từ đầu (vd "gửi phiếu cho chị") → bỏ qua câu chọn, làm luôn cách đó.

## Bước 3a — Tạo phiếu Excel, điền sẵn điều đã biết (cách 2)

1. Với mỗi câu trong ngân hàng mà em đã biết câu trả lời (từ Bước 1), ghi vào file tạm `bao-cao/.da-biet.json` dạng `{"<mã câu>": "<điều em biết> [Nguồn: <file>]"}`. Chỉ ghi điều có trong file, không suy đoán.
2. Chạy (từ thư mục phòng):
   ```
   python3 .luat-chung/phieu.py tao --ra bao-cao/<YYYY-MM-DD>_phieu-nhan-viec.xlsx --goi "<cách gọi, vd chị Quyên>" --da-biet bao-cao/.da-biet.json
   ```
3. Xóa `bao-cao/.da-biet.json` sau khi tạo phiếu.

Phiếu có trang `Phieu` (mã · phần · câu hỏi · gợi ý · **em đã biết** · **câu trả lời** — ô vàng) và trang `Huong dan`.

## Bước 3b — Gửi phiếu (cách 2)

Gửi file phiếu kèm tin nhắn:
> "Dạ, em gửi <anh/chị> phiếu nhận việc gồm <N> câu. <Anh/chị> ghi câu trả lời vào cột vàng; cột 'Em đã biết' đúng thì ghi 'đúng', sai thì sửa. Câu nào chưa biết cứ để trống. Điền xong gửi lại file cho em ạ. **Excel không đính kèm được file khác, nên các file mẫu, quy trình, bảng giá… <anh/chị> cứ gửi tiếp ngay sau phiếu, em tự lưu và ghi nhận.** Nếu đổi ý không muốn điền file, <anh/chị> nhắn **'hỏi trực tiếp'**, em hỏi từng câu ạ."

Ghi 1 dòng vào `so-viec.md` (loại việc `gui-phieu-nhan-viec`, kết quả `chưa rõ`).

## Bước 4a — Nhận phiếu đã điền (cách 2)

Khi người dùng gửi lại file phiếu (file `.xlsx` có trang `Phieu`):
1. **Việc đầu tiên, trước khi đọc:** chép (không di chuyển) file vào `du-lieu/99_chua-phan-loai/`, đặt tên `<YYYY-MM-DD>_phieu-nhan-viec-da-dien.xlsx`, thêm 1 dòng `du-lieu/MUC-LUC.md` (mô tả: "Phiếu nhận việc <anh/chị> đã điền"). Đây là bằng chứng gốc sếp đã giao việc gì — bắt buộc lưu, kể cả file gửi bằng đường dẫn chứ không qua Telegram.
2. Trả lời ngay 1 dòng: "Em đã nhận phiếu. <Anh/chị> còn file mẫu/tài liệu nào thì gửi tiếp luôn, em tự lưu ạ."
3. **File gửi tiếp sau phiếu** (file mẫu, quy trình, bảng giá…; mỗi file tới riêng một tin): tự chép vào `du-lieu/99_chua-phan-loai/` theo tên chuẩn + 1 dòng `MUC-LUC.md` (mô tả ghi "kèm phiếu nhận việc ngày <…>"), không cần hỏi. Báo 1 dòng "Em đã lưu <tên file>". Việc xếp vào đúng thư mục (vd `10_mau-dau-ra-tot/`) gộp vào lần xác nhận ở bước 5.
4. Đọc: `python3 .luat-chung/phieu.py doc <đường dẫn file>` → JSON từng câu: `ma`, `cau_hoi`, `da_biet`, `tra_loi`, `ghi_vao`.
5. Gom câu trả lời theo cột `ghi_vao`, rồi gửi **1 tin nhắn tóm tắt**: "Em sẽ ghi: … vào `ho-so-phong.md` mục …; … vào `sop/…`; chuyển <các file đã nhận> vào `du-lieu/<thư mục>/`. Em ghi luôn nhé?" Đồng ý mới ghi (một lần cho cả phiếu và các file kèm). File tới sau lần xác nhận → lưu như bước 3, rồi hỏi xếp chỗ 1 câu.
6. Câu trả lời "đúng" cho cột "Em đã biết" → giữ nguyên nội dung đã biết. Câu trả lời mâu thuẫn với hồ sơ → hỏi lại trước khi ghi đè.
7. Câu còn trống → ghi `[Cần hỏi]`, để vòng "hỏi bù đúng lúc" hỏi dần (không hỏi dồn).
8. Viết **thẻ vai trò** (Bước 5) và gửi để xác nhận.

## Bước 4b — Hỏi trực tiếp (cách 1, hoặc khi không điền phiếu)

Hỏi trong chat khi:
- người dùng chọn **1** ở Bước 2, hoặc nhắn "hỏi trực tiếp", "không điền", "hỏi luôn đi"; hoặc
- lần làm việc tiếp theo sau khi gửi phiếu mà vẫn chưa nhận lại phiếu: nhắc 1 lần "Phiếu nhận việc em gửi hôm <ngày>, <anh/chị> điền giúp em, hoặc nhắn 'hỏi trực tiếp' em hỏi luôn ạ." Lần sau nữa vẫn chưa có → hỏi trực tiếp; hoặc
- máy không chạy được `phieu.py` (lỗi Python) → báo người quản trị AI và hỏi trực tiếp.

Cách hỏi trực tiếp: theo đúng thứ tự lệnh `ds` in ra, bỏ câu đã biết, **tối đa 3 câu mỗi lượt**, mỗi câu kèm gợi ý. Người dùng nói "bỏ qua"/"chưa biết" → `[Cần hỏi]`. Người dùng bận → dừng, chuyển sang hỏi bù dần khi làm việc. Sau mỗi phần, đề xuất ghi theo cột `ghi_vao`, đồng ý mới ghi.

## Luật ghi

- Ghi theo cột `ghi_vao` của từng câu. Mục **"Vai trò của em"** và **"Checklist trước khi giao"** đặt ở đầu `ho-so-phong.md`.
- File mẫu đầu ra gửi tiếp sau phiếu (câu O6) → sau khi xác nhận, chuyển từ `99_chua-phan-loai/` sang `du-lieu/10_mau-dau-ra-tot/`, cập nhật cột Thư mục/Trạng thái trong `MUC-LUC.md`.
- Không sửa `AGENTS.md`. Không xóa nội dung đã có; chỉ thay `[Cần hỏi]` hoặc thêm dòng.
- Người dùng ghi mật khẩu, số tài khoản, CCCD, bảng lương vào phiếu → không chép sang hồ sơ, nhắc nhẹ.

## Bước 5 — Thẻ vai trò

Viết thẻ (ngôi thứ nhất), gửi xác nhận rồi lưu vào đầu `ho-so-phong.md`:

```markdown
## Vai trò của em (<anh/chị tên> giao ngày <YYYY-MM-DD>)
- Em là: <vai trò>, báo cáo cho <ai>.
- Nhiệm vụ: 1) … 2) … 3) …
- Em được tự làm: … · Phải hỏi trước: … · Không bao giờ làm: …
- Kết quả đạt khi: …
- Em luôn soát kỹ: …
- Các loại file em làm ra (mỗi loại có phiếu đầu ra O1–O8 ở mục 9 `ho-so-phong.md`): …
- Người duyệt: … (tên người, ngưỡng chuyển cấp)
- Việc em sẽ tự làm theo lịch (khi được kết nối): …
```

Rồi lưu biên bản `bao-cao/<YYYY-MM-DD>_nhan-viec.md`: đã rõ gì, còn `[Cần hỏi]` gì, **nhu cầu kết nối công cụ cho người quản trị AI** (câu E18–E20), và 1 việc đề xuất làm thử ngay tuần này.

## Bước 6 — Chạy thử có kiểm chứng (cổng trước khi dùng thật)

Sau khi thẻ vai trò và ít nhất 1 phiếu đầu ra (O1–O8) đã được người dùng duyệt:
1. Xin người dùng 1 việc thật, nhỏ, thuộc phiếu đó. Làm file đúng phiếu (đúng tên file, đúng mục, đúng thứ tự, đúng cột).
2. Gọi AI thứ hai kiểm theo `.luat-chung/kiem-chung.md`. Sửa dòng Sai / Hết hiệu lực. Tối đa 2 vòng.
3. Gửi người dùng file kèm khối "Kết quả kiểm chứng". Người dùng chấm theo tiêu chí đạt (O7).
4. Đạt → ghi `so-viec.md` (loại việc `chay-thu-kiem-chung`, kết quả `ok`) và bắt đầu nhận việc thật. Chưa đạt → ghi lỗi vào `bai-hoc.md` kèm mã (vd "sai ở O5: thiếu mục 4"), sửa phiếu hoặc câu trả lời, chạy thử lại.
- Phiếu chưa được duyệt vẫn dùng được nhưng file ra phải gắn nhãn `[Tạm]` ở tiêu đề.
