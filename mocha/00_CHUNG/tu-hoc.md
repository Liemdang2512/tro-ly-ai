# Luật tự học — áp dụng cho agent mọi phòng

Agent học từ chính công việc người dùng giao hằng ngày. Người dùng chỉ cần làm việc bình thường.
Bot **không xem lại được tin nhắn Telegram cũ**: việc gì không ghi vào file là mất. Vì vậy các vòng dưới đây là bắt buộc.

Luật này bổ sung (không thay) mục "Chống quên lưu" trong `AGENTS.md` của phòng. Mọi lời đề xuất gộp lại **tối đa 1 câu ở cuối mỗi câu trả lời**.

**Phòng đã tự cải tiến trước khi có luật này** (máy được cập nhật từ xa, không ai rà trước):
- **Thứ tự ưu tiên:** luật riêng đã có của phòng (trong `AGENTS.md`, `ho-so-phong.md`, `ky-nang/`, `bai-hoc.md` — do người dùng đặt) **thắng** luật tự học khi trái nhau. Ví dụ phòng dặn "không tự ghi file" → bỏ vòng 1 tự ghi, chuyển thành hỏi 1 câu trước khi ghi.
- **Lần đầu gặp luật này trong phòng** (chưa có `bao-cao/*_ra-soat-luat-tu-hoc.md`): đọc toàn bộ `AGENTS.md` + `ky-nang/` + file sổ/nhật ký đang dùng, ghi `bao-cao/<YYYY-MM-DD>_ra-soat-luat-tu-hoc.md` gồm: chỗ nào trái nhau và em theo luật nào · phòng đã có sổ/kỹ năng tương đương nào thì dùng lại. Báo người dùng 1 dòng ở cuối câu trả lời đầu tiên, không hỏi dồn.
- **Đã có sổ việc / nhật ký việc kiểu khác** → ghi tiếp vào sổ đang có theo đúng cột của sổ đó (thêm cột "Loại việc" nếu thiếu), không mở sổ thứ hai. `so-viec.md` trống do script tạo thì để nguyên.
- **Đã có kỹ năng làm cùng việc nhưng khác tên** → so theo **nội dung việc**, không theo tên file; dùng và cập nhật kỹ năng sẵn có, không tạo bản trùng.

## Vòng 0 — Mời nhận việc (phòng mới cài, chưa setup)

Nếu `ho-so-phong.md` **chưa có** mục "Vai trò của em" **và** `so-viec.md` **chưa có** dòng loại việc `moi-nhan-viec` / `gui-phieu-nhan-viec`:
- Lần đầu người dùng nhắn: làm việc họ giao trước (nếu có), rồi làm **Bước 1 → 1b → 2 của `.luat-chung/setup-phong.md`**: đọc hồ sơ, **nghiên cứu phòng và soạn câu hỏi sâu (bắt buộc, không hoãn)**, báo ngắn em đã biết gì, rồi cho chọn **1. hỏi – trả lời trực tiếp** hay **2. điền file Excel một lần**.
- Người dùng chỉ chào hỏi / chưa giao việc → làm Bước 1 → 1b → 2 ngay.
- Mời một lần là đủ (Bước 2 của setup-phong đã có luật nhắc lại tối đa 1 lần).

## Vòng 1 — Ghi sổ việc (tự ghi, không hỏi)

Mỗi khi xong một **việc** người dùng giao (có đầu ra: câu trả lời phân tích, bản nháp, bảng, file, báo cáo…), thêm 1 dòng vào cuối `so-viec.md` của phòng. Không tính chào hỏi, câu hỏi vặt, việc chưa xong.

| Cột | Cách ghi |
|---|---|
| Ngày | `YYYY-MM-DD` |
| Loại việc | Nhãn ngắn, không dấu, gạch nối (vd `bao-cao-chi-phi-ngay`). **Trước khi đặt nhãn mới, đọc các nhãn đã có trong `so-viec.md` và dùng lại nếu cùng loại** — đếm việc lặp dựa vào cột này |
| Việc | 1 dòng mô tả |
| Đầu vào | Dữ liệu/file người dùng đưa hoặc agent tự lấy |
| Đầu ra | Dạng đầu ra + đường dẫn file nếu có |
| Kết quả | `ok` · `sửa: <sửa gì>` · `chưa rõ` (người dùng chưa phản hồi) |

- Người dùng phản hồi sau (khen/chê/sửa): **thêm dòng mới** loại việc giống hệt, cột Việc ghi `(phản hồi) …`, không sửa dòng cũ.
- Chỉ thêm dòng, không sửa/xóa dòng cũ. Không ghi mật khẩu, số tài khoản, lương, CCCD, nội dung tin nhắn riêng nguyên văn.
- Ghi xong không cần báo người dùng.

## Vòng 2 — Học từ lần sửa

Người dùng chê, sửa, hoặc nói "không phải vậy" → cuối câu trả lời hỏi 1 câu:
> "Lưu thành bài học: lần sau <điều cần làm khác> nhé?"

Đồng ý → thêm dòng vào `bai-hoc.md`. Trước mỗi việc, đọc `bai-hoc.md` phần liên quan và không lặp lỗi đã ghi.

## Vòng 3 — Hỏi bù đúng lúc

Đang làm việc mà thiếu thông tin nền (ngưỡng, người duyệt, bộ mã, quy trình, KPI, mẫu đầu ra…):
1. Hỏi **đúng 1 câu**, kèm gợi ý đáp án. Câu hỏi lấy từ ngân hàng `.luat-chung/cau-hoi-nhan-viec.csv` (câu chung + câu riêng của phòng) nếu có câu phù hợp.
2. Có đáp án → làm tiếp, rồi cuối câu trả lời đề xuất lưu: "Lưu vào `ho-so-phong.md` mục <số> nhé?"
3. Người dùng không trả lời được → ghi `[Cần hỏi]` trong kết quả, không đoán.

Không hỏi lại điều đã có trong `ho-so-phong.md`, `sop/`, `bai-hoc.md`.

## Vòng 4 — Đóng gói việc lặp (lần thứ 3)

Sau khi ghi sổ việc, đếm số dòng cùng **Loại việc** (không tính dòng `(phản hồi)`). Khi đủ **3 lần** và trong `ky-nang/` chưa có kỹ năng cho loại việc đó → cuối câu trả lời đề xuất:
> "Việc <loại việc> đã làm 3 lần. Tôi đóng gói thành kỹ năng để lần sau làm nhanh và đúng hơn nhé?"

Đồng ý → tạo `ky-nang/<loai-viec>.md` theo mẫu dưới, gửi bản nháp cho người dùng sửa. Lần có kết quả `ok` tốt nhất → đề xuất lưu làm mẫu vào `du-lieu/10_mau-dau-ra-tot/` (+ 1 dòng `MUC-LUC.md`).
Người dùng từ chối → không hỏi lại loại việc này cho tới lần thứ 6.

```markdown
# Kỹ năng: <tên việc> — phòng <tên phòng>

Dùng khi: <câu người dùng hay nói khi giao việc này>
Tần suất: <hằng ngày / hằng tuần / khi có …>   ← gợi ý việc có thể tự chạy theo lịch sau này

## Đầu vào
- <dữ liệu gì, lấy ở đâu, ai đưa>

## Các bước
1. …

## Đầu ra
- Dạng: <tin nhắn / bảng / file …> · Gửi cho: <ai>
- Mẫu tốt: `du-lieu/10_mau-dau-ra-tot/<file>` (nếu có)

## Checklist trước khi giao
- [ ] <rút từ các lần bị sửa trong so-viec.md và bai-hoc.md>
- [ ] Số liệu có `[Nguồn: …]`, chỗ chưa biết ghi `[Cần hỏi]`

## Không được làm
- <rút từ bài học / người dùng dặn>

Nguồn: so-viec.md các ngày <…>
```

Khi đã có kỹ năng: lần sau gặp đúng loại việc → đọc và làm theo kỹ năng; người dùng sửa → đề xuất cập nhật kỹ năng (không chỉ ghi bài học).

## Vòng 5 — Rà tuần

Khi người dùng nhắn "rà tuần" (hoặc "tổng kết tuần"): đọc `so-viec.md` 7 ngày gần nhất, `bai-hoc.md`, `ky-nang/`, `ho-so-phong.md`, rồi lưu `bao-cao/<YYYY-MM-DD>_ra-tuan.md` và gửi bản tóm tắt:

1. Số việc đã làm, chia theo loại việc (bảng: loại · số lần · số lần bị sửa).
2. Việc lặp nhiều nhất + **việc nào có tần suất đều đặn, có thể cho tự chạy theo lịch**.
3. Kỹ năng mới tạo / cần cập nhật; loại việc sắp đủ 3 lần.
4. Bài học mới trong tuần.
5. Các mục `ho-so-phong.md` còn `[Cần hỏi]` — chọn tối đa 3 câu quan trọng nhất để hỏi.
