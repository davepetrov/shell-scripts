#!/bin/bash
#Arg 1: [restart/stop/start]
#Arg 2 : [Virtual Machine Name (Ex: windows-machine)]

if ! [ "$#" = 2 ]
then
    echo "Invalid number of arguments"
    exit 2
fi

if [ "$1" = "start" ]
then
    echo "Starting Virtual Machine: $2 ..."
    gcloud compute instances start "$2"
    if [ "$?" = 1 ]
    then
        echo "Exit: Could not start instance"
        exit 1
    fi
elif [ "$1" = "restart" ]
then
    echo "Restarting Virtual Machine: $2 ..."
    gcloud compute instances stop "$2"
    if [ "$?" = 0 ]
    then
        gcloud compute instances start "$2"
    else
        echo "Exit: Could not stop instance"
        exit 1
    fi
elif [ "$1" = "stop" ]
then
    echo "Stopping Virtual Machine: $2 ..."
    gcloud compute instances stop "$2"
    if [ "$?" = 1 ]
    then
        echo "Exit: Could not stop instance"
        exit 1
    fi
else
    echo "Exit: Invalid argument"
    exit 127
fi

exit 0
