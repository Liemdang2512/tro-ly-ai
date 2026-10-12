---
name: tiep-tuc
description: Nhắc lại việc đang dở và bước tiếp theo từ bàn giao của dự án; bù sổ cho phiên trước đóng mà chưa chốt. Dùng khi người dùng nói "tiếp tục", "đang tới đâu", "hôm nay làm gì", hoặc nhắc tên một dự án.
---

# Tiếp tục

Mã phiên và danh sách dự án có sẵn trong khối `[Trợ Lý AI — thông tin đầu phiên]`. Không thấy khối này → `bash scripts/phien.sh bat-dau-tay <claude|codex>`.

## 1. Phiên cũ chưa chốt (nếu khối đầu phiên có liệt kê)
Hỏi trước: *"Lần trước (<ngày>, dự án <tên>) anh/chị đóng cửa sổ mà chưa chốt. Em đọc lại và bổ sung sổ nhé?"*
- **Đồng ý:**
  1. Đọc file hội thoại có đường dẫn trong khối. File thường dài: chỉ lấy phần cuối và các tin nhắn chính, dùng `tail`/`grep`.
  2. Đề xuất cập nhật sổ như bước 3 của `chot-phien`.
  3. Người dùng đồng ý thì ghi bàn giao **dưới mã phiên cũ**: `bash scripts/ban-giao.sh ghi <NN_ten> <mã cũ>`.
  4. Ghi nhật ký vào file nhật ký của phiên hiện tại, tiêu đề "Bổ sung phiên <mã cũ>".
  5. Chạy `bash scripts/phien.sh da-bu <mã cũ>`.
- **"Bỏ qua":** chạy `bash scripts/phien.sh da-bu <mã cũ>` để không nhắc lại. **"Để sau":** không làm gì.

## 2. Chọn dự án
- Người dùng có nhắc tên → `bash scripts/du-an.sh tim "<từ khóa>"`. Nhiều kết quả khớp thì hỏi lại.
- Không nhắc tên → đưa danh sách dự án (tên · bước tiếp · hạn) từ khối đầu phiên hoặc `bash scripts/du-an.sh ds`, rồi hỏi làm việc nào.
- Còn dự án kiểu cũ (1 file `.md` trong `du-an/`) → hỏi người dùng rồi chạy `bash scripts/du-an.sh chuyen-v01`.

## 3. Gắn phiên vào dự án
`bash scripts/phien.sh gan <mã phiên> <NN_ten>`. Từ đây, lúc đóng phiên hay nén hội thoại, máy tự ghi dấu vết vào đúng thư mục dự án.

## 4. Đọc
Trong `cua-toi/du-an/<NN_ten>/`:
1. `ban-giao.md`: **tất cả khối** hiện có. Nhiều khối nghĩa là có nhiều mạch việc song song.
2. `tien-do.md`: khoảng 20 dòng cuối.
3. `kiem-tra.md`, `bai-hoc.md`, `quyet-dinh.md`. Cần mục tiêu, bối cảnh thì đọc thêm `tong-quan.md`.

Đọc thêm `cua-toi/bai-hoc.md` (phần liên quan).

## 5. Trả lời (ngắn, không quá 10 dòng)
```
📌 <Tên dự án> — <mục tiêu 1 câu>
Đang ở: …
Còn dở: …            (nhiều khối bàn giao → liệt kê từng mạch: "Mạch A (phiên …): …")
Bước tiếp theo em đề xuất: …
⚠️ Lưu ý: <hạn chót gần · kiểm tra còn "chưa làm"/"lỗi" · phiên khác đang mở cùng dự án · bài học liên quan>
```
Hỏi: *"Mình làm bước tiếp theo luôn nhé?"*

## 6. Sổ có vẻ cũ hoặc mâu thuẫn
Ví dụ: đã quá hạn, hoặc bước tiếp đã làm rồi. Nói rõ điều đó, hỏi người dùng tình hình thực tế, rồi đề xuất cập nhật sổ (theo luật "đề xuất trước, ghi sau").
