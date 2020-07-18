#!/bin/bash
# Saves files in a hashed directory structure based on their image IDs.
# Each image ID is a 16 character 64-bit string. 
# Ie. 1234...6789.png -> 89/67/.../34/12/ would be created

if $# >= 1 ; then
    path="$1"
else
    path="$PWD"
fi

ls path | grep -e "[0-9]\{16\}.*" | while read file 
do
    rev_hex=$(echo $file | cut -b 1-16 | rev) 
    new_tree=
    for ((i=0;i<16;i+=2))
    do
        new_tree="${new_tree}/${rev_hex:i:2}"
    done

    new_tree=${new_tree:1}
    echo Adding $file to $new_tree
    if [ -d ./$new_tree ]
    then
        cp $file $new_tree
    else
        mkdir -p $new_tree
        cp $file $new_tree
    fi
done

