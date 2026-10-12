# Changelog

## 0.5.0 — 2026-10-12
- **Agent phòng ban MOCHA:** thêm bộ `mocha/00_CHUNG/lam-viec-voi-sep/` (Sổ tay làm việc với Sếp v2.1): prompt tổng bản đầy đủ (nguyên văn, 148 dòng), prompt rút gọn, dòng thời gian, 33 luật, 26 lỗi, 10 tình huống kiểm thử, mô hình huấn luyện, dữ kiện nghiệp vụ, nguồn chuẩn, 12 quyết định đã chốt. `them-tu-hoc.sh` chép thư mục này vào `.luat-chung/` của mọi phòng và gắn khối `<!-- prompt-tong -->` vào `AGENTS.md` (một lần, sao lưu trước) để prompt tổng tự nạp mỗi phiên, phòng cũ lẫn phòng mới. Prompt tổng xếp ngay sau mục An toàn, trên luật riêng của phòng.
- Kiểm 2 lớp: tự kiểm chéo A–E của prompt tổng **cộng thêm** AI thứ hai (`kiem-chung.md` bước 1, `tu-hoc.md` vòng 6).
- **Lịch báo cáo:** `cai-dat/bao-cao-dinh-ky.sh` (mọi phòng có bot: báo cáo cuối ngày 17:47, rà tuần thứ Hai 08:33, gửi vào topic của phòng; phiên soạn riêng chỉ được đọc file, tắt plugin Telegram để không giành tin của bot đang chạy). `cai-dat/cai-lich-bao-cao.sh bat|tat|xem`; CAP-NHAT tự cài trên máy có bot phòng (trừ khi đã `tat`). Lịch mở script qua app Terminal vì macOS chặn tác vụ nền đọc Desktop/Documents (đã thử: chạy thẳng bị "Operation not permitted", qua Terminal gửi được).

## 0.4.0 — 2026-10-12
- **Trợ lý chung:** thêm kỹ năng `kiem-chung` (AI thứ hai kiểm chéo trước khi giao; quy tắc kiểm riêng ở `cua-toi/quy-tac-kiem-chung.md`, ghi qua `scripts/ghi-them.sh`). `AGENTS.md` yêu cầu chạy kiểm chứng cho file/báo cáo có số liệu và đọc bối cảnh công ty khi soạn nội dung ra ngoài. `thiet-lap` có nhóm câu tùy chọn về bối cảnh doanh nghiệp. `tao-ky-nang` hỏi thêm khuôn đầu ra và người duyệt. Thêm 3 mẫu trong `mau/cua-toi/`.
- **Agent phòng ban MOCHA:** `mocha/00_CHUNG/kiem-chung.md` (cùng câu lệnh hệ thống) và vòng 6 trong `tu-hoc.md`. Ngân hàng câu hỏi thêm khối M (mô hình kinh doanh, M1–M10), P (vị trí phòng), O1–O8 (phiếu đầu ra, thay D16–D17). `setup-phong.md`: Bước 0 đọc mô hình kinh doanh, khuôn 12 câu riêng phòng, kiểm chéo bộ câu, Bước 6 chạy thử có kiểm chứng. 2 file mẫu hồ sơ công ty (bản thật ở `cua-toi`, không lên repo).
- Chưa có: hook chặn gửi file chưa kiểm (cần xác nhận tên tool Telegram trên máy chạy).

## 0.3.0 — 2026-10-09
- **Dự án dạng thư mục** `cua-toi/du-an/<NN_ten>/`: `tong-quan`, `ban-giao` (mỗi phiên một khối, không đè khi mở 2–3 phiên song song), `tien-do`, `quyet-dinh`, `bai-hoc`, `kiem-tra`, `tai-lieu/`, `san-pham/`, `.tro-ly/` (trạng thái, lịch sử phiên, dấu vết khi nén). Tự chuyển dự án v0.1 (hỏi trước, giữ file cũ).
- **Lưu phiên tự động** cho Claude Code và Codex: hook mở / trước nén / sau nén / đóng phiên. Quên "chốt" → lần sau trợ lý hỏi bù sổ. Nhật ký mỗi phiên một file. Giờ lấy từ máy, không đoán.
- **Script ghi sổ an toàn** (`scripts/`): khóa chung cho nhiều phiên, chỉ-thêm, lưu lịch sử có thử lại, khôi phục không mất lịch sử. Kỹ năng mới `khoi-phuc`; chặn `git reset/checkout/clean/rebase` trong `cua-toi/`.
- **Gói nghề → mẫu kỹ năng** (`mau/ky-nang/<loai>/SKILL.md`, 10 mẫu). Thiết lập bỏ câu chọn gói; từ "3 việc lặp lại" tạo luôn kỹ năng riêng. Checklist chung gom vào `AGENTS.md`.
- **Kỹ năng riêng dạng thư mục** `cua-toi/ky-nang/<loai-viec>/`: `SKILL.md` (định dạng chuẩn Claude/Codex) + file đi kèm (mẫu, bảng giá, `vi-du/`). Kỹ năng kiểu cũ (1 file) tự chuyển khi cập nhật, giữ nội dung, sửa đường dẫn.
- **Tự phát hiện việc lặp lại** (≥ 3 lần) → đề xuất đóng gói; kỹ năng mới luôn có mục "Cách dùng" + sổ tay `cua-toi/ky-nang/HUONG-DAN.md`; đầu phiên liệt kê kỹ năng riêng kèm câu gọi.
- **Windows (thử nghiệm):** `CAI-DAT.bat`, `MO-TRO-LY.bat`, `CAP-NHAT.bat` + `scripts/windows.ps1` (tự cài Git for Windows + Claude Code, junction cho kỹ năng).
- `.claude/skills` không còn nằm trong git (bộ cài tạo). `.gitattributes` giữ LF cho script bash. Cảnh báo khi cài vào thư mục iCloud/OneDrive/Dropbox. README: cài vào `~/tro-ly-ai`, hướng dẫn "Vẫn mở" của macOS mới, các màn hình đăng nhập lần đầu, duyệt hook Codex.
- Test tự động `tests/test-v02.sh` (52 mục).

## 0.2.0 — 2026-10-07
- Thêm `mocha/`: luật tự học cho agent phòng ban MOCHA (sổ việc tự ghi, học từ lần sửa, hỏi bù, đóng gói kỹ năng ở lần lặp thứ 3, rà tuần).
- Nhận việc: agent nghiên cứu phòng (khung MOCHA + tra web) và soạn câu hỏi riêng theo tư duy hệ thống H1–H4; cho chọn hỏi trực tiếp hoặc điền phiếu Excel (`phieu.py`).
- `CAP-NHAT.command` tự chạy `mocha/cap-nhat-mocha.sh` khi máy có `cua-toi/MOCHA_AI` (sao lưu file cũ trước khi thay).

## 0.1.0 — 2026-09-30
- Bản đầu: lõi `AGENTS.md`, cầu nối `CLAUDE.md`.
- Skills chung: `thiet-lap` (phỏng vấn lần đầu), `tiep-tuc`, `ghi-nho`, `chot-phien`, `tao-ky-nang`, `don-dep-tuan`.
- 4 gói nghề: điều hành, kinh doanh, marketing, hành chính – kế toán.
- Mẫu thư mục `cua-toi/`.
- Script macOS: `CAI-DAT.command`, `MO-TRO-LY.command`, `CAP-NHAT.command`.
