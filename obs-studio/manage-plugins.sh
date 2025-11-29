#!/bin/bash

# OBS Studio Plugin Manager
# Shows status of OBS plugins from plugins.txt

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PLUGINS_FILE="${SCRIPT_DIR}/plugins.txt"
OBS_PLUGINS_DIR="$HOME/Library/Application Support/obs-studio/plugins"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

usage() {
    cat << EOF
Usage: $0 [COMMAND]

Commands:
    list        List plugins from plugins.txt
    status      Show install status of each plugin (default)
    help        Show this help message

EOF
}

list_plugins() {
    echo -e "${BLUE}Plugins in plugins.txt:${NC}\n"
    grep -v '^#' "$PLUGINS_FILE" | grep -v '^$' | while IFS='|' read -r name type source; do
        name=$(echo "$name" | xargs)
        type=$(echo "$type" | xargs)
        source=$(echo "$source" | xargs)
        printf "  %-30s ${YELLOW}%-10s${NC} %s\n" "$name" "[$type]" "$source"
    done
}

check_plugin_installed() {
    local plugin="$1"
    # Check common plugin directory patterns
    ls "$OBS_PLUGINS_DIR" 2>/dev/null | grep -qi "$plugin" && return 0
    ls "/Library/Application Support/obs-studio/plugins" 2>/dev/null | grep -qi "$plugin" && return 0
    return 1
}

show_status() {
    echo -e "${BLUE}OBS Plugin Status:${NC}\n"

    grep -v '^#' "$PLUGINS_FILE" | grep -v '^$' | while IFS='|' read -r name type source; do
        name=$(echo "$name" | xargs)
        type=$(echo "$type" | xargs)
        source=$(echo "$source" | xargs)

        case "$type" in
            companion)
                if check_plugin_installed "$name"; then
                    echo -e "  ${GREEN}✓${NC} $name ${YELLOW}[companion]${NC}"
                else
                    echo -e "  ${YELLOW}○${NC} $name ${YELLOW}[companion]${NC} - install: $source"
                fi
                ;;
            manual)
                if check_plugin_installed "$name"; then
                    echo -e "  ${GREEN}✓${NC} $name ${YELLOW}[manual]${NC}"
                else
                    echo -e "  ${RED}✗${NC} $name ${YELLOW}[manual]${NC} - download: $source"
                fi
                ;;
        esac
    done
}

# Main
case "${1:-status}" in
    list)
        list_plugins
        ;;
    status)
        show_status
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        echo -e "${RED}Unknown command: $1${NC}\n"
        usage
        exit 1
        ;;
esac
