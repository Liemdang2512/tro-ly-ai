#!/bin/bash
# Đếm việc lặp lại để đề xuất đóng gói thành kỹ năng.
#   bash scripts/dem-viec.sh ghi <loai-viec> <thư mục dự án | -> "<mô tả ngắn>"   ghi 1 lần làm (lúc chốt phiên)
#   bash scripts/dem-viec.sh loai                                                  các loại việc đã có + số lần (để dùng lại tên)
#   bash scripts/dem-viec.sh de-xuat [--nhac]                                      loại việc ≥ 3 lần mà chưa có kỹ năng
#        --nhac: dùng lúc mở phiên — mỗi loại chỉ nhắc tối đa 1 lần / 7 ngày
#   bash scripts/dem-viec.sh khong <loai-viec>                                     người dùng không muốn đóng gói → thôi nhắc
. "$(dirname "$0")/lib.sh"

DS="$TL/viec-lap-lai.tsv"; KHONG="$TL/khong-de-xuat.txt"; NHAC="$TL/da-nhac.tsv"
NGUONG="${TRO_LY_NGUONG:-3}"

hop_le() { printf '%s' "$1" | grep -Eq '^[a-z0-9][a-z0-9-]*$' || { echo "Loại việc viết thường không dấu, gạch nối. Ví dụ: bao-gia" >&2; return 1; }; }

case "${1:-}" in
  ghi)
    loai="${2:-}"; hop_le "$loai" || exit 1
    da="${3:--}"; da="${da%/}"; da="${da##*/}"
    mo_ta="$(printf '%s' "${4:-}" | tr '\t\n' '  ')"
    _ghi() { mkdir -p "$TL"; printf '%s\t%s\t%s\t%s\n' "$(hom_nay)" "$loai" "${da:--}" "$mo_ta" >> "$DS"; }
    khoa _ghi && echo "Đã ghi: $loai ($(cut -f2 "$DS" | grep -cx "$loai") lần)"
    ;;

  loai)
    [ -f "$DS" ] || { echo "(chưa có)"; exit 0; }
    cut -f2 "$DS" | sort | uniq -c | sort -rn | awk '{print "- " $2 ": " $1 " lần"}'
    ;;

  de-xuat)
    [ -f "$DS" ] || exit 0
    bay_gio_s="$(giay)"
    cut -f2 "$DS" | sort | uniq -c | sort -rn | while read -r so loai; do
      [ "$so" -ge "$NGUONG" ] || continue
      bash "$ROOT/scripts/ky-nang.sh" co "$loai" && continue
      grep -qx "$loai" "$KHONG" 2>/dev/null && continue
      if [ "${2:-}" = "--nhac" ]; then
        lan="$(awk -F'\t' -v l="$loai" '$1 == l {t = $2} END {print t + 0}' "$NHAC" 2>/dev/null)"
        [ $((bay_gio_s - ${lan:-0})) -lt $((7 * 86400)) ] && continue
        printf '%s\t%s\n' "$loai" "$bay_gio_s" >> "$NHAC"
      fi
      gan_nhat="$(awk -F'\t' -v l="$loai" '$2 == l {d = $1; m = $4} END {print d " — " m}' "$DS")"
      echo "- $loai: $so lần (gần nhất: $gan_nhat)"
    done
    ;;

  khong)
    loai="${2:-}"; hop_le "$loai" || exit 1
    _khong() { mkdir -p "$TL"; grep -qx "$loai" "$KHONG" 2>/dev/null || echo "$loai" >> "$KHONG"; }
    khoa _khong && echo "Đã ghi nhận: không đề xuất đóng gói '$loai' nữa."
    ;;

  *) sed -n '2,7p' "$0" | sed 's/^# \{0,1\}//'; exit 1 ;;
esac
