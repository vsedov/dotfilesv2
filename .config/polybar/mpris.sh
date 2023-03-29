#http://localhost:9863/query!/bin/bash

# requires jq to work
if !hash jq 2>/dev/null; then
  echo "please install 'jq'"
fi
# Specifying the icon(s) in the script
# This allows us to change its appearance conditionally
icon="   "

GMPDIR="$(GET http://localhost:9863/query)"

getitem() {
  item=$1
  echo "$(echo ${GMPDIR} | jq ${item} | sed 's/"//g')"
}

title="$(getitem '.track.title')"
artits="$(getitem '.track.cover')"
album="$(getitem '.track.album')"
liked="$(getitem '.player.likeStatus')"

if [[ $liked = 'true' ]]; then
  liked=""
else
  liked=""
fi

tcurrent="$(getitem '.player.statePercent')"
ttotal="$(getitem '.track.duration')"

round() {
  printf "%.${2}f" "${1}"
}

limited_string=$(echo ${title:0:65})

mseconds=$(echo "$tcurrent * 100" | bc)
roundedcurrent="$(printf %.2f $mseconds)"

player_status="$(getitem '.player.isPaused')"

#metadata="${title}  by  ${artits}  on  ${album} ${liked} ${remain}"
metadata="${limited_string} | | ${roundedcurrent} %  "

# Foreground color formatting tags are optional
if [[ $player_status = "false" ]]; then
  echo "%{F#F3F3BA}$icon $metadata" # Orange when playing
elif [[ $player_status = "true" ]]; then
  echo "%{F#65737E}$icon" # Greyed out info when paused
else
  echo "%{F#65737E}$icon" # Greyed out icon when stopped
fi
