#!/bin/bash
# Open the current email in Gmail web interface (Linux)

# Save the email to a temp file
TMPFILE=$(mktemp /tmp/neomutt-XXXXXX.eml)
cat > "$TMPFILE"

# Extract Message-ID (remove angle brackets and spaces)
MSG_ID=$(grep -i "^Message-ID:" "$TMPFILE" | head -1 | sed 's/^Message-ID: *<*//i' | sed 's/>.*$//' | tr -d ' \r\n')

# Extract the recipient to determine which Gmail account
TO=$(grep -i "^Delivered-To:" "$TMPFILE" | head -1 | sed 's/^Delivered-To: *//i' | tr -d ' \r\n')

# Determine account number (0 for first account, 1 for second, etc.)
ACCOUNT=0
if [[ "$TO" == *"gdnz.org"* ]]; then
    ACCOUNT=1
fi

# Clean up temp file
rm -f "$TMPFILE"

if [ -n "$MSG_ID" ]; then
    # Open Gmail search for this message ID
    # Using rfc822msgid: search operator which searches by Message-ID
    URL="https://mail.google.com/mail/u/${ACCOUNT}/#search/rfc822msgid:${MSG_ID}"
    xdg-open "$URL"
else
    echo "Could not extract Message-ID from email"
    exit 1
fi
