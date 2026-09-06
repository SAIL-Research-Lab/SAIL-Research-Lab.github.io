#!/usr/bin/env bash
# Fetch university/industry logos for the "Current Collaboration Institutions" tiles on People (group.html).
# Runs on machines with outbound network. Saved as images/collab/<name>.png (referenced by group.html).
set -u
cd "$(dirname "$0")"
mkdir -p images/collab

logo_url() { echo "https://logo.clearbit.com/$1"; }

fetch() { # name domain
  local code="$1" dom="$2"
  curl -fsSL --max-time 30 "$(logo_url "$dom")" -o "images/collab/${code}.png" \
    && printf 'ok   %-14s %s\n' "$code" "$dom" \
    || printf 'FAIL %-14s %s\n' "$code" "$dom"
}

fetch jhu           jhu.edu
fetch berkeley      berkeley.edu
fetch ucdavis       ucdavis.edu
fetch virginiatech  vt.edu
fetch sjtu          sjtu.edu.cn
fetch tongji        tongji.edu.cn

echo "Done. Non-ok entries will still render (text fallback); drop the official logo file manually as images/collab/<name>.png to replace."
