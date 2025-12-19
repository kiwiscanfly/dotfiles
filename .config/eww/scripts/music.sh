#!/bin/bash

# Music info script for eww - uses mpc to get MPD status

get_status() {
    status=$(mpc status 2>/dev/null | grep -o '\[.*\]' | tr -d '[]')
    if [ -z "$status" ]; then
        echo "stopped"
    else
        echo "$status"
    fi
}

get_title() {
    mpc current -f "%title%" 2>/dev/null || echo ""
}

get_artist() {
    mpc current -f "%artist%" 2>/dev/null || echo ""
}

get_album() {
    mpc current -f "%album%" 2>/dev/null || echo ""
}

get_progress() {
    # Match progress percentage in parentheses like (42%)
    progress=$(mpc status 2>/dev/null | grep -oP '\(\d+%\)' | tr -d '()%')
    if [ -z "$progress" ]; then
        echo "0"
    else
        echo "$progress"
    fi
}

get_position() {
    position=$(mpc status 2>/dev/null | grep -oP '\d+:\d+/' | tr -d '/')
    if [ -z "$position" ]; then
        echo "0:00"
    else
        echo "$position"
    fi
}

get_duration() {
    duration=$(mpc status 2>/dev/null | grep -oP '/\d+:\d+' | tr -d '/')
    if [ -z "$duration" ]; then
        echo "0:00"
    else
        echo "$duration"
    fi
}

# Output JSON for eww
output_json() {
    status=$(get_status)
    title=$(get_title)
    artist=$(get_artist)
    album=$(get_album)
    progress=$(get_progress)
    position=$(get_position)
    duration=$(get_duration)

    # Check if anything is playing
    if [ -z "$title" ]; then
        title="Not Playing"
        artist=""
        album=""
    fi

    echo "{\"status\":\"$status\",\"title\":\"$title\",\"artist\":\"$artist\",\"album\":\"$album\",\"progress\":$progress,\"position\":\"$position\",\"duration\":\"$duration\"}"
}

case "$1" in
    --toggle)
        mpc toggle
        ;;
    --next)
        mpc next
        ;;
    --prev)
        mpc prev
        ;;
    --stop)
        mpc stop
        ;;
    *)
        output_json
        ;;
esac
