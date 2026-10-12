# Làm việc với Sếp — bộ v2.1 (12/10/2026)

Đúc kết từ 430 tin nhắn Telegram của Sếp (#260 → #1413, 02/10 → 12/10/2026). Đây là **luật nền bắt buộc** cho mọi agent phòng ban MOCHA, cả phòng cũ lẫn phòng mới.

## Cách áp dụng (đọc trước)
1. `14_PROMPT_TONG.md` (bản đầy đủ, nguyên văn) được **tự nạp mỗi phiên** vào mọi phòng qua `AGENTS.md` của phòng (khối `<!-- prompt-tong -->` do `them-tu-hoc.sh` thêm).
2. Thứ tự ưu tiên khi trái nhau: **mục An toàn** của luật chung → **Prompt tổng v2.1** → luật riêng của phòng → các luật chung khác (`tu-hoc.md`, `setup-phong.md`…). Luật riêng của phòng chỉ được cụ thể hoá prompt tổng, không được làm ngược. Thấy trái nhau thì theo prompt tổng và báo Sếp 1 dòng.
3. Các file prompt nhắc tới (`16_SO_TAY_LUAT`, `17_DU_KIEN_NGHIEP_VU`, `18_NHAT_KY_LOI`, `19_KIEM_THU`, `20_MO_HINH_HUAN_LUYEN`, `21_NGUON_CHUAN`, `22_QUYET_DINH_DA_CHOT`) nằm cùng thư mục này: trong phòng là `.luat-chung/lam-viec-voi-sep/`. Chỉ đọc khi cần, không đọc hết mỗi phiên.
4. Bước 5 "Tự kiểm chéo" của prompt **cộng thêm** kiểm chứng độc lập (`.luat-chung/kiem-chung.md` bước 1–2, `tu-hoc.md` vòng 6), không thay thế nó: tự kiểm theo mục A–E xong, file / nghiên cứu có số liệu, luật, giá thì vẫn gọi AI thứ hai kiểm. Thiếu một trong hai thì chưa giao.
5. "Gửi link duyệt" khi làm qua Telegram: gửi **1 bản duyệt** (1 file hoặc 1 link), đầu bản ghi khác gì bản cũ · kết quả kiểm · điểm cần Sếp chốt. Sếp OK mới xuất bản cuối hoặc ghép vào file tổng.
6. `17_DU_KIEN_NGHIEP_VU.md`: mọi ngưỡng tiền là [Giả định], dùng cho demo, không đưa ra ngoài công ty.
7. Báo cáo ngày 17:47 và rà tuần thứ Hai 08:33: lịch máy tự chạy `cai-dat/bao-cao-dinh-ky.sh` (cài khi bấm CAP-NHAT trên máy có bot). Lịch mở một phiên riêng, đọc `so-viec.md`, `nhat-ky/`, `bao-cao/` của phòng, lưu `bao-cao/<ngày>_bao-cao-ngay.md` hoặc `<ngày>_ra-tuan.md` rồi bot gửi vào topic của phòng. Phiên đang chat với Sếp không tự gửi báo cáo này; Sếp hỏi lại thì đọc file đã lưu. Vì vậy **ghi `so-viec.md` đủ và đúng ngày** — báo cáo chỉ dựa vào đó.
8. Sửa prompt: sửa file ở `mocha/00_CHUNG/lam-viec-voi-sep/` trong repo theo vòng 7 bước (`20_MO_HINH_HUAN_LUYEN.md`), tăng phiên bản, ghi khác gì → Sếp duyệt → đưa lên `main` → máy dùng bấm CAP-NHAT. Không sửa bản chép trong `.luat-chung/`.

## Danh sách file
| File | Nội dung | Trên repo |
|---|---|---|
| `14_PROMPT_TONG.md` | Prompt tổng bản đầy đủ v2.1 (148 dòng, nguyên văn) — tự nạp mọi phòng | Có |
| `14b_PROMPT_RUT_GON.md` | Prompt rút gọn v2.1 (29 dòng) — dùng khi dán vào trợ lý khác | Có |
| `15_DONG_THOI_GIAN.md` | 8 chặng 02/10 → 12/10: Sếp cần gì, câu then chốt, kết quả, bài học | Có |
| `16_SO_TAY_LUAT.md` | 33 luật L01–L33, câu Sếp nói, số tin, số lần nhắc | Có |
| `17_DU_KIEN_NGHIEP_VU.md` | 21 thông số vận hành Sếp đã cho | Có |
| `18_NHAT_KY_LOI.md` | 26 lỗi E01–E26: ai phát hiện, gốc rễ, luật sửa | Có |
| `19_KIEM_THU.md` | 10 tình huống T01–T10, đáp án đúng, kết quả lần đầu | Có |
| `20_MO_HINH_HUAN_LUYEN.md` | Vòng 7 bước + bảng điểm 6 chỉ số | Có |
| `21_NGUON_CHUAN.md` | Nguồn chuẩn từng mảng, ai xác nhận | Có |
| `22_QUYET_DINH_DA_CHOT.md` | 12 quyết định đã chốt — không hỏi lại | Có |

Các file 01–13 và `09_CAI_TIEN_HANG_NGAY` mà sổ tay nhắc tới thuộc bộ `lam-viec-voi-sep` bản 1.2 của Sếp, chưa có trong repo. Gặp tham chiếu tới các file đó thì dùng file tương ứng ở trên. Không có thì ghi `[Cần hỏi]`.

## Kết luận của sổ tay
- Điều Sếp nói nhiều nhất là "chuẩn" (53 tin) và "final / chốt" (41 tin). Sếp cần một bản cuối dùng được, theo chuẩn ERP tập đoàn, không cần nhiều phương án.
- Nỗi đau lặp lại là "không biết bắt đầu từ đâu", "rối" (26 tin). Lần nào Sếp rối, cách gỡ đều giống nhau: thu hẹp phạm vi (1 dự án), có điểm bắt đầu, có ví dụ final.
- 24/26 lỗi do Sếp phát hiện, em chỉ tự bắt được 2. Đây là chỗ yếu lớn nhất: làm đúng phạm vi được hỏi, không tự rà toàn hệ thống.
- Mọi yêu cầu đều quy về 1 trục: ERP toàn tập đoàn → luồng đi từ mục tiêu đến kết quả → đủ dữ liệu để ra quyết định → kiểm chéo, chính xác cao nhất → gửi duyệt rồi mới xuất.

## Nhịp làm việc của Sếp
Chữ 339 · File 51 · Ảnh 35 · Video 5 tin. Cao điểm 16h (98 tin), 11–12h (130 tin). Có nhắn khuya 21–23h (44 tin) → báo cáo ngày 17:47 hợp nhịp. Ngày nhiều nhất 12/10 (141 tin): ngày chốt 2 link và đúc kết.

Từ Sếp dùng nhiều nhất [Ước]: "chuẩn" 53 · "final / chốt" 41 · "kĩ / chi tiết / cụ thể" 37 · "chuyên nghiệp / chuyên gia" 32 · "rối / không biết bắt đầu từ đâu" 26 · "ERP / tập đoàn" 21 · "kiểm tra / rà lại" 20 · "logic / sắp xếp" 16 · "duyệt" 16 · "Alo / Đâu r" 10 · "benchmark / thị trường" 10 · "tham khảo" 9.

## Khác bản 1.2
v2.0 thêm mục 1–6, v2.1 thêm mục 7–9:
1. Thêm nguyên tắc 4 Đủ để ra quyết định và 5 Đi từ mục tiêu đến kết quả.
2. Thêm phần khung đã chốt + lộ trình 3 bản Sếp chỉ cần quan tâm.
3. Thêm phần cách đọc Sếp (chuỗi tin, "Ok" giữa chừng, giờ làm việc).
4. Thêm quy trình giao – nhận 8 bước: nhận → xác nhận + giờ → hỏi 1 lần → làm theo đợt → làm mẫu thật → tự kiểm → gửi link duyệt → OK mới xuất.
5. Thêm chuẩn đầu ra, lỗi không lặp lại, khung 8 phần khi dựng agent mới, chỉ số tự chấm mỗi tuần.
6. Mỗi luật có mã L01–L33 để truy về tin nhắn gốc.
7. v2.1: thêm phần mô hình huấn luyện – vòng 7 bước + bảng điểm 6 chỉ số có mốc đo thật.
8. v2.1: nối sổ quyết định đã chốt – agent không hỏi lại điều Sếp đã chốt.
9. v2.1: thêm prompt rút gọn cho trợ lý chức năng từng phòng.

## Mỗi loại trợ lý đọc gì (theo số file của sổ tay)
- Điều phối: 00 · 14 · 16 · 15 · 06 · 20 · 22
- Kiểm tra (QC, kiểm soát nội bộ): 05 · 08 · 16 · 18 · 19
- Xu hướng (thị trường, benchmark): 05 · 07 · 21 · 16 (nhóm D)
- Rà soát (audit, nghiệm thu): 01 · 08 · 15 · 18 · 19 · 20
- Trợ lý chức năng từng phòng: 14b · 17 · 22 + gói nghề của phòng — **ở MOCHA mọi phòng nạp bản đầy đủ 14** theo yêu cầu, 14b chỉ để dán vào trợ lý khác.
