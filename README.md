# Trợ Lý AI

Một trợ lý AI **nhớ được anh/chị là ai, đang làm gì, đã quyết định gì**, qua mọi lần trò chuyện. Nó chạy trên máy Mac, anh/chị có thể nói chuyện với nó từ iPhone.

Lần đầu mở, trợ lý sẽ **hỏi anh/chị khoảng 10 phút** về công việc, rồi tự thiết lập cho đúng cách anh/chị làm việc.

---

## Cần chuẩn bị

- Một máy **Mac** có Internet (nên để máy luôn bật nếu muốn dùng từ điện thoại).
- Tài khoản **Claude** trả phí (Pro hoặc Max) — đăng ký tại claude.ai.
- *(Không bắt buộc)* Tài khoản **ChatGPT** nếu muốn dùng thêm Codex.

## Cài đặt (1 lần, khoảng 15 phút)

### Cách 1 — Dán 1 dòng lệnh (khuyên dùng)

1. Mở ứng dụng **Terminal** (nhấn `⌘ + Space`, gõ "Terminal", nhấn Enter).
2. Dán dòng sau vào rồi nhấn Enter:
   ```bash
   git clone https://github.com/Liemdang2512/tro-ly-ai.git ~/Documents/tro-ly-ai && bash ~/Documents/tro-ly-ai/CAI-DAT.command
   ```
   - **Máy mới lần đầu dùng lệnh này**, Mac sẽ hiện hộp thoại đòi cài *"Command Line Tools"* → bấm **Cài đặt**, chờ vài phút cho xong → **dán lại dòng lệnh trên** một lần nữa.
3. Trình duyệt sẽ mở để **đăng nhập tài khoản Claude** — đăng nhập xong quay lại cửa sổ Terminal.
4. Nếu được hỏi *"Do you trust the files in this folder?"* → chọn **Yes**.
5. Trợ lý bắt đầu hỏi. **Trả lời bằng lời bình thường**, câu nào chưa muốn trả lời thì gõ "bỏ qua".

Cách này cập nhật tự động được (xem mục *Cập nhật bản mới*) và không bị Mac chặn.

### Cách 2 — Tải file nén (nếu cách 1 không được)

1. Bấm **[tải Trợ Lý AI (file .zip)](https://github.com/Liemdang2512/tro-ly-ai/archive/refs/heads/main.zip)** → mở file vừa tải để giải nén → kéo thư mục `tro-ly-ai-main` vào *Tài liệu* (Documents). Đừng xóa file bên trong.
2. **Bấm đúp file `CAI-DAT.command`.**
   - Nếu Mac báo *"không thể mở vì không xác minh được nhà phát triển"*: bấm chuột phải (hoặc Control + bấm) vào file → chọn **Mở** → **Mở**.
   - Vẫn không được: mở **Terminal**, gõ `bash ` (có dấu cách), kéo file `CAI-DAT.command` vào cửa sổ Terminal, nhấn Enter.
3. Làm tiếp bước 3–5 của Cách 1.

Lưu ý: bản tải kiểu này **không tự cập nhật** được.

---

Xong. Lần sau muốn mở trên Mac: vào thư mục Trợ Lý AI, **bấm đúp `MO-TRO-LY.command`**.

## Dùng hằng ngày

Cứ nói chuyện bình thường. Có **3 câu đặc biệt**:

| Anh/chị nói | Trợ lý làm |
|---|---|
| **"tiếp tục"** hoặc **"tiếp tục [tên việc]"** | Nhắc lại đang làm tới đâu và bước tiếp theo |
| **"nhớ cái này: …"** | Ghi vào sổ để lần sau vẫn nhớ (hỏi anh/chị trước khi ghi) |
| **"chốt"** | Cuối buổi: tóm tắt và cập nhật sổ |

Thêm vài câu hữu ích:
- **"tạo kỹ năng [tên việc]"** — dạy trợ lý một việc hay lặp lại, lần sau chỉ cần gọi tên.
- **"dọn dẹp"** — mỗi tuần một lần, trợ lý rà lại sổ, gộp trùng, bỏ cái cũ.
- **"thiết lập lại"** — đổi thông tin cá nhân, cách làm việc.

## Dùng từ iPhone

Máy Mac phải **đang bật và có mạng**.

**Với Claude** (khuyên dùng):
1. Trên Mac, cài app **Claude** (claude.ai/download) và đăng nhập cùng tài khoản.
2. Mở app → **Settings → Claude Code** → bật **"Use this computer from your phone and claude.ai"** → thêm thư mục Trợ Lý AI vào danh sách.
3. Trên iPhone, mở app **Claude** → mục **Code** → chọn máy Mac và thư mục này → nói chuyện như bình thường.

**Với ChatGPT (Codex)** *(không bắt buộc)*:
1. Trên Mac, cài app **Codex**, mở thư mục Trợ Lý AI.
2. Codex hiện mã QR → quét bằng app **ChatGPT** trên iPhone.
3. Codex tự đọc `AGENTS.md` nên dùng chung sổ nhớ và 3 câu đặc biệt như Claude.

*(Các tính năng điều khiển từ điện thoại do Anthropic/OpenAI cung cấp và có thể thay đổi tên menu theo thời gian. Không tìm thấy thì nhờ người quản trị.)*

## Dữ liệu của anh/chị nằm ở đâu?

Tất cả trong thư mục **`cua-toi`**: hồ sơ, dự án, quyết định, bài học, nhật ký. Đều là file chữ, mở bằng bất kỳ ứng dụng ghi chú nào cũng đọc được.

- Trợ lý **không ghi** mật khẩu, số tài khoản, OTP và những gì anh/chị dặn không ghi.
- Mọi thứ gửi ra ngoài (email, tin nhắn) trợ lý **chỉ soạn sẵn**, anh/chị tự gửi.
- **Sao lưu:** bật Time Machine, hoặc định kỳ chép thư mục `cua-toi` sang ổ khác / iCloud Drive.
- Có ghi nhầm? Nói với trợ lý *"khôi phục sổ về hôm qua"* — thư mục `cua-toi` có lưu lịch sử thay đổi (nếu máy đã cài công cụ git).

## Cập nhật bản mới

Bấm đúp **`CAP-NHAT.command`**. Dữ liệu trong `cua-toi` giữ nguyên.

## Gặp sự cố

| Hiện tượng | Cách xử lý |
|---|---|
| Bấm đúp không mở được | Xem bước 2 phần Cài đặt |
| Trợ lý không nhớ gì | Nói "đọc lại hồ sơ của tôi". Vẫn không được → kiểm tra thư mục `cua-toi` còn đó không |
| Trợ lý hỏi xin phép liên tục | Chọn "Yes, and don't ask again" cho thao tác an toàn, hoặc nhờ người quản trị |
| iPhone không thấy máy Mac | Mac có đang bật, có mạng, app Claude có đang mở không |

Người quản trị xem thêm: [QUAN-TRI.md](QUAN-TRI.md).
