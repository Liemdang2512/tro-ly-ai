#!/bin/bash
# Chọn Python >=3.10 trên macOS và Git Bash/Windows.
for interpreter in python3.12 python3.13 python3.14 python3.11 python3.10 python3 python; do
  if command -v "$interpreter" >/dev/null 2>&1 && "$interpreter" -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)' >/dev/null 2>&1; then
    exec "$interpreter" "$(dirname "$0")/memory_graph.py" "$@"
  fi
done
if command -v py >/dev/null 2>&1 && py -3 -c 'import sys; sys.exit(0 if sys.version_info >= (3,10) else 1)' >/dev/null 2>&1; then
  exec py -3 "$(dirname "$0")/memory_graph.py" "$@"
fi
echo 'Thiếu Python 3.10 trở lên; tiếp tục dùng sổ gốc.' >&2
exit 1
