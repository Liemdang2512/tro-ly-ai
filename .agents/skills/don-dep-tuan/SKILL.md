---
name: don-dep-tuan
description: Rà soát sổ nhớ hằng tuần — gộp trùng, đánh dấu dự án xong, biến bài học lặp lại thành luật, đề xuất kỹ năng mới. Dùng khi người dùng hoặc người quản trị nói "dọn dẹp", "rà soát tuần".
---

# Dọn dẹp tuần

Chỉ **đề xuất**, không tự sửa/xóa. Mọi thay đổi chờ người dùng đồng ý.

1. **Dự án** (`cua-toi/du-an/`): dự án nào đã xong / không cập nhật quá 14 ngày / quá hạn? → đề xuất đánh dấu "Đã xong" hoặc hỏi tình hình.
2. **Bài học** (`cua-toi/bai-hoc.md`): bài học nào lặp lại ≥ 2 lần → đề xuất nâng thành **luật riêng** trong `cua-toi/AGENTS.md`.
3. **Hồ sơ** (`cua-toi/ho-so.md`): mục trùng, mâu thuẫn, hoặc còn `[chưa rõ]` → đề xuất gộp hoặc hỏi bổ sung.
4. **Nhật ký 7 ngày qua**: việc nào làm ≥ 3 lần mà chưa có kỹ năng → đề xuất `tao-ky-nang`.
5. **Kích thước:** `cua-toi/AGENTS.md` dài quá ~150 dòng hoặc `ho-so.md` quá ~120 dòng → đề xuất rút gọn (dời chi tiết sang file dự án/tài liệu).
6. Trình bày tất cả dưới dạng danh sách đánh số; người dùng chọn số nào thì làm số đó.
7. Ghi 1 dòng vào nhật ký hôm nay: "Dọn dẹp tuần: <đã làm gì>". Commit nếu có `cua-toi/.git`.

**Gợi ý cho người quản trị:** bài học xuất hiện ở **nhiều người dùng** → cân nhắc đưa vào lõi `AGENTS.md` hoặc checklist của gói nghề trong bản cập nhật tiếp theo.
