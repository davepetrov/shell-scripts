#!/bin/bash
# Arg 1: [restart -r/ end -e /start -s /status -p]
# Arg 2 : [gcloud instance name (Ex: windows-machine)

if ! [ "$#" = 2 ]
then
    echo "Invalid number of arguments"
    exit 2
fi

echo "Checking if instance $2 exists..."
(gcloud compute instances list | grep "$2" > /dev/null) && echo "Failure: instance $2 does does not exist" | exit 0
echo "Success: Instance $2 exists. Continuing..."

case "$1" in
    "-p" | "status")
        gcloud compute instances list --filter=name:"$2" --format="table[box,title='$2 Status'](id,status)"
        ;;
    "-s" | "start")
        echo "Starting cloud instances: $2 ..."
        gcloud compute instances start "$2"
        if [ "$?" = 1 ]
        then
            echo "Failure: Could not start instance"
            exit 1
        fi
        ;;
    "-r" | "restart")
        echo "Restarting cloud instances: $2 ..."
        gcloud compute instances stop "$2"
        if [ "$?" = 0 ]
        then
            gcloud compute instances start "$2"
        else
            echo "Failure: Could not stop $2 instance. Aborting..."
            exit 1
        fi
        ;;
    "-e" | "end")
        echo "Stopping cloud instance: $2 ..."
        gcloud compute instances stop "$2"
        if [ "$?" = 1 ]
        then
            echo "Failure: Could not stop $2 instance. Aborting..."

            exit 1
        fi
        ;;
    *)
        echo "Exit: Invalid argument"
        exit 127
        ;;
esac

exit 0
