#!/bin/bash
# Kỹ năng riêng của người dùng: MỖI KỸ NĂNG MỘT THƯ MỤC trong cua-toi/ky-nang/<loai-viec>/
# gồm SKILL.md (cách làm + Cách dùng) và các file đi kèm (mẫu, bảng giá, ví dụ...).
#   bash scripts/ky-nang.sh tao <loai-viec> [mẫu]   tạo từ mau/ky-nang/<mẫu>/ (không ghi mẫu: dùng mẫu trùng tên, không có thì khung trống)
#   bash scripts/ky-nang.sh ds                       liệt kê kỹ năng + câu gọi
#   bash scripts/ky-nang.sh co <loai-viec>           có kỹ năng này chưa (mã thoát 0 = có)
#   bash scripts/ky-nang.sh chuyen                   chuyển kỹ năng kiểu cũ (1 file .md) sang thư mục
. "$(dirname "$0")/lib.sh"

KN="$CUA_TOI/ky-nang"
MAU="$ROOT/mau/ky-nang"

hop_le() { printf '%s' "$1" | grep -Eq '^[a-z0-9][a-z0-9-]*$' || { echo "Tên kỹ năng viết thường không dấu, gạch nối. Ví dụ: bao-gia" >&2; return 1; }; }

# Các file kỹ năng: dạng mới (thư mục) và dạng cũ (1 file .md, chưa chuyển).
cac_file() {
  local f
  for f in "$KN"/*/SKILL.md "$KN"/*.md; do
    [ -f "$f" ] && [ "$(basename "$f")" != "HUONG-DAN.md" ] && printf '%s\n' "$f"
  done
}

case "${1:-}" in
  tao)
    loai="${2:-}"; hop_le "$loai" || exit 1
    mau="${3:-$loai}"
    [ -d "$MAU/$mau" ] || mau="_khung"
    _tao() {
      [ -e "$KN/$loai" ] || [ -e "$KN/$loai.md" ] && { echo "Đã có kỹ năng '$loai'. Sửa file có sẵn thay vì tạo mới." >&2; return 1; }
      mkdir -p "$KN/$loai"
      sed "s|{{LOAI_VIEC}}|$loai|g" "$MAU/$mau/SKILL.md" > "$KN/$loai/SKILL.md"
    }
    khoa _tao || exit 1
    echo "Đã tạo cua-toi/ky-nang/$loai/SKILL.md (từ mẫu: $mau). Điền các chỗ {{…}}, chép file đi kèm vào cùng thư mục."
    ;;

  ds)
    while IFS= read -r f; do
      [ -n "$f" ] || continue
      echo "- $(sed -n 's/^# Kỹ năng: //p' "$f" | head -1) — $(sed -n 's/^\*\*Gọi khi:\*\* //p' "$f" | head -1) → ${f#"$ROOT"/}"
    done < <(cac_file)
    ;;

  co)
    loai="${2:-}"
    [ -f "$KN/$loai/SKILL.md" ] || [ -f "$KN/$loai.md" ]
    ;;

  chuyen)
    ls "$KN"/*.md 2>/dev/null | grep -vq '/HUONG-DAN\.md$' || exit 0
    bash "$ROOT/scripts/luu-so.sh" "truoc khi chuyen ky nang sang thu muc"
    _chuyen() {
      local f n t
      for f in "$KN"/*.md; do
        n="$(basename "$f" .md)"
        [ "$n" = "HUONG-DAN" ] && continue
        [ -e "$KN/$n" ] && { echo "Bỏ qua $n.md: đã có thư mục cùng tên." >&2; continue; }
        mkdir -p "$KN/$n"
        if head -1 "$f" | grep -q '^---$'; then
          mv "$f" "$KN/$n/SKILL.md"
        else
          # Thêm phần đầu chuẩn của SKILL.md (Claude/Codex đọc được), giữ nguyên nội dung cũ.
          { printf -- '---\nname: %s\ndescription: %s. Gọi khi người dùng nói %s\n---\n\n' "$n" \
              "$(sed -n 's/^# Kỹ năng: //p' "$f" | head -1)" "$(sed -n 's/^\*\*Gọi khi:\*\* //p' "$f" | head -1)"
            cat "$f"; } > "$KN/$n/SKILL.md" && rm -f "$f"
        fi
        # Sửa đường dẫn trong bảng kỹ năng và sổ tay.
        for t in "$CUA_TOI/AGENTS.md" "$KN/HUONG-DAN.md"; do
          [ -f "$t" ] && sed "s|ky-nang/$n\.md|ky-nang/$n/SKILL.md|g" "$t" > "$t.tmp.$$" && mv "$t.tmp.$$" "$t"
        done
        echo "Đã chuyển: ky-nang/$n.md → ky-nang/$n/SKILL.md"
      done
    }
    khoa _chuyen
    bash "$ROOT/scripts/luu-so.sh" "chuyen ky nang sang thu muc"
    ;;

  *) sed -n '2,8p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
