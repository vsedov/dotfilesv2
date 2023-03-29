#!/bin/bash
publicIP="  $(curl -s https://ipinfo.io/ip)"
ethIP=$(ip -4 addr show enp5s0 | grep -oP "(?<=inet ).*(?=/)") 
wlanIP=$(ip -4 addr show enp5s0 | grep -oP "(?<=inet ).*(?=/)")

if [ -z "$ethIP" ]
	then
		localIP="  $(ip -4 addr show wlan0 | grep -oP "(?<=inet ).*(?=/)")"
	else
		localIP="  $(ip -4 addr show enp5s0 | grep -oP "(?<=inet ).*(?=/)")"
fi
mem="$(cat ./.mem)"

case "$1" in 
    -u|--update)
        if [[ "$mem" == "public" ]]; then
            echo "local" > ./.mem 
        else
            echo "public" > ./.mem
        fi
    ;;

    -f|--fetch)
        if [[ "$mem" == "public" ]]; then
            echo "$publicIP"
        else
            echo "$localIP"
        fi
    ;;

    -h|--help)
        echo "ip.sh created by z89 for polybar"
        echo " "
        echo "-h or --help          display a list of commands for ip.sh"
        echo "-u or --update        switches the ip address from public to local or vice versa"
        echo "-f or --fetch         displays the current ip address dependant on the state"
    ;;

    *)
        echo "add -h or --help for a list of commands"
    ;;
esac
