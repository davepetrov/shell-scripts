# :newspaper_roll: shell-scripts
Miscellaneous shell scripts I've written in spare time for optimization purposes

## defun.sh
Usage: defun [-d]... [pathname]...

The arguments are normally taken to be pathnames. For each pathname p, in the given order, check checks whether p exists or not, and outputs one of the following messages accordingly:

        p exists
        p does not exist
        
If a pathname is preceded by one or more occurrences of flags “-d” (as a separate argument), then instead check whether the pathname is an existing directory or not, and the messages are instead:

        p is a directory
        p is not a directory

## transpose.sh
Usage: transpose [SOURCE] [TARGET]

Copy src content to tgt, but switching the scheme along the way.
Ex:
src/2017/B63...
src/2018/B63...
src/2018/C24...
src/2019/B09...
src/2019/C24...

Then: 
tgt/B09/2019...
tgt/B63/2017...
tgt/B63/2018...
tgt/C24/2018...
tgt/C24/2019...

## hex-hashed-dir.sh
Usage: hex-hashed-dir [PATH]

Saves files in a hashed directory structure based on their image IDs where each image ID is a 16 character 64-bit string. 
Ex: 1234...6789.png exists in PATH, then 89/67/.../34/12/ would be created where the file would be stored.

## gcloud.sh :cloud:
Usage: gcloud [restart -r/ end -e /start -s /status -p] [INSTANCE NAME]

Restarts, stops, starts and shows status with gcloud instance INSTANCE

## stampmerge.sh
Usage: stampmerge [Directory] [Seperator=' ']

A script that merges daily log files into monthly log files
Ex: 
     Your currently directory includes YYYY-MM-01.log, YYYY-M1-02.log
     When run, the information within the daily log file are concatenated and appended into YYYY-MM.log in order based on their day

## network-connections :iphone: :watch: :computer:
Usage: python3 network-connections.py

If the people specified in the scans.csv file enter/exit the premisis of the machine, you will be notified on the top right of your screen. You may write specific ipv4 addresses with associated device names in the corresponding scans.csv (format: ipv4Address,displayName) file. This script only works on mac devices. The more device listed in scans.csb, the slower the program runs. Will need to optimize this...

