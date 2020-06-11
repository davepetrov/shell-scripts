#!/bin/bash


# Checks for # of arguments
if [ $# -ne 2 ]; then
    echo usage: $0 [../Source/] [../Target/]
    exit 1
fi

#Checks for existing output directory (Disables overwriting)
if [ -d "$2" ]; then
    echo Error: Output Dir Exists
    exit 2
fi

#Create target directory
mkdir "$2"
for i in "$1"/*
do
    outer=`basename "$i"`
    for j in "$i"/*
    do  
        inner=`basename "$j"`
        mkdir "$2/$inner/"
        mkdir "$2/$inner/$outer"
        cp -nr "$j"/* "$2/$inner/$outer"
    done
done
