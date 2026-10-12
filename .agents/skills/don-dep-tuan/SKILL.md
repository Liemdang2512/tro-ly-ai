---
name: don-dep-tuan
description: Rà soát sổ nhớ hằng tuần — dự án lâu không cập nhật, bàn giao nhiều khối cần gộp, kiểm tra còn dở, phiên chưa chốt, bài học lặp lại thành luật, việc lặp lại nên đóng gói, kỹ năng lâu không dùng. Dùng khi người dùng hoặc người quản trị nói "dọn dẹp", "rà soát tuần".
---

# Dọn dẹp tuần

Chỉ **đề xuất**, không tự sửa hay xóa. Mọi thay đổi chờ người dùng đồng ý.

Lấy dữ liệu trước: `bash scripts/du-an.sh ds --tat-ca` · `bash scripts/phien.sh ds` · `bash scripts/dem-viec.sh loai` · `bash scripts/dem-viec.sh de-xuat`.

1. **Dự án** (`cua-toi/du-an/*/`):
   - Lâu quá 14 ngày không cập nhật, hoặc đã quá hạn → hỏi tình hình, đề xuất đổi trạng thái (`du-an.sh dat … trang_thai …`).
   - `ban-giao.md` có từ 3 khối trở lên mà các phiên đó đều đã đóng → đề xuất gộp: viết một khối tổng hợp rồi `--thay` các khối cũ.
   - Dự án đánh "xong" mà `kiem-tra.md` còn "chưa làm" hoặc "lỗi" → hỏi lại.
2. **Phiên chưa chốt** còn trong `phien.sh ds` → đề xuất bù sổ (như bước 1 của `tiep-tuc`) hoặc bỏ qua (`phien.sh da-bu`).
3. **Bài học:**
   - Lặp lại từ 2 lần → đề xuất nâng thành **luật riêng** trong `cua-toi/AGENTS.md`.
   - Bài học riêng của một dự án mà gặp lại ở dự án khác → đề xuất chép lên `cua-toi/bai-hoc.md`.
4. **Hồ sơ** (`cua-toi/ho-so.md`): mục trùng, mâu thuẫn, hoặc còn `[chưa rõ]` → đề xuất gộp hoặc hỏi bổ sung.
5. **Kỹ năng:**
   - Việc lặp lại ≥ 3 lần mà chưa có kỹ năng → đề xuất `tao-ky-nang`.
   - Kỹ năng không có lần dùng nào trong 30 ngày (xem `cua-toi/.tro-ly/viec-lap-lai.tsv`) → hỏi còn cần không, cách gọi có còn đúng không.
   - Có kỹ năng chưa nằm trong `cua-toi/ky-nang/HUONG-DAN.md` → đề xuất bổ sung.
6. **Người dùng từ bản cũ:** `cua-toi/AGENTS.md` còn mục "Gói nghề đang dùng" → đề xuất chuyển việc hay làm trong gói thành kỹ năng riêng (mẫu ở `mau/ky-nang/`), rồi bỏ mục gói.
7. **Kích thước:** `cua-toi/AGENTS.md` dài quá ~150 dòng hoặc `ho-so.md` quá ~120 dòng → đề xuất rút gọn, dời chi tiết sang `tong-quan.md` của dự án hoặc sang tài liệu.
8. Trình bày tất cả thành danh sách đánh số. Người dùng chọn số nào thì làm số đó.
9. Ghi 1 dòng vào nhật ký phiên: "Dọn dẹp tuần: <đã làm gì>". Chạy `bash scripts/luu-so.sh "don-dep-tuan"`.

**Gợi ý cho người quản trị:** bài học xuất hiện ở **nhiều người dùng** → cân nhắc đưa vào lõi `AGENTS.md` hoặc vào mẫu kỹ năng ở bản cập nhật tiếp theo.
