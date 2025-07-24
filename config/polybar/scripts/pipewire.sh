#!/usr/bin/env bash

function main() {
    case $1 in
        mute)
            wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
            ;;
        up)
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+
            ;;
        down)
            wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-
            ;;
        *)
            ;;
    esac

    local volume_and_mute=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ | sed 's|^.*0\.||')
    local volume=$( echo ${volume_and_mute} | sed 's|^\([[:digit:]]\+\).*$|\1|')
    local muted=$( echo ${volume_and_mute} | grep -o MUTE )

    local symbol
    if [[ -n $muted ]]; then
        symbol='󰟎'
    else
        symbol='󰋋'
    fi

    echo "${symbol} ${volume}%"
}

main "$@"
