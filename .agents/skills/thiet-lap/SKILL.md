---
name: thiet-lap
description: Phỏng vấn người dùng lần đầu (hoặc khi họ muốn cập nhật) rồi tạo thư mục cua-toi/ gồm hồ sơ, luật riêng, dự án (mỗi dự án một thư mục) và kỹ năng riêng cho các việc lặp lại. Dùng khi chưa có cua-toi/AGENTS.md, hoặc khi người dùng nói "thiết lập", "thiết lập lại", "đổi thông tin của tôi".
---

# Thiết lập Trợ Lý AI cho người dùng mới

Người dùng **không rành kỹ thuật**. Giữ giọng thân thiện, câu ngắn, không nhắc tới file, thư mục hay thuật ngữ kỹ thuật trong lúc hỏi.

## Chế độ

- **Chưa có `cua-toi/AGENTS.md`** → thiết lập mới (làm đủ các bước).
- **Đã có** → chế độ cập nhật: đọc `cua-toi/ho-so.md` + `cua-toi/AGENTS.md`, hỏi người dùng muốn đổi phần nào, chỉ hỏi lại phần đó, sửa đúng chỗ đó. **Không ghi đè** dự án, quyết định, bài học, nhật ký.

## Cách hỏi

- Mỗi lượt tối đa **3 câu**, câu nào có thể thì kèm lựa chọn đánh số (và "khác: …").
- Nếu có công cụ hỏi-có-lựa-chọn (ví dụ AskUserQuestion trong Claude) thì dùng nó; không có thì liệt kê `1. … 2. …` và để người dùng gõ số.
- Người dùng nói "bỏ qua" → ghi `[chưa rõ]`, đi tiếp. Không ép.
- Mở đầu bằng: *"Chào anh/chị! Em cần hỏi khoảng 10 phút để hiểu cách anh/chị làm việc, sau đó em sẽ nhớ luôn cho các lần sau. Câu nào chưa muốn trả lời cứ nói 'bỏ qua' nhé."* (Chưa biết xưng hô thì dùng "anh/chị" và "em".)

## Các nhóm câu hỏi (theo thứ tự)

**A. Làm quen**
1. Em nên gọi anh/chị là gì, và xưng hô thế nào (anh–em, chị–em, tôi–bạn…)?
2. Anh/chị làm ở đâu, chức vụ/vai trò là gì?
3. Công ty/đơn vị làm lĩnh vực gì, quy mô khoảng bao nhiêu người? (1 câu là đủ)

**B. Công việc**
4. Một ngày làm việc điển hình của anh/chị gồm những việc gì?
5. 3 việc **lặp đi lặp lại, tốn thời gian nhất** hằng tuần là gì? (gợi ý vài ví dụ lấy từ tên các mẫu trong `mau/ky-nang/`: làm báo giá, báo cáo tuần, trả lời khách, tóm tắt cuộc họp…)
6. Việc gì hay **bị sai hoặc phải sửa đi sửa lại** nhất?

**C. Cách làm việc với em**
7. Anh/chị thích câu trả lời: 1. Ngắn gọn, vào thẳng kết luận  2. Vừa phải  3. Chi tiết, có giải thích
8. Khi giao việc chưa rõ, em nên: 1. Hỏi kỹ trước khi làm  2. Làm luôn theo phán đoán rồi hỏi sau
9. Có từ ngữ/thuật ngữ riêng của công ty em cần biết không? (tên sản phẩm, viết tắt, tên người hay nhắc)

**D. Giới hạn và an toàn**
10. Thông tin nào em **tuyệt đối không được ghi nhớ**? (ví dụ: lương, thông tin khách hàng, hợp đồng…)
11. Việc nào em **phải hỏi trước** khi làm? (mặc định: mọi thứ gửi ra ngoài đều chỉ soạn sẵn — hỏi anh/chị có muốn thêm gì)
12. Có ai khác duyệt/quyết định cùng anh/chị không (sếp, kế toán, pháp chế…)? Việc gì cần họ duyệt?

**E. Việc đang làm**
13. Hiện anh/chị đang theo dõi những việc/dự án lớn nào? (1–5 việc). Với mỗi việc: mục tiêu là gì, đang ở bước nào, bước tiếp theo là gì, hạn chót (nếu có).

**F. Công cụ**
14. Anh/chị đang dùng: Gmail/Outlook? Lịch Google/Outlook? Lưu tài liệu ở Google Drive/OneDrive/máy tính? Nhắn việc qua Zalo/Telegram/Slack? (chỉ để em biết, không cần kết nối ngay)

## Xác nhận

Tóm tắt lại **tối đa 12 dòng** bằng lời thường (không nhắc tên file): gọi là gì, làm gì, 3 việc lặp lại, cách trả lời, những gì không ghi nhớ, việc phải hỏi trước, các dự án. Hỏi: *"Em hiểu vậy đúng chưa? Có gì cần sửa không?"* — sửa tới khi người dùng đồng ý.

## Tạo file (sau khi người dùng đồng ý)

Mã phiên lấy từ khối `[Trợ Lý AI — thông tin đầu phiên]`. Không có khối này → `bash scripts/phien.sh bat-dau-tay <claude|codex>`. Thay mọi chỗ `{{…}}` trong mẫu bằng câu trả lời, không để sót `{{`.

1. `cua-toi/ho-so.md` ← `mau/cua-toi/ho-so.md` (nhóm A, B, C, F).
2. `cua-toi/quyet-dinh.md`, `cua-toi/bai-hoc.md` ← mẫu tương ứng (để trống bảng).
3. Tạo `cua-toi/nhat-ky/`, `cua-toi/tai-lieu/`, `cua-toi/ky-nang/` (mỗi thư mục một file `.gitkeep`). Chép `mau/cua-toi/ky-nang-HUONG-DAN.md` → `cua-toi/ky-nang/HUONG-DAN.md`.
4. Mỗi dự án ở câu 13:
   1. `bash scripts/du-an.sh tao <ten-khong-dau> "<Tên dự án>"`
   2. Điền `tong-quan.md` của dự án (mục tiêu, hạn chót, người liên quan, bối cảnh).
   3. Ghi khối bàn giao đầu tiên (đang ở, bước tiếp): `bash scripts/ban-giao.sh ghi <NN_ten> <mã phiên>`.
   4. Đặt trạng thái: `bash scripts/du-an.sh dat <NN_ten> buoc_tiep "…"`, và `han_chot` nếu có.
5. **Cuối cùng mới tạo** `cua-toi/AGENTS.md` ← `mau/cua-toi/AGENTS.md`: luật riêng từ nhóm C, D; bảng dự án, mỗi dự án một dòng trỏ tới thư mục `du-an/<NN_ten>/`. File này là dấu hiệu "đã thiết lập xong". Tạo sau cùng để nếu bị ngắt giữa chừng, lần sau sẽ thiết lập lại thay vì chạy với hồ sơ thiếu.
6. Ghi nhật ký phiên "Thiết lập lần đầu." qua `bash scripts/ghi-them.sh` (đường dẫn trong khối đầu phiên).
7. `bash scripts/luu-so.sh "thiet-lap: ho so ban dau"`.

## Kết thúc

1. Với **3 việc lặp lại** ở câu 5: mỗi việc đặt một tên loại việc rồi ghi `bash scripts/dem-viec.sh ghi <loai-viec> - "khai báo lúc thiết lập"`. Sau đó đề xuất đóng gói việc dễ nhất thành kỹ năng ngay: *"Anh/chị có muốn em làm quy trình cho việc X luôn không? Lần sau chỉ cần nói 'làm X'."* Đồng ý → chạy kỹ năng `tao-ky-nang` (có mẫu sẵn trong `mau/ky-nang/` thì chỉ cần hỏi phần riêng).
2. Hướng dẫn cách dùng, đúng nguyên văn ý này:

> Từ giờ anh/chị cứ nói chuyện bình thường. Có 3 câu đặc biệt:
> - **"tiếp tục [tên việc]"**: em nhắc lại đang tới đâu và bước tiếp theo.
> - **"nhớ cái này: …"**: em ghi vào sổ để lần sau vẫn nhớ.
> - **"chốt"**: cuối buổi, em tóm tắt và cập nhật sổ. Quên chốt cũng không sao, lần sau em sẽ hỏi để bổ sung.
> Việc nào anh/chị làm đi làm lại, em sẽ gợi ý đóng gói để lần sau chỉ cần gọi tên. Muốn đổi thông tin thì nói **"thiết lập lại"**.
