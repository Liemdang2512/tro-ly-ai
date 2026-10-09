# Changelog

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
