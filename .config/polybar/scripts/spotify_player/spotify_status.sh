
#!/bin/bash
PARENT_BAR="secondary"
PARENT_BAR_PID=$(pgrep -a "polybar" | grep "$PARENT_BAR" | cut -d" " -f1)

PLAYER="youtube-music"
FORMAT="{{ title }} - {{ artist }}"

PLAYERCTL_STATUS=$(playerctl --player=$PLAYER status 2>/dev/null)

EXIT_CODE=$?

if [ $EXIT_CODE -eq 0 ]; then
    STATUS=$PLAYERCTL_STATUS
else
    STATUS="No player is running"
fi

if [ "$1" == "--play-pause" ]; then
	if [ "$STATUS" = "Playing" ]; then
		echo "  "
		exit
	else
		echo " 契 "
		exit
	fi

elif [ "$1" == "--status" ]; then
	echo "$STATUS"

else
	if [ "$STATUS" = "Stopped" ]; then
		echo "Youtube Music -> music stopped"
   	 elif [ "$STATUS" = "Paused"  ]; then
       	 	playerctl --player=$PLAYER metadata --format "$FORMAT"
   	 elif [ "$STATUS" = "No player is running"  ]; then
        	echo "Youtube Music -> is closed"
    	else
        	playerctl --player=$PLAYER metadata --format "$FORMAT"
    	fi
fi
