# Kiểm tra bản Windows (chạy tay trên máy thật hoặc máy ảo)

Bản Windows chưa được chạy thật. Ghi kết quả từng dòng (đạt / hỏng + ảnh chụp) rồi gửi lại cho người quản trị.

## A. Cài mới (máy chưa có Git, chưa có Claude Code)
1. Giải nén ZIP vào `C:\Users\<tên>\tro-ly-ai-main` → bấm đúp `CAI-DAT.bat`.
   - [ ] Chữ tiếng Việt hiển thị đúng dấu trong cửa sổ.
   - [ ] Tự cài Git for Windows qua winget.
   - [ ] Tự cài Claude Code, gõ `claude --version` trong cửa sổ mới chạy được.
   - [ ] `.claude\skills` là junction (`dir /AL .claude` thấy `<JUNCTION>`), mở vào thấy các kỹ năng.
   - [ ] `cua-toi\.git` và `cua-toi\.gitignore` được tạo.
   - [ ] Claude mở với câu "thiết lập".
2. Giải nén vào `Documents` khi OneDrive bật → [ ] bộ cài cảnh báo đồng bộ.

## B. Hook của Claude Code trên Windows
3. Trong phiên Claude, hỏi: "mã phiên của bạn là gì?"
   - [ ] Trả lời đúng mã có trong khối `[Trợ Lý AI — thông tin đầu phiên]`. Nếu không: hook không chạy, ghi lại lỗi trong `claude --debug`.
4. Đóng cửa sổ không "chốt" → mở lại bằng `MO-TRO-LY.bat`.
   - [ ] Trợ lý hỏi bù sổ cho phiên chưa chốt.
5. [ ] `bash tests/test-v02.sh` trong Git Bash: 0 hỏng.

## C. Codex trên Windows
6. Mở Codex trong thư mục, trust dự án, `/hooks` → trust.
   - [ ] Hỏi mã phiên → đúng (hook `commandWindows` gọi `C:\Program Files\Git\bin\bash.exe`; Git cài chỗ khác thì hỏng, ghi lại đường dẫn Git).

## D. Cập nhật
7. Cài bằng `git clone` → bấm `CAP-NHAT.bat` → [ ] cập nhật xong, junction vẫn còn, dữ liệu `cua-toi` giữ nguyên.

## Điểm chưa chắc cần để ý
- Claude Code chạy hook bằng Git Bash hay PowerShell trên máy này (lệnh hook dùng `bash`).
- Đường dẫn có dấu tiếng Việt / dấu cách trong tên người dùng Windows.
- Windows Defender / SmartScreen chặn `.bat` tải từ Internet.
