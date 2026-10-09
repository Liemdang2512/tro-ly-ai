---
name: tao-ky-nang
description: Đóng gói một việc lặp lại của người dùng thành kỹ năng riêng (mỗi kỹ năng một thư mục trong cua-toi/ky-nang/, gồm SKILL.md và file mẫu đi kèm) kèm hướng dẫn cách dùng, để lần sau chỉ cần gọi tên. Dùng khi người dùng nói "tạo kỹ năng", "lần sau cứ làm vậy", khi máy đếm thấy một việc đã làm từ 3 lần và người dùng đồng ý đóng gói, hoặc lúc thiết lập lần đầu.
---

# Tạo kỹ năng riêng

Mỗi kỹ năng là **một thư mục** `cua-toi/ky-nang/<loai-viec>/`:
```
cua-toi/ky-nang/bao-gia/
├── SKILL.md          ← cách làm + mục "Cách dùng" (bắt buộc)
├── mau-bao-gia.docx  ← mẫu của công ty (nếu có)
├── bang-gia.xlsx     ← tài liệu dùng đi dùng lại (nếu có)
└── vi-du/            ← vài kết quả cũ làm chuẩn (nếu có)
```

## 1. Đặt tên loại việc
Tên loại việc = tên thư mục: chữ thường không dấu, gạch nối (`bao-gia`, `bao-cao-tuan`).
Chạy `bash scripts/dem-viec.sh loai`. Việc này đã có tên trong danh sách → **dùng đúng tên đó**, để máy biết việc đã có kỹ năng và thôi đề xuất.

## 2. Chọn mẫu
Chạy `ls mau/ky-nang/`. Có mẫu khớp (báo giá, báo cáo tuần, trả lời khách, tóm tắt họp…) → đọc `mau/ky-nang/<mẫu>/SKILL.md` làm khung, chỉ hỏi những phần riêng của người dùng. Không có mẫu khớp → dùng khung trống `_khung`.

## 3. Hỏi tối đa 5 câu
Bỏ những câu đã rõ: xem các lần làm trước bằng mô tả trong `cua-toi/.tro-ly/viec-lap-lai.tsv`, `tien-do.md` của dự án liên quan, và nhật ký.
1. Anh/chị sẽ gọi việc này bằng câu nào? (ví dụ "làm báo giá cho …")
2. Đầu vào là gì? (email, file, số liệu dán vào…)
3. Các bước anh/chị thường làm, theo thứ tự?
4. Kết quả trông thế nào? **Có file mẫu, bảng giá, bản làm cũ thì gửi em**, em cất vào kỹ năng để lần sau dùng luôn.
5. Làm sao biết kết quả **đạt**? Lỗi hay gặp là gì?

## 4. Tạo thư mục và viết `SKILL.md`
1. `bash scripts/ky-nang.sh tao <loai-viec> [mẫu]`: tạo `cua-toi/ky-nang/<loai-viec>/SKILL.md` từ mẫu.
2. **File đi kèm:** người dùng gửi file hoặc chỉ đường dẫn → chép vào cùng thư mục kỹ năng, đặt tên không dấu dễ hiểu (`mau-bao-gia.docx`, `bang-gia-2026.xlsx`). Kết quả cũ làm chuẩn để trong `vi-du/`. Liệt kê từng file ở mục `## File đi kèm`, mỗi file một dòng ghi dùng để làm gì. Không có file nào thì ghi "chưa có".
3. Điền mọi chỗ `{{…}}`, không để sót. **Bắt buộc** mục `## Cách dùng` đủ 4 dòng:
   - **Nói:** câu gọi chính + 1–2 cách nói khác
   - **Cần chuẩn bị:** thông tin hoặc file phải có (file đã cất trong kỹ năng thì ghi "đã có sẵn trong kỹ năng")
   - **Kết quả:** trông thế nào, file lưu ở đâu (thường là `du-an/<NN_ten>/san-pham/`)
   - **Ví dụ:** một câu gọi thật, lấy từ lần làm trước của chính người dùng
4. Giữ đúng phần đầu `---name / description---`, dòng `# Kỹ năng: <Tên>` và dòng `**Gọi khi:** …`. Script đọc các dòng này để giới thiệu kỹ năng ở đầu mỗi phiên.

## 5. Ghi ở 3 chỗ
1. Bảng **Kỹ năng riêng** trong `cua-toi/AGENTS.md`: `| "<câu gọi>" | cua-toi/ky-nang/<loai-viec>/ |`
2. **Sổ tay** `cua-toi/ky-nang/HUONG-DAN.md`: thêm 1 mục theo khuôn trong file đó.
3. **Nhật ký phiên:** dòng "Tạo kỹ năng <Tên>" (qua `scripts/ghi-them.sh`).

## 6. Chạy thử ngay
Dùng dữ liệu thật, hoặc ví dụ người dùng đưa. Người dùng góp ý → sửa `SKILL.md`. Cách gọi, đầu vào hoặc file đi kèm thay đổi thì sửa luôn mục `Cách dùng`, `File đi kèm` và sổ tay. Bảng giá hay mẫu mới thì thay file trong thư mục kỹ năng, giữ đúng tên file đã ghi.

## 7. Lưu và báo
`bash scripts/luu-so.sh "ky-nang: <loai-viec>"`. Sau đó báo đúng khuôn:
> Đã tạo kỹ năng **<Tên>**. Lần sau anh/chị chỉ cần nói: *"<câu gọi>"*.
> Cần chuẩn bị: <…>. Em đã cất sẵn: <file đi kèm, nếu có>. Kết quả nằm ở: <…>.
> Muốn xem các việc em làm được: hỏi *"em biết làm những gì?"* hoặc mở `cua-toi/ky-nang/HUONG-DAN.md`.

Không sửa `.agents/skills/`, `mau/` hay `goi/`. Kỹ năng riêng luôn nằm trong `cua-toi/ky-nang/`.
