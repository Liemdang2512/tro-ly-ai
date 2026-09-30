---
name: thiet-lap
description: Phỏng vấn người dùng lần đầu (hoặc khi họ muốn cập nhật) rồi tạo thư mục cua-toi/ gồm hồ sơ, luật riêng, gói nghề và dự án. Dùng khi chưa có cua-toi/AGENTS.md, hoặc khi người dùng nói "thiết lập", "thiết lập lại", "đổi thông tin của tôi".
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
5. Chọn các mảng gần với công việc nhất (chọn nhiều): liệt kê từng gói trong thư mục `goi/` bằng **tên thân thiện + mô tả 1 dòng** lấy từ đầu file `GOI.md`.
6. 3 việc **lặp đi lặp lại, tốn thời gian nhất** hằng tuần là gì?
7. Việc gì hay **bị sai hoặc phải sửa đi sửa lại** nhất?

**C. Cách làm việc với em**
8. Anh/chị thích câu trả lời: 1. Ngắn gọn, vào thẳng kết luận  2. Vừa phải  3. Chi tiết, có giải thích
9. Khi giao việc chưa rõ, em nên: 1. Hỏi kỹ trước khi làm  2. Làm luôn theo phán đoán rồi hỏi sau
10. Có từ ngữ/thuật ngữ riêng của công ty em cần biết không? (tên sản phẩm, viết tắt, tên người hay nhắc)

**D. Giới hạn và an toàn**
11. Thông tin nào em **tuyệt đối không được ghi nhớ**? (ví dụ: lương, thông tin khách hàng, hợp đồng…)
12. Việc nào em **phải hỏi trước** khi làm? (mặc định: mọi thứ gửi ra ngoài đều chỉ soạn sẵn — hỏi anh/chị có muốn thêm gì)
13. Có ai khác duyệt/quyết định cùng anh/chị không (sếp, kế toán, pháp chế…)? Việc gì cần họ duyệt?

**E. Việc đang làm**
14. Hiện anh/chị đang theo dõi những việc/dự án lớn nào? (1–5 việc). Với mỗi việc: mục tiêu là gì, đang ở bước nào, bước tiếp theo là gì, hạn chót (nếu có).

**F. Công cụ**
15. Anh/chị đang dùng: Gmail/Outlook? Lịch Google/Outlook? Lưu tài liệu ở Google Drive/OneDrive/máy tính? Nhắn việc qua Zalo/Telegram/Slack? (chỉ để em biết, không cần kết nối ngay)

## Xác nhận

Tóm tắt lại **tối đa 12 dòng** bằng lời thường (không nhắc tên file): gọi là gì, làm gì, gói nghề đã chọn, 3 việc lặp lại, cách trả lời, những gì không ghi nhớ, việc phải hỏi trước, các dự án. Hỏi: *"Em hiểu vậy đúng chưa? Có gì cần sửa không?"* — sửa tới khi người dùng đồng ý.

## Tạo file (sau khi người dùng đồng ý)

Dùng mẫu trong `mau/cua-toi/`, thay các chỗ `{{…}}` bằng câu trả lời. Không để sót `{{`.

1. `cua-toi/ho-so.md` ← `mau/cua-toi/ho-so.md` (nhóm A, B, C, F).
2. `cua-toi/AGENTS.md` ← `mau/cua-toi/AGENTS.md`:
   - Liệt kê gói nghề đã chọn, mỗi gói một dòng trỏ tới `goi/<ten>/GOI.md`.
   - Ghi luật riêng từ nhóm C và D (không ghi nhớ gì, phải hỏi trước việc gì, ai duyệt gì).
   - Bảng dự án trỏ tới từng file trong `cua-toi/du-an/`.
3. Mỗi dự án ở câu 14 → `cua-toi/du-an/<ten-khong-dau-gach-noi>.md` ← `mau/cua-toi/du-an.md`.
4. `cua-toi/quyet-dinh.md`, `cua-toi/bai-hoc.md` ← mẫu tương ứng (để trống bảng).
5. Tạo thư mục `cua-toi/nhat-ky/`, `cua-toi/tai-lieu/`, `cua-toi/ky-nang/` (mỗi thư mục có file `.gitkeep`).
6. Ghi `cua-toi/nhat-ky/<hôm nay>.md`: "Thiết lập lần đầu."
7. Nếu `cua-toi/` là git repo (có `cua-toi/.git`): `git -C cua-toi add -A && git -C cua-toi commit -m "thiet-lap: ho so ban dau"`.

## Kết thúc

1. Với **3 việc lặp lại** ở câu 6: đề xuất đóng gói việc dễ nhất thành kỹ năng — *"Anh/chị có muốn em làm quy trình cho việc X luôn không? Lần sau chỉ cần nói 'làm X'."* Đồng ý → chạy `.agents/skills/tao-ky-nang/SKILL.md`.
2. Hướng dẫn cách dùng, đúng nguyên văn ý này:

> Từ giờ anh/chị cứ nói chuyện bình thường. Có 3 câu đặc biệt:
> - **"tiếp tục [tên việc]"** — em nhắc lại đang tới đâu và bước tiếp theo.
> - **"nhớ cái này: …"** — em ghi vào sổ để lần sau vẫn nhớ.
> - **"chốt"** — cuối buổi, em tóm tắt và cập nhật sổ.
> Muốn đổi thông tin thì nói **"thiết lập lại"**.
