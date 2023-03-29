#!/usr/bin/env sh
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # if m is HDMI-0 then use secondary bar
    if [ "$m" = "HDMI-0" ]; then
      MONITOR=$m polybar --reload secondary &
    else
      MONITOR=$m polybar --reload primary &
    fi

  done
else
  polybar MainBar &
  polybar MainBarBottom &
fi
