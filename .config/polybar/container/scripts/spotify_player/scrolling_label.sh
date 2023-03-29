#!/bin/bash
zscroll -l 26 \
        --delay 0.1 \
        --scroll-padding "  " \
        --match-command "/bin/bash $HOME/.config/polybar/scripts/spotify_player/spotify_status.sh --status" \
        --match-text "Playing" "--scroll 1" \
        --match-text "Paused" "--scroll 0" \
        --update-check true "/bin/bash $HOME/.config/polybar/scripts/spotify_player/spotify_status.sh" &
wait
