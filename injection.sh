# !/bin/bash

if [ $EUID != 0 ]; then
    echo This program requires root privileges
    exit
fi

if [ -z "$1" ]; then
    echo Failed: state missing
    echo "Usage: ./injection.sh [state] [interface]"
    echo "state\t\tCan be on/off"
    exit
fi

if [ -z "$2" ]; then
    echo Failed: interface missing
    echo "Usage: ./injection.sh [state] [interface]"
fi

if [ "$1" == "on" ]; then
    ifconfig $2 down
    iwconfig $2 mode Monitor
    ifconfig $2 up
    exit
fi

if [ "$2" == "off" ]; then
    systemctl restart NetworkManager
    exit
fi
