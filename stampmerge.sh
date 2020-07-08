#!/bin/sh
# A script that merges daily log files into monthly log files in an orderly manner
# Correct use format: $ ./stampmerge [Directory] [Seperator=' ']
# Ex: 
    # Your currently directory includes YYYY-MM-01.log, YYYY-M1-02.log
    # When run, the information within the daily log file are concatenated and appended into YYYY-MM.log in order based on their day

# Checking for correct arguments.
case "$#" in
    "0")
        sep=' '
        dir=$PWD
        echo "Merging current directory..."
        ;;
    "1")
        sep=" "
        dir="$1"
        ;;
    "2")
        sep="1"
        dir="$1"
        ;;
    *)
        echo "Error: Invalid # of arguments" >&2
        exit 1
        ;;
esac
if ! [ -d "$dir" ] 
then
    echo "Error: Invalid directory" >&2
    exit 1
fi


#Go through the .log files and do the magic
ls $dir | grep -e "[0-9][0-9][0-9][0-9]-[0-1][0-9]-[0-3][0-9].log" | while read file
do
    out="$(echo $file | cut -b 1-7).log" #year-mo.log
    pre=$(echo $file | cut -b 1-10)     
    cat $file | while IFS= read -r line #IFS=: avoids removing leading and trailing spaces, -r disables backslash escaping
    do
        echo "${pre}${sep}${line}"
    done >> $out
done

echo "Merging Complete"




    