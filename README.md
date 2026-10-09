# Trợ Lý AI

Một trợ lý AI **nhớ được anh/chị là ai, đang làm gì, đã quyết định gì**, qua mọi lần trò chuyện. Chạy trên máy **Mac** hoặc **Windows**, dùng với **Claude** (khuyên dùng) hoặc **ChatGPT Codex**. Trên Mac còn dùng được từ iPhone.

Lần đầu mở, trợ lý sẽ **hỏi anh/chị khoảng 10 phút** về công việc, rồi tự thiết lập cho đúng cách anh/chị làm việc.

---

## Cài đặt nhanh: 3 bước, khoảng 15 phút

| Bước | Anh/chị làm | Ghi chú |
|---|---|---|
| **1. Chuẩn bị** | Có sẵn một tài khoản **Claude trả phí** (Pro hoặc Max), đăng ký tại [claude.ai](https://claude.ai) | Chưa có tài khoản thì đăng ký trước, rồi mới cài. Máy cần có Internet |
| **2. Cài** | **Mac:** mở **Terminal**, dán 1 dòng lệnh (xem mục *Cài đặt trên Mac*). **Windows:** tải file ZIP, bấm đúp `CAI-DAT.bat` (xem mục *Cài đặt trên Windows*) | Bộ cài tự lo phần còn lại. Cửa sổ hiện chữ chạy liên tục là bình thường, đừng đóng |
| **3. Trả lời** | Đăng nhập Claude khi trình duyệt mở ra, rồi **trả lời các câu trợ lý hỏi** (khoảng 10 phút) | Câu nào chưa muốn trả lời thì gõ "bỏ qua". Hỏi tin tưởng thư mục thì chọn **Yes** |

Làm xong là dùng được ngay. Kẹt ở bước nào thì xem mục *Gặp sự cố* ở cuối, hoặc chụp màn hình gửi người đã đưa anh/chị bộ này.

## Cần chuẩn bị

- Máy **Mac** hoặc **Windows 10/11**, có Internet.
- Tài khoản **Claude** trả phí (Pro hoặc Max). Đăng ký tại claude.ai.
- *(Không bắt buộc)* Tài khoản **ChatGPT** nếu muốn dùng thêm Codex.
- Quyền cài phần mềm trên máy (máy công ty có thể bị chặn, hỏi bộ phận IT).

> **Đừng cài vào thư mục đang đồng bộ đám mây** (iCloud Drive, OneDrive, Dropbox, Google Drive). Đồng bộ dễ làm hỏng sổ nhớ và sinh file trùng. Bộ cài sẽ cảnh báo nếu phát hiện.

> **Về dữ liệu:** bộ này tải từ GitHub nhưng **dữ liệu của anh/chị không bao giờ được gửi lên GitHub**. Mọi thứ anh/chị nói với trợ lý, hồ sơ, dự án đều nằm trong thư mục `cua-toi` trên máy của anh/chị.

## Cài đặt trên Mac (1 lần, khoảng 15 phút)

### Cách 1: Dán 1 dòng lệnh (khuyên dùng)

1. Mở ứng dụng **Terminal** (nhấn `⌘ + Space`, gõ "Terminal", nhấn Enter).
2. Dán dòng sau vào rồi nhấn Enter:
   ```bash
   git clone https://github.com/Liemdang2512/tro-ly-ai.git ~/tro-ly-ai && bash ~/tro-ly-ai/CAI-DAT.command
   ```
   - **Máy mới lần đầu dùng lệnh này:** Mac hiện hộp thoại đòi cài *"Command Line Tools"* → bấm **Cài đặt**, chờ vài phút cho xong → **dán lại dòng lệnh trên** một lần nữa.
3. Claude Code hỏi vài câu lúc mở lần đầu: chọn giao diện (Enter để lấy mặc định), chọn **đăng nhập bằng tài khoản Claude** (Claude account with subscription). Trình duyệt mở ra, đăng nhập xong thì quay lại cửa sổ Terminal.
4. Nếu được hỏi *"Do you trust the files in this folder?"* → chọn **Yes**.
5. Trợ lý bắt đầu hỏi. **Trả lời bằng lời bình thường**, câu nào chưa muốn trả lời thì gõ "bỏ qua".

Cách này cập nhật tự động được (xem mục *Cập nhật bản mới*) và không bị Mac chặn.

### Cách 2: Tải file nén (nếu cách 1 không được)

1. Bấm **[tải Trợ Lý AI (file .zip)](https://github.com/Liemdang2512/tro-ly-ai/archive/refs/heads/main.zip)** → mở file vừa tải để giải nén → kéo thư mục `tro-ly-ai-main` vào **thư mục nhà** của anh/chị (thư mục có hình ngôi nhà trong Finder). Đừng xóa file bên trong.
2. **Bấm đúp file `CAI-DAT.command`.** Nếu Mac báo *"không thể mở vì không xác minh được nhà phát triển"*:
   - Bấm **Xong**, vào **Cài đặt hệ thống → Quyền riêng tư & Bảo mật**, kéo xuống dưới cùng, bấm **"Vẫn mở"**, rồi nhập mật khẩu máy.
   - Vẫn không được: mở **Terminal**, gõ `bash ` (có dấu cách), kéo file `CAI-DAT.command` vào cửa sổ Terminal, nhấn Enter.
3. Làm tiếp bước 3–5 của Cách 1.

Lưu ý: bản tải kiểu này **không tự cập nhật** được.

Lần sau muốn mở trên Mac: vào thư mục Trợ Lý AI, **bấm đúp `MO-TRO-LY.command`**.

## Cài đặt trên Windows (thử nghiệm)

> Bản Windows chưa được thử trên máy thật. Gặp lỗi thì chụp màn hình gửi người quản trị.

1. Bấm **[tải Trợ Lý AI (file .zip)](https://github.com/Liemdang2512/tro-ly-ai/archive/refs/heads/main.zip)** → bấm chuột phải file vừa tải → **Extract All** → giải nén vào `C:\Users\<tên anh/chị>\` (**không** để trong Documents hay Desktop nếu máy đang bật OneDrive).
2. Vào thư mục vừa giải nén, **bấm đúp `CAI-DAT.bat`**.
   - Windows báo *"Windows protected your PC"* → bấm **More info** → **Run anyway**.
   - Bộ cài tự cài **Git for Windows** (bắt buộc, để lưu lịch sử sổ nhớ) và **Claude Code**. Có hộp thoại xin quyền thì bấm **Yes**.
3. Làm tiếp bước 3–5 của phần Mac.

Lần sau muốn mở: **bấm đúp `MO-TRO-LY.bat`**. Cập nhật: **bấm đúp `CAP-NHAT.bat`** (chỉ chạy được nếu cài bằng `git clone`).

## Dùng hằng ngày

Cứ nói chuyện bình thường. Có **3 câu đặc biệt**:

| Anh/chị nói | Trợ lý làm |
|---|---|
| **"tiếp tục"** hoặc **"tiếp tục [tên việc]"** | Nhắc lại đang làm tới đâu và bước tiếp theo |
| **"nhớ cái này: …"** | Ghi vào sổ để lần sau vẫn nhớ (hỏi anh/chị trước khi ghi) |
| **"chốt"** | Cuối buổi: tóm tắt và cập nhật sổ |

Thêm vài câu hữu ích:
- **"em biết làm những gì?"**: xem các kỹ năng riêng và câu gọi.
- **"tạo kỹ năng [tên việc]"**: dạy trợ lý một việc hay lặp lại. Việc nào anh/chị làm từ 3 lần, trợ lý sẽ **tự gợi ý** đóng gói.
- **"khôi phục"**: lấy lại sổ của lúc trước nếu lỡ ghi nhầm.
- **"dọn dẹp"**: mỗi tuần một lần, trợ lý rà lại sổ, gộp trùng, bỏ cái cũ.
- **"thiết lập lại"**: đổi thông tin cá nhân, cách làm việc.

**Không cần lo mất việc:**
- **Quên "chốt", đóng cửa sổ luôn?** Lần mở sau, trợ lý hỏi có muốn đọc lại và bổ sung sổ không.
- **Mở 2–3 cửa sổ cùng lúc** (kể cả Claude và Codex cùng lúc)? Mỗi cửa sổ ghi bàn giao riêng, không đè nhau.
- **Trò chuyện dài, trợ lý tự tóm tắt bớt** (hiện chữ "compact")? Trợ lý tự đọc lại sổ và ghi nháp ngay, không mất mạch.

## Dùng với ChatGPT Codex (không bắt buộc)

1. Cài app **Codex** (hoặc Codex CLI), mở thư mục Trợ Lý AI.
2. **Lần đầu:** khi Codex hỏi có tin tưởng thư mục này không → chọn **tin tưởng (trust)**. Sau đó gõ **`/hooks`** → chọn **tin tưởng (trust)** các hook của Trợ Lý AI. Các hook này giúp tự ghi lại phiên khi đóng cửa sổ hay khi hội thoại được tóm tắt. Làm 1 lần, lần sau không phải làm nữa.
3. Codex dùng chung sổ nhớ và các câu đặc biệt như Claude.
4. Muốn dùng từ iPhone: Codex hiện mã QR → quét bằng app **ChatGPT**.

## Dùng từ iPhone (Mac)

Máy Mac phải **đang bật và có mạng**.
1. Trên Mac, cài app **Claude** (claude.ai/download) và đăng nhập cùng tài khoản.
2. Mở app → **Settings → Claude Code** → bật **"Use this computer from your phone and claude.ai"** → thêm thư mục Trợ Lý AI vào danh sách.
3. Trên iPhone, mở app **Claude** → mục **Code** → chọn máy Mac và thư mục này → nói chuyện như bình thường.

*(Các tính năng điều khiển từ điện thoại do Anthropic/OpenAI cung cấp, tên menu có thể thay đổi theo thời gian. Không tìm thấy thì nhờ người quản trị.)*

## Dữ liệu của anh/chị nằm ở đâu?

Tất cả trong thư mục **`cua-toi`**. Đều là file chữ, mở bằng bất kỳ ứng dụng ghi chú nào cũng đọc được:

| Ở đâu | Có gì |
|---|---|
| `ho-so.md` | Anh/chị là ai, thích làm việc thế nào |
| `du-an/01_ten-du-an/` | **Mỗi dự án một thư mục**: `ban-giao.md` (đang tới đâu, bước tiếp), `tien-do.md`, `quyet-dinh.md`, `bai-hoc.md`, `kiem-tra.md`, `tai-lieu/` (anh/chị đưa), `san-pham/` (trợ lý làm ra) |
| `ky-nang/` | **Mỗi kỹ năng một thư mục**: cách làm (`SKILL.md`) + mẫu, bảng giá, ví dụ của anh/chị. `HUONG-DAN.md` là sổ tay các việc trợ lý đã học, kèm câu gọi |
| `nhat-ky/` | Mỗi buổi làm việc một trang |

- Trợ lý **không ghi** mật khẩu, số tài khoản, OTP và những gì anh/chị dặn không ghi.
- Mọi thứ gửi ra ngoài (email, tin nhắn), trợ lý **chỉ soạn sẵn**, anh/chị tự gửi.
- **Sao lưu:** bật Time Machine (Mac) / File History (Windows), hoặc định kỳ chép thư mục `cua-toi` sang ổ khác.

## Cập nhật bản mới

Bấm đúp **`CAP-NHAT.command`** (Mac) hoặc **`CAP-NHAT.bat`** (Windows). Dữ liệu trong `cua-toi` giữ nguyên. Sổ dự án kiểu cũ sẽ được trợ lý **hỏi trước** rồi mới chuyển sang dạng thư mục.

## Gặp sự cố

| Hiện tượng | Cách xử lý |
|---|---|
| Bấm đúp không mở được | Xem bước 2 phần Cài đặt |
| Mac hiện hộp thoại "Command Line Tools" rồi dòng lệnh dừng | Bấm **Cài đặt**, chờ xong, **dán lại đúng dòng lệnh** một lần nữa |
| Báo `claude: command not found` | Đóng cửa sổ Terminal, mở lại, rồi bấm đúp `MO-TRO-LY.command` (hoặc `MO-TRO-LY.bat` trên Windows) |
| Trình duyệt không mở để đăng nhập | Trong cửa sổ trợ lý, làm theo đường link hiện ra, dán vào trình duyệt thủ công |
| Đăng nhập xong báo không có quyền dùng Claude Code | Tài khoản phải là **Pro hoặc Max**. Gói miễn phí không dùng được |
| Cài ở máy công ty bị chặn | Hỏi bộ phận IT cho phép cài Claude Code và Git, hoặc dùng máy cá nhân |
| Trợ lý không nhớ gì | Nói "đọc lại hồ sơ của tôi". Vẫn không được → kiểm tra thư mục `cua-toi` còn đó không |
| Trợ lý hỏi xin phép liên tục | Chọn "Yes, and don't ask again" cho thao tác an toàn, hoặc nhờ người quản trị |
| Codex không nhắc phiên cũ, không tự lưu khi đóng | Chưa tin tưởng hook. Gõ `/hooks` trong Codex → trust |
| iPhone không thấy máy Mac | Mac có đang bật, có mạng, app Claude có đang mở không |

Người quản trị xem thêm: [QUAN-TRI.md](QUAN-TRI.md).
