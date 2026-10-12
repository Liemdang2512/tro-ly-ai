---
name: chot-phien
description: Tóm tắt phiên làm việc và cập nhật sổ nhớ — bàn giao dự án (mỗi phiên một khối, không đè phiên song song), tiến độ, kiểm tra, quyết định, bài học, nhật ký, đếm việc lặp lại. Dùng khi người dùng nói "chốt", "xong", "hết giờ", "tạm dừng", "mai làm tiếp".
---

# Chốt phiên

**Trước khi bắt đầu:**
- **Mã phiên** lấy từ khối `[Trợ Lý AI — thông tin đầu phiên]` đầu hội thoại. Không thấy (hook không chạy) → chạy `bash scripts/phien.sh bat-dau-tay <claude|codex>` để lấy mã.
- **Giờ** lấy bằng `date '+%Y-%m-%d %H:%M'`. Không tự đoán giờ.
- Mọi file "chỉ thêm" (tiến độ, quyết định, bài học, nhật ký) ghi qua `scripts/ghi-them.sh`. Bàn giao ghi qua `scripts/ban-giao.sh`. Hai script này có khóa, nên 2–3 phiên chạy song song không đè nhau.

## 1. Tóm tắt
3–5 gạch đầu dòng: đã làm gì, kết quả chính, còn dở gì.

## 2. Đếm việc lặp lại (không cần hỏi)
Với mỗi việc đáng kể đã làm trong phiên (báo giá, trả lời email khách, báo cáo tuần…):
1. `bash scripts/dem-viec.sh loai` → xem các tên loại việc đã có. Cùng loại thì **dùng lại đúng tên cũ**.
2. `bash scripts/dem-viec.sh ghi <loai-viec> <thư mục dự án | -> "<mô tả 1 dòng>"`.
   Việc làm bằng một kỹ năng riêng → loại việc = tên thư mục kỹ năng (để biết kỹ năng nào hay dùng).
3. `bash scripts/dem-viec.sh de-xuat` → loại việc nào hiện ra (≥ 3 lần, chưa có kỹ năng) thì đưa vào đề xuất ở bước 3.

## 3. Đề xuất cập nhật sổ
Chỉ liệt kê mục thật sự thay đổi:
```
Em đề xuất cập nhật sổ:
• Dự án <tên> — bàn giao: đã làm … · còn dở … · bước tiếp …
• Trạng thái dự án: <đang chạy / tạm dừng / xong> · hạn chót … (nếu đổi)
• Kiểm tra: <hạng mục> → đạt / lỗi / bỏ qua (lý do)
• Quyết định mới: … — lý do: … — ai chốt: …   (của dự án <tên> / chung)
• Bài học: <điều anh/chị đã sửa em>             (của dự án <tên> / chung)
• Việc "<loại việc>" anh/chị đã làm <N> lần → em đóng gói thành kỹ năng nhé? Lần sau chỉ cần nói "…".
Ghi vào sổ nhé?
```

## 4. Người dùng đồng ý (hoặc sửa) → ghi
Với **mỗi dự án** phiên đã làm (thư mục `cua-toi/du-an/<NN_ten>/`):
1. **Bàn giao** (`ban-giao.md`): đọc file trước. Khối của phiên cũ mà phiên này đã làm tiếp hoặc đã hết hiệu lực → đưa mã vào `--thay`. Khối của phiên khác **đang mở** thì không đụng vào, script cũng tự chặn.
   ```bash
   bash scripts/ban-giao.sh ghi <NN_ten> <mã phiên> [--thay <mã cũ>] <<'EOF'
   **Mục tiêu phiên:** …
   **Đã làm:** …
   **File liên quan:** san-pham/…, tai-lieu/…
   **Kiểm tra:** … (đạt / lỗi / chưa làm)
   **Còn dở / rủi ro:** …
   **Bước tiếp:** …
   EOF
   ```
2. **Tiến độ:** `bash scripts/ghi-them.sh cua-toi/du-an/<NN_ten>/tien-do.md`, nội dung `## <giờ> — <chủ đề> (phiên <8 ký tự đầu của mã>)` + 2–4 gạch.
3. **Trạng thái:** `bash scripts/du-an.sh dat <NN_ten> buoc_tiep "…"`. Đổi thì chạy thêm với `trang_thai` (dang-chay | tam-dung | da-xong) hoặc `han_chot`.
4. **Kiểm tra** (`kiem-tra.md`): đọc lại file **ngay trước khi sửa**, chỉ sửa đúng dòng hạng mục đó, hoặc thêm hạng mục mới. Không đánh "đạt" khi chưa thật sự kiểm tra. "Bỏ qua" phải có lý do.
5. **Quyết định / bài học:** của riêng dự án → `du-an/<NN_ten>/quyet-dinh.md` · `bai-hoc.md`; chung → `cua-toi/quyet-dinh.md` · `cua-toi/bai-hoc.md`. Thêm một dòng bảng qua `ghi-them.sh`, kèm ngày hôm nay.

Việc lớn mới chưa có thư mục dự án → `bash scripts/du-an.sh tao <ten-khong-dau> "<Tên>"` → `bash scripts/phien.sh gan <mã phiên> <NN_ten>` → điền `tong-quan.md` → thêm 1 dòng vào bảng dự án trong `cua-toi/AGENTS.md`.

Người dùng đồng ý đóng gói việc lặp lại → chạy kỹ năng `tao-ky-nang`. Người dùng nói không cần → `bash scripts/dem-viec.sh khong <loai-viec>`.

## 5. Luôn làm (không cần hỏi)
1. **Nhật ký phiên** (đường dẫn trong khối đầu phiên, mỗi phiên một file riêng):
   ```bash
   bash scripts/ghi-them.sh cua-toi/nhat-ky/<file của phiên>.md <<'EOF'
   ## <giờ> — <chủ đề phiên>
   - <3–5 dòng tóm tắt>
   - Dự án: <NN_ten hoặc "không">
   - Bước tiếp: …
   EOF
   ```
2. `bash scripts/phien.sh chot <mã phiên>`
3. `bash scripts/luu-so.sh "chot-phien: <chủ đề>"`

## 6. Kết thúc
Một dòng: *"Đã lưu. Lần sau anh/chị chỉ cần nói 'tiếp tục <tên dự án>'."*

Người dùng vẫn làm tiếp sau khi chốt → lần chốt sau làm lại từ bước 1. Khối bàn giao của phiên này sẽ được ghi đè bằng bản mới, không sinh khối trùng.
