#!/bin/sh
primaryX=0
secondaryX=0

xPos=0

while read -r line ; do
    deconstructedMonitor=($line)
    if [[ "${deconstructedMonitor[2]}" == "primary" ]]; then
        monitor=(${line})
	primaryResolution="${monitor[3]}"
        temp=${primaryResolution##*x}
        primaryX=${primaryResolution%%x*}
    elif [[ $x < 2 ]]; then
        monitor=(${line})
        secondaryResolution="${monitor[2]}"
        temp=${secondaryResolution##*x}
        secondaryX=${secondaryResolution%%x*}
    fi
    ((x++))
done  <  <(xrandr | grep -w connected)

if [[ $(xdotool getmouselocation | awk -F[' +'] '{print $1}' | cut -c 3-) -ge $primaryX ]]; then
    xPos=$(echo "scale=3;($secondaryX + $primaryX) - 300" | bc)
else
    xPos=$(echo "scale=3;($primaryX) - 300" | bc)
fi

TIME="$(date +"   %I:%M %p")"

case "$1" in

--popup)
\
    yad --calendar  --decorated --fixed  --no-buttons \
        --width="300" --height="20" --close-on-unfocus --border=0 --posx="$xPos" --posy="37" \
        --borders=0 >/dev/null &
    ;;
*)
    echo "$TIME"
    ;;
esac
