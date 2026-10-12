# Changelog

## 0.3.0 — 2026-10-12
- **Trợ lý chung (thư mục gốc):** thêm kỹ năng `kiem-chung` (AI thứ hai kiểm chéo trước khi giao, quy tắc kiểm riêng của người dùng ở `cua-toi/quy-tac-kiem-chung.md`); `AGENTS.md` yêu cầu chạy kiểm chứng cho file/báo cáo có số liệu; `thiet-lap` có nhóm câu tùy chọn về bối cảnh doanh nghiệp; `tao-ky-nang` có khuôn đầu ra cố định; thêm 3 mẫu trong `mau/cua-toi/`.
- Agent phòng ban MOCHA: thêm **kiểm chứng độc lập** (`mocha/00_CHUNG/kiem-chung.md`): file/nghiên cứu phải qua AI thứ hai kiểm trước khi giao, kèm khối "Kết quả kiểm chứng"; vòng 6 trong `tu-hoc.md`.
- Ngân hàng câu hỏi: thêm khối **M** (mô hình kinh doanh + phong cách thương hiệu, hỏi một lần cho cả công ty), **P** (vị trí phòng), **O1–O8** (phiếu đầu ra, thay D16–D17). Thứ tự hỏi: M → P → vai trò → đầu ra → còn lại.
- Câu riêng phòng: đúng 12 câu theo khuôn H1.1–H4.3 (trước đây 12–20 câu tự do), trích số liệu từ mô hình kinh doanh; bộ câu được kiểm chéo trước khi dùng.
- Nhận việc: thêm Bước 0 (đọc mô hình kinh doanh) và Bước 6 (chạy thử có kiểm chứng trước khi dùng thật).
- Thêm 2 file mẫu: `mau-mo-hinh-kinh-doanh.md`, `mau-phong-cach-thuong-hieu.md` (bản thật nằm ở `cua-toi/MOCHA_AI/00_CHUNG/`, không lên repo).

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
