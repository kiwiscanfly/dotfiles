#!/bin/bash
SYNC_FILE="$HOME/shared/clipboard.txt"

case "$1" in
  --copy)
    wl-copy < "$SYNC_FILE"
    ;;
  --paste)
    mkdir -p "$(dirname "$SYNC_FILE")"
    wl-paste > "$SYNC_FILE"
    ;;
  --clear)
    mkdir -p "$(dirname "$SYNC_FILE")"
    > "$SYNC_FILE"
    ;;
  --open)
    content=$(cat "$SYNC_FILE" | head -n 1)
    xdg-open "$content" &
    ;;
  *)
    # Escape content for JSON (newlines, quotes)
    content=$(cat "$SYNC_FILE" 2>/dev/null | head -c 500 | jq -Rs '.')
    modified=$(stat -c %Y "$SYNC_FILE" 2>/dev/null || echo "0")
    echo "{\"content\":$content,\"modified\":$modified}"
    ;;
esac
