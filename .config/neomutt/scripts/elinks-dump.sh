#!/bin/bash
# Render HTML with elinks and add spacing between paragraphs

# Use elinks to dump HTML to text
elinks -dump -dump-charset utf-8 -force-html "$1" | \
  # Add extra blank line after each paragraph (after blank lines)
  sed '/^$/N;/^\n$/s/$/\n/'
