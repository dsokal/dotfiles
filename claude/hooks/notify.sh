#!/bin/bash
# Claude Code notification hook: shows chat title + project in a macOS notification.
input=$(cat)

event=$(jq -r '.hook_event_name // empty' <<<"$input")
transcript=$(jq -r '.transcript_path // empty' <<<"$input")
session=$(jq -r '.session_id // "claude"' <<<"$input")
cwd=$(jq -r '.cwd // empty' <<<"$input")
project=$(basename "${cwd:-$PWD}")

# Skip when this project's VS Code window is the one in front — you're looking at it anyway.
front=$(lsappinfo info -only bundleid "$(lsappinfo front)" 2>/dev/null)
if [[ "$CLAUDE_CODE_ENTRYPOINT" != "claude-desktop" && "$front" == *'"com.microsoft.VSCode"'* ]]; then
  # Needs Accessibility for VS Code; without it we can't tell windows apart, so stay quiet.
  window=$(osascript -e 'tell application "System Events" to get name of front window of (first process whose frontmost is true)' 2>/dev/null) || exit 0
  [[ "$window" == *"$project"* ]] && exit 0
fi
# Same for the Claude desktop app: if it's in front, you're already looking at it.
[[ "$front" == *'"com.anthropic.claudefordesktop"'* ]] && exit 0

title=""
if [[ -f "$transcript" ]]; then
  # A user-set title (rename) wins over the auto-generated one; the last entry is the current one.
  title=$(jq -r 'select(.type=="custom-title") | .customTitle // .title // empty' "$transcript" 2>/dev/null | tail -1)
  [[ -z "$title" ]] && title=$(jq -r 'select(.type=="ai-title") | .aiTitle // .title // empty' "$transcript" 2>/dev/null | tail -1)
fi
[[ -z "$title" ]] && title="Untitled chat"

if [[ "$event" == "Notification" ]]; then
  message=$(jq -r '.message // "Needs your input"' <<<"$input")
  sound=Ping
else
  message="Done — task finished"
  sound=Glass
fi

# brew upgrade restores the stock icon; put the Claude one back (no-op when already patched).
"$(dirname "$(readlink "$0" || echo "$0")")/../terminal-notifier-icon.sh" >/dev/null 2>&1

# Click target: the Claude desktop app session (deep link) when run from there, else VS Code.
if [[ "$CLAUDE_CODE_ENTRYPOINT" == "claude-desktop" ]]; then
  if [[ "$CLAUDE_CODE_HOST_SESSION_ID" =~ ^local_[A-Za-z0-9-]+$ ]]; then
    click="/usr/bin/open 'claude://code/continue?session=$CLAUDE_CODE_HOST_SESSION_ID'"
  else
    click="/usr/bin/open -b com.anthropic.claudefordesktop"
  fi
  [[ "$project" == scratch-* ]] && project="No folder"
else
  click="/usr/bin/open -a 'Visual Studio Code' '${cwd:-$PWD}'"
fi

/opt/homebrew/bin/terminal-notifier \
  -title "Claude Code · $project" \
  -subtitle "$title" \
  -message "$message" \
  -sound "$sound" \
  -execute "$click" \
  -group "claude-$session" >/dev/null 2>&1
exit 0
