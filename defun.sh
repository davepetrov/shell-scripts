#!/bin/sh
#The arguments are normally taken to be pathnames. For each pathname p, in the given order, check checks whether p exists or not, and outputs one of the following messages accordingly:
        #p exists
        #p does not exist
#However! If a pathname is preceded by one or more occurrences of flags “-d” (as a separate argument), then instead check whether the pathname is an existing directory or not, and the messages are instead:
        #p is a directory
        #p is not a directory

check()
{
    checkdir=0
    for i in "$@"
    do
        if [ "$i" != '-d' ]
        then
            if [ $checkdir -eq 0 ]
            then
                #Check if exists
                if [ -e "$i" ]
                then
                    echo "$i" exists
                else
                    echo "$i" does not exist
                fi
            else
                #Check if directory
                if [ -d "$i" ]
                then
                    echo "$i" is a directory
                else
                    echo "$i" is not a directory
                fi
                checkdir=0
            fi
        else
            checkdir=1
        fi
    done
}

# Tests
#check 'my path' p2 -d p2 p2 -d -d 'my path'; echo
#check 'my path' 'my path' 'my path' -d 'my path' -d -d 'my path'; echo
#check -d -d -d -d 'my path' -d p2 p2; echo
#check -d p2
#check -d 'my path'
#check p2
#check 'my path'
