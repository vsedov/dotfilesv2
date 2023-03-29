#!/bin/bash
publicIP="  $(curl -s https://ipinfo.io/ip)"
localIP="  $(ip -4 addr show wlan0 | grep -oP "(?<=inet ).*(?=/)")"
interface="  $(nmcli -t -f active,ssid dev wifi | egrep '^yes' | cut -d\' -f2 | cut -c 5-)"
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

    -s|--ssid)
        echo "$interface"
    ;;

    -h|--help)
        echo "ip.sh created by z89 for polybar"
        echo " "
        echo "-h or --help          display a list of commands for ip.sh"
        echo "-u or --update        switches the ip address from public to local or vice versa"
        echo "-f or --fetch         displays the current ip address dependant on the state"
        echo "-s or --ssid          displays the currently network ssid (broken, only set to wlp2s0 atm)"
    ;;

    *)
        echo "add -h or --help for a list of commands"
    ;;
esac
