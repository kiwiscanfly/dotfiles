#!/bin/bash

# VS Code Extension Manager
# Manages VS Code extensions from a text file
# Usage:
#   ./manage-extensions.sh [command]

set -e

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
EXTENSIONS_FILE="${SCRIPT_DIR}/extensions.txt"

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
    list        List currently installed extensions
    save        Save current extensions to extensions.txt
    install     Install extensions from extensions.txt
    sync        Install missing extensions and optionally remove extras
    diff        Show differences between installed and saved extensions
    help        Show this help message

Examples:
    $0 save           # Save current extensions
    $0 install        # Install all extensions from file
    $0 sync           # Sync extensions (install missing, prompt to remove extras)
    $0 diff           # Show what would change

EOF
}

list_installed() {
    code --list-extensions 2>/dev/null | sort
}

save_extensions() {
    echo -e "${BLUE}Saving current extensions to ${EXTENSIONS_FILE}...${NC}"
    list_installed > "${EXTENSIONS_FILE}"
    local count=$(wc -l < "${EXTENSIONS_FILE}" | tr -d ' ')
    echo -e "${GREEN}✓ Saved ${count} extensions${NC}"
}

install_extensions() {
    if [[ ! -f "${EXTENSIONS_FILE}" ]]; then
        echo -e "${RED}Error: ${EXTENSIONS_FILE} not found${NC}"
        echo "Run '$0 save' first to create the extensions file"
        exit 1
    fi

    echo -e "${BLUE}Installing extensions from ${EXTENSIONS_FILE}...${NC}"
    
    local installed_count=0
    local already_installed_count=0
    local failed_count=0
    
    while IFS= read -r extension || [[ -n "$extension" ]]; do
        # Skip empty lines and comments
        [[ -z "$extension" || "$extension" =~ ^[[:space:]]*# ]] && continue
        
        # Trim whitespace
        extension=$(echo "$extension" | xargs)
        
        if code --list-extensions 2>/dev/null | grep -q "^${extension}$"; then
            echo -e "${YELLOW}○ ${extension} (already installed)${NC}"
            ((already_installed_count++))
        else
            echo -e "${BLUE}Installing ${extension}...${NC}"
            if code --install-extension "${extension}" --force >/dev/null 2>&1; then
                echo -e "${GREEN}✓ ${extension} installed${NC}"
                ((installed_count++))
            else
                echo -e "${RED}✗ Failed to install ${extension}${NC}"
                ((failed_count++))
            fi
        fi
    done < "${EXTENSIONS_FILE}"
    
    echo -e "\n${GREEN}Summary:${NC}"
    echo -e "  Newly installed: ${installed_count}"
    echo -e "  Already installed: ${already_installed_count}"
    [[ $failed_count -gt 0 ]] && echo -e "  ${RED}Failed: ${failed_count}${NC}"
}

show_diff() {
    if [[ ! -f "${EXTENSIONS_FILE}" ]]; then
        echo -e "${RED}Error: ${EXTENSIONS_FILE} not found${NC}"
        echo "Run '$0 save' first to create the extensions file"
        exit 1
    fi
    
    local temp_installed=$(mktemp)
    local temp_saved=$(mktemp)
    
    # Get current extensions
    list_installed > "${temp_installed}"
    
    # Clean saved extensions (remove comments and empty lines)
    grep -v '^[[:space:]]*#' "${EXTENSIONS_FILE}" | grep -v '^[[:space:]]*$' | sort > "${temp_saved}"
    
    echo -e "${BLUE}Comparing installed extensions with saved list...${NC}\n"
    
    # Find extensions to install (in saved but not installed)
    local to_install=$(comm -13 "${temp_installed}" "${temp_saved}")
    if [[ -n "$to_install" ]]; then
        echo -e "${GREEN}Extensions to install:${NC}"
        echo "$to_install" | sed 's/^/  + /'
        echo
    fi
    
    # Find extensions to remove (installed but not in saved)
    local to_remove=$(comm -23 "${temp_installed}" "${temp_saved}")
    if [[ -n "$to_remove" ]]; then
        echo -e "${YELLOW}Extensions not in list (can be removed):${NC}"
        echo "$to_remove" | sed 's/^/  - /'
        echo
    fi
    
    if [[ -z "$to_install" && -z "$to_remove" ]]; then
        echo -e "${GREEN}✓ Extensions are in sync${NC}"
    fi
    
    rm -f "${temp_installed}" "${temp_saved}"
}

sync_extensions() {
    if [[ ! -f "${EXTENSIONS_FILE}" ]]; then
        echo -e "${RED}Error: ${EXTENSIONS_FILE} not found${NC}"
        echo "Run '$0 save' first to create the extensions file"
        exit 1
    fi
    
    echo -e "${BLUE}Syncing extensions...${NC}\n"
    
    # First install missing extensions
    install_extensions
    
    echo
    
    # Check for extra extensions
    local temp_installed=$(mktemp)
    local temp_saved=$(mktemp)
    
    list_installed > "${temp_installed}"
    grep -v '^[[:space:]]*#' "${EXTENSIONS_FILE}" | grep -v '^[[:space:]]*$' | sort > "${temp_saved}"
    
    local extras=$(comm -23 "${temp_installed}" "${temp_saved}")
    
    if [[ -n "$extras" ]]; then
        echo -e "${YELLOW}Found extensions not in the list:${NC}"
        echo "$extras" | sed 's/^/  /'
        echo
        read -p "Do you want to uninstall these extensions? (y/N): " -n 1 -r
        echo
        
        if [[ $REPLY =~ ^[Yy]$ ]]; then
            echo "$extras" | while IFS= read -r extension; do
                echo -e "${BLUE}Uninstalling ${extension}...${NC}"
                if code --uninstall-extension "${extension}" >/dev/null 2>&1; then
                    echo -e "${GREEN}✓ ${extension} uninstalled${NC}"
                else
                    echo -e "${RED}✗ Failed to uninstall ${extension}${NC}"
                fi
            done
        else
            echo -e "${BLUE}Keeping extra extensions${NC}"
        fi
    else
        echo -e "${GREEN}✓ No extra extensions found${NC}"
    fi
    
    rm -f "${temp_installed}" "${temp_saved}"
}

# Main script logic
case "${1:-}" in
    list)
        list_installed
        ;;
    save)
        save_extensions
        ;;
    install)
        install_extensions
        ;;
    sync)
        sync_extensions
        ;;
    diff)
        show_diff
        ;;
    help|--help|-h)
        usage
        ;;
    *)
        if [[ -n "${1:-}" ]]; then
            echo -e "${RED}Unknown command: $1${NC}\n"
        fi
        usage
        exit 1
        ;;
esac
