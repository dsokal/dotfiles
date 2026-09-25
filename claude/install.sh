#!/bin/bash
# Set up Claude Code notifications on macOS (hook script itself is linked by dotbot).
set -e
cd "$(dirname "${BASH_SOURCE[0]}")"

# Merge our hooks into ~/.claude/settings.json without clobbering anything Claude Code wrote there.
settings=~/.claude/settings.json
mkdir -p ~/.claude
[[ -f "$settings" ]] || echo '{}' >"$settings"
merged=$(jq -s '
  .[0] as $cur | .[1] as $add
  | $cur | .hooks = reduce ($add.hooks | to_entries[]) as $e ($cur.hooks // {};
      .[$e.key] = ((.[$e.key] // []) as $old | $old + [$e.value[] | select(. as $x | $old | index([$x]) | not)]))
' "$settings" settings.hooks.json)
if [[ "$merged" != "$(jq . "$settings")" ]]; then
  echo "$merged" >"$settings"
  echo "Hooks merged into $settings."
else
  echo "Hooks already in $settings, skipping..."
fi

./terminal-notifier-icon.sh

# Alert style lives in a TCC-protected container, so it can't be scripted.
marker=~/.claude/.notification-style-prompted
if [[ ! -f "$marker" ]]; then
  # Send one notification so terminal-notifier shows up in System Settings.
  /opt/homebrew/bin/terminal-notifier -title "Claude Code" -message "Notifications set up" -group claude-setup >/dev/null 2>&1 || true
  echo -e "\033[1;33mSet System Settings → Notifications → terminal-notifier → style to \"Persistent\".\033[0m"
  open "x-apple.systempreferences:com.apple.Notifications-Settings.extension" || true
  touch "$marker"
fi
