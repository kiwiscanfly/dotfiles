#!/bin/bash
# Extract and view HTML email in browser (Linux)

# Create temp file
TMPFILE=$(mktemp /tmp/neomutt-XXXXXX.html)

# Use ripmime or just save the whole message
# For multipart messages, neomutt's auto_view should have already converted to HTML
cat > "$TMPFILE"

# Open in default browser
xdg-open "$TMPFILE"

# Clean up after a delay (give browser time to load)
(sleep 5 && rm -f "$TMPFILE") &
