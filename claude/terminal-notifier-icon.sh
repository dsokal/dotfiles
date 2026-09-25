#!/bin/bash
# Swap terminal-notifier's icon for the Claude one and re-sign the app ad-hoc.
# Idempotent; needs re-running after `brew upgrade terminal-notifier` (notify.sh does it on its own).
set -e

icon=/Applications/Claude.app/Contents/Resources/electron.icns
resources=/opt/homebrew/opt/terminal-notifier/terminal-notifier.app/Contents/Resources

[[ -f "$icon" && -d "$resources" ]] || { echo "Claude.app or terminal-notifier missing, skipping..."; exit 0; }
cmp -s "$icon" "$resources/Terminal.icns" && { echo "Icon already patched, skipping..."; exit 0; }

[[ -f "$resources/Terminal.icns.orig" ]] || cp "$resources/Terminal.icns" "$resources/Terminal.icns.orig"
cp "$icon" "$resources/Terminal.icns"
codesign --force --deep --sign - "$resources/../.." >/dev/null 2>&1
echo "Icon patched."
