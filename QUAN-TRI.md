# Hướng dẫn cho người quản trị

Tài liệu cho người dựng và bảo trì bộ Trợ Lý AI (không dành cho người dùng cuối).

## Kiến trúc 5 lớp

| Lớp | Ở đâu | Chung / riêng | Ai sửa |
|---|---|---|---|
| 0. Lõi | `AGENTS.md` | Chung | Quản trị |
| 1. Hồ sơ | `cua-toi/ho-so.md`, `cua-toi/AGENTS.md` | Riêng | Trợ lý (qua thiết lập) + người dùng |
| 2. Mẫu kỹ năng | `mau/ky-nang/<loai-viec>/SKILL.md` (thay gói nghề từ v0.2) | Chung, làm khung khi tạo kỹ năng riêng | Quản trị |
| 3. Dự án | `cua-toi/du-an/<NN_ten>/` (mỗi dự án một thư mục: bàn giao, tiến độ, quyết định, bài học, kiểm tra) | Riêng | Trợ lý qua `scripts/`, người dùng duyệt |
| 4. Bộ nhớ | `cua-toi/quyet-dinh.md`, `bai-hoc.md`, `nhat-ky/` (mỗi phiên 1 file), `ky-nang/` | Riêng | Trợ lý, người dùng duyệt |
| 5. Dữ liệu máy | `cua-toi/.tro-ly/` (phiên, khóa, đếm việc lặp lại) và `du-an/*/.tro-ly/` | Riêng | Chỉ script |

Đối chiếu với `.harness/` của dev harness: `handoff.md` → `ban-giao.md` (mỗi phiên một khối) · `progress.md` → `tien-do.md` · `decisions/` → `quyet-dinh.md` · `failure-patterns.md` → `bai-hoc.md` · `quality-gates.json` → `kiem-tra.md` · `state.json`, `session.jsonl`, `compaction-snapshots/` → `.tro-ly/trang-thai.txt`, `.tro-ly/phien.jsonl`, `.tro-ly/nen/`.

Nguyên tắc: **nội dung chỉ nằm ở một chỗ**. `CLAUDE.md` chỉ import `AGENTS.md` + `cua-toi/AGENTS.md`; Codex đọc thẳng `AGENTS.md`, rồi làm theo mục 0 để đọc `cua-toi/AGENTS.md`.

## Tương thích nhiều AI

| AI | Đọc luật | Đọc kỹ năng |
|---|---|---|
| Claude Code (CLI / Desktop / điều khiển từ iPhone) | `CLAUDE.md` → `@AGENTS.md` | `.claude/skills` (bộ cài tạo: symlink trên Mac, junction trên Windows; không nằm trong git) → `.agents/skills` |
| Codex (CLI / app / ChatGPT Remote) | `AGENTS.md` + hook chèn `cua-toi/AGENTS.md` lúc mở phiên | `.agents/skills` (đọc thẳng) |
| AI khác có đọc file | `AGENTS.md` | Bảng trong `AGENTS.md` trỏ tới đường dẫn SKILL.md |

Bảng "Khi người dùng nói… → làm theo file…" trong `AGENTS.md` là đường dự phòng cho mọi AI, không phụ thuộc cơ chế skill riêng của từng hãng.

## Lưu phiên: hook + script

Việc ghi sổ quan trọng do **script** làm, không trông vào trí nhớ của trợ lý:

| Lúc | Claude Code (`.claude/settings.json`) | Codex (`.codex/hooks.json`) | Script làm gì |
|---|---|---|---|
| Mở / tiếp tục phiên | `SessionStart` | `SessionStart` | Chèn giờ, mã phiên, dự án, phiên song song, phiên chưa chốt, kỹ năng riêng, việc nên đóng gói. Codex: chèn thêm `cua-toi/AGENTS.md`. Tự sửa liên kết kỹ năng nếu mất |
| Trước khi nén | `PreCompact` | `PreCompact` | Lưu dấu vết (đường dẫn hội thoại) vào `.tro-ly/nen/` của dự án |
| Sau khi nén | `SessionStart` (source=compact) | `SessionStart` (source=compact) | Nhắc đọc lại hồ sơ, bài học, bàn giao; ghi nháp nhật ký |
| Đóng phiên | `SessionEnd` | `SessionEnd` | Chưa chốt → đánh dấu `dong-chua-chot`; lưu lịch sử `cua-toi/` |

Không có hook (Codex chưa duyệt hook, AI khác) → `AGENTS.md` bảo trợ lý chạy `bash scripts/phien.sh bat-dau-tay <công cụ>`. Đã thử thật với Codex 0.160: chạy đúng.

**Nhiều phiên song song:** mọi thao tác ghi đi qua khóa chung (`cua-toi/.tro-ly/khoa`, dùng `mkdir` nên nguyên tử trên cả Mac lẫn Windows). Bàn giao mỗi phiên một khối (`<!-- khoi:<mã> -->`); script không cho thay khối của phiên đang mở; khối bị thay được dời sang `.tro-ly/ban-giao-cu.md`.

**Codex cần người dùng duyệt 1 lần:** tin tưởng dự án + `/hooks` → trust. Hook đổi nội dung (bản cập nhật) thì Codex hỏi duyệt lại.

## Cưỡng chế

Luật trong file chữ chỉ là **luật mềm**. Phần cứng hiện có:
- `.claude/settings.json`: chế độ `acceptEdits`; cho phép các script trong `scripts/` và git chỉ-đọc trong `cua-toi/`; chặn `rm -rf`, `sudo`, `git push`, `git reset/checkout/restore/clean/rebase` trong `cua-toi/`, đọc `.env`.
- Ghi sổ qua script: khóa, chỉ-thêm, chặn đường dẫn ra ngoài `cua-toi/`.
- Codex: dùng chế độ phê duyệt mặc định của Codex; chưa có luật chặn lệnh riêng trong repo.

Luật nào trợ lý hay vi phạm → cân nhắc chuyển thành hook/permission thay vì thêm chữ.

## Thêm một mẫu kỹ năng

1. Tạo `mau/ky-nang/<loai-viec>/SKILL.md` theo `mau/ky-nang/_khung/SKILL.md`. Tên thư mục = tên loại việc (chữ thường không dấu, gạch nối). Có file mẫu dùng chung (ví dụ khung công văn) thì để cùng thư mục, `scripts/ky-nang.sh tao` chỉ chép `SKILL.md`, file khác trợ lý chép khi cần.
2. Bắt buộc giữ 2 dòng đầu `# Kỹ năng: …` và `**Gọi khi:** …` (script đọc để giới thiệu ở đầu phiên), và mục `## Cách dùng` đủ 4 dòng.
3. Để `{{VI_DU}}` cho `tao-ky-nang` điền ví dụ thật của người dùng.

`goi/` chỉ còn cho người dùng v0.1; bỏ ở bản sau khi không còn ai trỏ tới.

## Phát hành bản mới

1. Sửa lõi / gói / skill. Không sửa `mau/` theo cách làm hỏng thư mục `cua-toi/` đã tạo (người dùng cũ không được tạo lại).
2. Thử: `bash tests/test-v02.sh` (phải 0 hỏng); chạy 1 phiên thật `claude -p` và `codex exec` trên bản sao; đi hết luồng thiết lập bằng một người dùng giả. Windows: theo `tests/KIEM-TRA-WINDOWS.md`.
3. Ghi `CHANGELOG.md`, commit, push lên repo phát hành.
4. Người dùng bấm `CAP-NHAT.command` / `CAP-NHAT.bat` (bản clone bằng git) hoặc tải bản mới + chép `cua-toi/` sang. `scripts/nang-cap.sh` chạy sau mỗi lần cập nhật và mỗi lần mở, nên chỉ được thêm, không được phá dữ liệu cũ.

## Vòng tự học

Mỗi tuần (hoặc khi người dùng nói "dọn dẹp"): bài học lặp lại → luật riêng trong `cua-toi/AGENTS.md`. Nếu **nhiều người dùng** cùng gặp một bài học → đưa vào lõi hoặc mẫu kỹ năng ở bản phát hành sau.

## An toàn khi triển khai cho nhiều người

- Mỗi người **một máy (hoặc một tài khoản macOS) + một tài khoản AI + một thư mục `cua-toi/`**. Không dùng chung — trợ lý của người này sẽ đọc được sổ của người kia.
- `cua-toi/` không bao giờ đưa lên repo chung (đã có trong `.gitignore`).
- Máy chạy 24/7: bật FileVault, mật khẩu đăng nhập, không để người khác dùng chung.

## Mở rộng (chưa có trong bản này)

- Điều khiển qua **Telegram**: Claude Code Channels (research preview) — plugin `telegram@claude-plugins-official`, cần Bun và phiên Claude Code chạy liên tục. Xem docs "channels" của Claude Code.
- Bản tin tự động mỗi sáng: scheduled tasks của Claude Code / Desktop.
- Kho nhớ dùng chung cho app chat (không phải agent): đồng bộ `cua-toi/` lên Google Drive/Notion.
