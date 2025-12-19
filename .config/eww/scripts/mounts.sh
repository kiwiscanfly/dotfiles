#!/bin/bash

# Mount profiles script for eww - lists fm mount profiles and status

FM_PROFILES_DIR="$HOME/.fm/profiles"
FM_CMD="$HOME/repos/fs-mgmt/fm"

# Check if path is mounted
is_mounted() {
    mount | grep -q " on $1 " 2>/dev/null
}

# Build JSON for all mount profiles
output_json() {
    local profiles_json="["
    local first=true
    local count=0
    local mounted_count=0

    for conf in "$FM_PROFILES_DIR"/*.conf; do
        [[ -f "$conf" ]] || continue

        # Check if it has mount config
        grep -q "^MOUNT_TYPE=" "$conf" || continue

        local name mount_point remote mounted
        name=$(basename "$conf" .conf)
        mount_point=$(grep "^MOUNT_POINT_LINUX=" "$conf" | cut -d= -f2 | tr -d '"')
        remote=$(grep "^MOUNT_REMOTE=" "$conf" | cut -d= -f2 | tr -d '"')

        if is_mounted "$mount_point"; then
            mounted="true"
            ((mounted_count++))
        else
            mounted="false"
        fi

        [[ "$first" == "true" ]] || profiles_json+=","
        first=false

        profiles_json+="{\"name\":\"$name\",\"mounted\":$mounted,\"mount_point\":\"$mount_point\",\"remote\":\"$remote\"}"
        ((count++))
    done

    profiles_json+="]"

    echo "{\"profiles\":$profiles_json,\"count\":$count,\"mounted_count\":$mounted_count}"
}

case "$1" in
    --connect)
        profile="$2"
        ghostty -e bash -c "$FM_CMD mount connect '$profile'; echo; echo 'Press Enter to close'; read" &
        eww close mounts
        ;;
    --disconnect)
        profile="$2"
        ghostty -e bash -c "$FM_CMD mount disconnect '$profile'; echo; echo 'Press Enter to close'; read" &
        eww close mounts
        ;;
    *)
        output_json
        ;;
esac
