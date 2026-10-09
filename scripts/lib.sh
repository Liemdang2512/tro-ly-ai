#!/bin/bash
# Thư viện chung cho các script của Trợ Lý AI.
# Chạy được trên macOS và Git Bash (Windows). Không cần cài thêm gì (không jq, không python).

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
CUA_TOI="${TRO_LY_CUA_TOI:-$ROOT/cua-toi}"
TL="$CUA_TOI/.tro-ly"          # dữ liệu máy tự quản của người dùng (phiên, khóa, đếm việc)

bay_gio() { date '+%Y-%m-%d %H:%M'; }
hom_nay() { date '+%Y-%m-%d'; }
dau_tg()  { date '+%Y%m%d-%H%M%S'; }
giay()    { date '+%s'; }

# Lấy một trường chuỗi từ JSON hook (biến $INPUT). Đủ cho các trường đơn giản:
# session_id, transcript_path, source, trigger, reason.
json_lay() {
  printf '%s' "$INPUT" | tr '\n' ' ' \
    | sed -n "s/.*\"$1\"[[:space:]]*:[[:space:]]*\"\([^\"]*\)\".*/\1/p" \
    | sed 's/\\\\/\\/g'
}

# Thoát chuỗi để ghi vào một dòng JSON.
json_chuoi() { printf '%s' "$1" | sed 's/\\/\\\\/g; s/"/\\"/g' | tr '\n\t' '  '; }

# Mã phiên an toàn để làm tên file.
ma_an_toan() { printf '%s' "$1" | tr -cd 'A-Za-z0-9._-'; }
ma_ngan()    { printf '%s' "$1" | cut -c1-8; }

# File dạng "khoa: giá trị", mỗi khóa một dòng.
lay() { sed -n "s/^$2: //p" "$1" 2>/dev/null | head -1; }
lay_so() { local v; v="$(lay "$1" "$2")"; case "$v" in ''|*[!0-9]*) v=0 ;; esac; printf '%s' "$v"; }
dat() {
  local f="$1" k="$2" v="${3//$'\n'/ }" t
  t="$f.tmp.$$"
  { grep -v "^$k: " "$f" 2>/dev/null; printf '%s: %s\n' "$k" "$v"; } > "$t" && mv "$t" "$f"
}

# Khóa chung cho mọi thao tác ghi, để 2–3 phiên chạy song song không đè nhau.
# Dùng mkdir vì mkdir là thao tác nguyên tử trên cả macOS lẫn Windows.
khoa() {
  # Biến cục bộ đặt tên có tiền tố _kh_ để không che biến của hàm được gọi.
  local _kh_k="$TL/khoa" _kh_i=0 _kh_tuoi _kh_rc
  mkdir -p "$TL"
  until mkdir "$_kh_k" 2>/dev/null; do
    _kh_i=$((_kh_i + 1))
    if [ $((_kh_i % 25)) -eq 0 ]; then
      # Khóa bị bỏ lại (phiên chết giữa chừng) quá 30 giây thì gỡ.
      _kh_tuoi=$(( $(giay) - $(cat "$_kh_k/luc" 2>/dev/null || echo 0) ))
      [ "$_kh_tuoi" -gt 30 ] && rm -f "$_kh_k/luc" && rmdir "$_kh_k" 2>/dev/null
    fi
    [ $_kh_i -gt 300 ] && { echo "Không lấy được khóa sau 60 giây." >&2; return 1; }
    sleep 0.2
  done
  giay > "$_kh_k/luc"
  "$@"
  _kh_rc=$?
  rm -f "$_kh_k/luc"; rmdir "$_kh_k" 2>/dev/null
  return $_kh_rc
}

# Đường dẫn bên trong cua-toi/ (chặn ".." và đường dẫn ra ngoài).
trong_cua_toi() {
  local p="$1"
  case "$p" in
    "$CUA_TOI"/*) p="${p#"$CUA_TOI"/}" ;;
    cua-toi/*)    p="${p#cua-toi/}" ;;
  esac
  case "$p" in
    /*|*..*|"") echo "Đường dẫn không hợp lệ (phải nằm trong cua-toi/): $1" >&2; return 1 ;;
  esac
  printf '%s/%s' "$CUA_TOI" "$p"
}

la_windows() { case "$(uname -s)" in MINGW*|MSYS*|CYGWIN*) return 0 ;; esac; return 1; }
