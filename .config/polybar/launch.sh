# #!/usr/bin/env sh
#
# # Terminate already running bar instances
# killall -q polybar
#
# # Wait until the processes have been shut down
# while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done
#
# if type "xrandr"; then
#   for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
#
#     MONITOR=$m polybar MainBarBottom &
#     MONITOR=$m polybar MainBar &
#   done
# else
#   polybar MainBar &
#   polybar MainBarBottom &
# fi
#!/usr/bin/env sh
killall -q polybar

# Wait until the processes have been shut down
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    # if m is HDMI-0 then use secondary bar
    if [ "$m" = "HDMI-0" ]; then
      MONITOR=$m polybar --reload secondary &
      MONITOR=$m polybar --reload bottom &
    else
      MONITOR=$m polybar --reload primary &
      # MONITOR=$m polybar --reload bottom_main&
    fi

  done
else
  polybar MainBar &
  polybar MainBarBottom &
fi
