#!/bin/bash

# Music info script for eww - supports both MPRIS (playerctl) and MPD (mpc)
# Prefers MPRIS if a player is active, falls back to MPD

get_source() {
    # Check if any MPRIS player is available and playing/paused
    if playerctl status &>/dev/null; then
        echo "mpris"
    elif mpc status &>/dev/null; then
        echo "mpd"
    else
        echo "none"
    fi
}

SOURCE=$(get_source)

# MPRIS functions (playerctl)
mpris_status() {
    status=$(playerctl status 2>/dev/null | tr '[:upper:]' '[:lower:]')
    case "$status" in
        playing) echo "playing" ;;
        paused) echo "paused" ;;
        *) echo "stopped" ;;
    esac
}

mpris_title() {
    playerctl metadata title 2>/dev/null || echo ""
}

mpris_artist() {
    playerctl metadata artist 2>/dev/null || echo ""
}

mpris_album() {
    playerctl metadata album 2>/dev/null || echo ""
}

mpris_progress() {
    position=$(playerctl metadata --format '{{position}}' 2>/dev/null)
    duration=$(playerctl metadata --format '{{mpris:length}}' 2>/dev/null)
    if [ -n "$position" ] && [ -n "$duration" ] && [ "$duration" -gt 0 ]; then
        echo $((position * 100 / duration))
    else
        echo "0"
    fi
}

mpris_position() {
    position_us=$(playerctl metadata --format '{{position}}' 2>/dev/null)
    if [ -n "$position_us" ]; then
        position_sec=$((position_us / 1000000))
        printf "%d:%02d" $((position_sec / 60)) $((position_sec % 60))
    else
        echo "0:00"
    fi
}

mpris_duration() {
    duration_us=$(playerctl metadata --format '{{mpris:length}}' 2>/dev/null)
    if [ -n "$duration_us" ]; then
        duration_sec=$((duration_us / 1000000))
        printf "%d:%02d" $((duration_sec / 60)) $((duration_sec % 60))
    else
        echo "0:00"
    fi
}

# MPD functions (mpc)
mpd_status() {
    status=$(mpc status 2>/dev/null | grep -o '\[.*\]' | tr -d '[]')
    if [ -z "$status" ]; then
        echo "stopped"
    else
        echo "$status"
    fi
}

mpd_title() {
    mpc current -f "%title%" 2>/dev/null || echo ""
}

mpd_artist() {
    mpc current -f "%artist%" 2>/dev/null || echo ""
}

mpd_album() {
    mpc current -f "%album%" 2>/dev/null || echo ""
}

mpd_progress() {
    progress=$(mpc status 2>/dev/null | grep -oP '\(\d+%\)' | tr -d '()%')
    if [ -z "$progress" ]; then
        echo "0"
    else
        echo "$progress"
    fi
}

mpd_position() {
    position=$(mpc status 2>/dev/null | grep -oP '\d+:\d+/' | tr -d '/')
    if [ -z "$position" ]; then
        echo "0:00"
    else
        echo "$position"
    fi
}

mpd_duration() {
    duration=$(mpc status 2>/dev/null | grep -oP '/\d+:\d+' | tr -d '/')
    if [ -z "$duration" ]; then
        echo "0:00"
    else
        echo "$duration"
    fi
}

# Unified getters that use the detected source
get_status() {
    case "$SOURCE" in
        mpris) mpris_status ;;
        mpd) mpd_status ;;
        *) echo "stopped" ;;
    esac
}

get_title() {
    case "$SOURCE" in
        mpris) mpris_title ;;
        mpd) mpd_title ;;
        *) echo "" ;;
    esac
}

get_artist() {
    case "$SOURCE" in
        mpris) mpris_artist ;;
        mpd) mpd_artist ;;
        *) echo "" ;;
    esac
}

get_album() {
    case "$SOURCE" in
        mpris) mpris_album ;;
        mpd) mpd_album ;;
        *) echo "" ;;
    esac
}

get_progress() {
    case "$SOURCE" in
        mpris) mpris_progress ;;
        mpd) mpd_progress ;;
        *) echo "0" ;;
    esac
}

get_position() {
    case "$SOURCE" in
        mpris) mpris_position ;;
        mpd) mpd_position ;;
        *) echo "0:00" ;;
    esac
}

get_duration() {
    case "$SOURCE" in
        mpris) mpris_duration ;;
        mpd) mpd_duration ;;
        *) echo "0:00" ;;
    esac
}

# Control functions - send to appropriate backend
do_toggle() {
    case "$SOURCE" in
        mpris) playerctl play-pause ;;
        mpd) mpc toggle ;;
    esac
}

do_next() {
    case "$SOURCE" in
        mpris) playerctl next ;;
        mpd) mpc next ;;
    esac
}

do_prev() {
    case "$SOURCE" in
        mpris) playerctl previous ;;
        mpd) mpc prev ;;
    esac
}

do_stop() {
    case "$SOURCE" in
        mpris) playerctl stop ;;
        mpd) mpc stop ;;
    esac
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

    echo "{\"status\":\"$status\",\"title\":\"$title\",\"artist\":\"$artist\",\"album\":\"$album\",\"progress\":$progress,\"position\":\"$position\",\"duration\":\"$duration\",\"source\":\"$SOURCE\"}"
}

case "$1" in
    --toggle)
        do_toggle
        ;;
    --next)
        do_next
        ;;
    --prev)
        do_prev
        ;;
    --stop)
        do_stop
        ;;
    *)
        output_json
        ;;
esac
