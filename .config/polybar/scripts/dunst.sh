state_file=/home/viv/.config/polybar/scripts/state

dunstctl set-paused toggle
if [ $(dunstctl is-paused) == "false" ]
then
    echo "" > $state_file
else
    echo "" > $state_file
fi
