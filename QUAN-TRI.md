# Hướng dẫn cho người quản trị

Tài liệu cho người dựng và bảo trì bộ Trợ Lý AI (không dành cho người dùng cuối).

## Kiến trúc 5 lớp

| Lớp | Ở đâu | Chung / riêng | Ai sửa |
|---|---|---|---|
| 0. Lõi | `AGENTS.md` | Chung | Quản trị |
| 1. Hồ sơ | `cua-toi/ho-so.md`, `cua-toi/AGENTS.md` | Riêng | Trợ lý (qua thiết lập) + người dùng |
| 2. Gói nghề | `goi/<ten>/GOI.md` | Chung, người dùng chọn gói | Quản trị |
| 3. Dự án | `cua-toi/du-an/*.md` | Riêng | Trợ lý, người dùng duyệt |
| 4. Bộ nhớ | `cua-toi/quyet-dinh.md`, `bai-hoc.md`, `nhat-ky/`, `ky-nang/` | Riêng | Trợ lý, người dùng duyệt |

Nguyên tắc: **nội dung chỉ nằm ở một chỗ**. `CLAUDE.md` chỉ import `AGENTS.md` + `cua-toi/AGENTS.md`; Codex đọc thẳng `AGENTS.md`, rồi làm theo mục 0 để đọc `cua-toi/AGENTS.md`.

## Tương thích nhiều AI

| AI | Đọc luật | Đọc kỹ năng |
|---|---|---|
| Claude Code (CLI / Desktop / điều khiển từ iPhone) | `CLAUDE.md` → `@AGENTS.md` | `.claude/skills` (symlink → `.agents/skills`) + bảng trong `AGENTS.md` |
| Codex (CLI / app / ChatGPT Remote) | `AGENTS.md` | `.agents/skills` + bảng trong `AGENTS.md` |
| AI khác có đọc file | `AGENTS.md` | Bảng trong `AGENTS.md` trỏ tới đường dẫn SKILL.md |

Bảng "Khi người dùng nói… → làm theo file…" trong `AGENTS.md` là đường dự phòng cho mọi AI, không phụ thuộc cơ chế skill riêng của từng hãng.

## Cưỡng chế

Luật trong file chữ chỉ là **luật mềm**. Phần cứng hiện có:
- `.claude/settings.json`: chế độ `acceptEdits`, cho phép git trong `cua-toi/`, chặn `rm -rf`, `sudo`, `git push`, đọc `.env`.
- Codex: dùng chế độ phê duyệt mặc định của Codex; chưa có cấu hình riêng trong repo.

Luật nào trợ lý hay vi phạm → cân nhắc chuyển thành hook/permission thay vì thêm chữ.

## Thêm một gói nghề

1. Tạo `goi/<ten-khong-dau>/GOI.md`.
2. Dòng 3 bắt buộc dạng `> Dành cho: …` — skill thiết lập đọc dòng này để giới thiệu gói.
3. Hai mục: `## Việc thường gặp` (quy trình ngắn) và `## Kiểm tra trước khi giao` (checklist).
4. Người dùng cũ muốn dùng gói mới → nói "thiết lập lại" → chọn phần gói nghề.

## Phát hành bản mới

1. Sửa lõi / gói / skill. Không sửa `mau/` theo cách làm hỏng thư mục `cua-toi/` đã tạo (người dùng cũ không được tạo lại).
2. Thử: copy repo ra thư mục tạm, chạy `CAI-DAT.command`, đi hết luồng thiết lập bằng một người dùng giả.
3. Ghi `CHANGELOG.md`, commit, push lên repo phát hành.
4. Người dùng bấm `CAP-NHAT.command` (bản clone bằng git) hoặc tải bản mới + chép `cua-toi/` sang.

## Vòng tự học

Mỗi tuần (hoặc khi người dùng nói "dọn dẹp"): bài học lặp lại → luật riêng trong `cua-toi/AGENTS.md`. Nếu **nhiều người dùng** cùng gặp một bài học → đưa vào lõi hoặc checklist gói nghề ở bản phát hành sau.

## An toàn khi triển khai cho nhiều người

- Mỗi người **một máy (hoặc một tài khoản macOS) + một tài khoản AI + một thư mục `cua-toi/`**. Không dùng chung — trợ lý của người này sẽ đọc được sổ của người kia.
- `cua-toi/` không bao giờ đưa lên repo chung (đã có trong `.gitignore`).
- Máy chạy 24/7: bật FileVault, mật khẩu đăng nhập, không để người khác dùng chung.

## Mở rộng (chưa có trong bản này)

- Điều khiển qua **Telegram**: Claude Code Channels (research preview) — plugin `telegram@claude-plugins-official`, cần Bun và phiên Claude Code chạy liên tục. Xem docs "channels" của Claude Code.
- Bản tin tự động mỗi sáng: scheduled tasks của Claude Code / Desktop.
- Kho nhớ dùng chung cho app chat (không phải agent): đồng bộ `cua-toi/` lên Google Drive/Notion.
