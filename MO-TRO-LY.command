#!/bin/bash
# Trợ Lý AI — bấm đúp để mở trợ lý trên máy Mac này.
cd "$(dirname "$0")" || exit 1
export PATH="$HOME/.local/bin:$PATH"
if ! command -v claude >/dev/null 2>&1 || [ ! -f cua-toi/AGENTS.md ]; then
  exec bash ./CAI-DAT.command
fi
exec claude "tiếp tục"
