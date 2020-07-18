
# Desc: This script scans and notifys you if the people specified in the scans.csv file enter/exit the premisis of the machine
# Instructions: Run once, you will be notified if a user enters your wifi connection. You may write specific ipv4 address with associated
#               device names in the scans.csv file. This script only works on mac devices. The more devices you have added to scans.csb, the 
#               slower the program runs. Will need to optimize this... >-(.-.)-<
#
# ** scans.csv Format requirements. **: ipv4Address,displayName

#Imports
import csv
import sys
import subprocess
import os 

def notification(title, message):
    """Notifies the logged in user about the download completion."""

    cmd = 'ntfy -t "{0}" send "{1}"'.format(title, message)
    os.system(cmd)

class Person:
    status=False
    ip=None
    name=None
    def __init__(self, ip, name, status):
        self.ip = ip
        self.name=name
        self.status=status #True == Within Premisis

#Reads and loads scans.csv
with open('scans.csv', 'r') as nodecsv: #Open the file
    nodecsv = csv.reader(nodecsv)       #Read the csv
    nodes = [n for n in nodecsv][2:]

ips_to_names = {}
people=[]

for n in nodes:
    ip = n[0]
    name = n[1]
    people.append(Person(ip, name, False))

while True:
    for person in people: #Go through recorded data
        ping_cmd = 'ping -c 1 {} | grep "[0-9] packets received" | cut -f4 -d" "'.format(person.ip)
        ping_run = subprocess.Popen(ping_cmd, shell=True, stdout=subprocess.PIPE)
        packets = ping_run.communicate()[0][:-1].decode("utf-8")

        if packets == "1" and person.status==False:
            print("Hello! {} has ENTERED the premisis".format(person.name))
            notification("Hello!", "{} has ENTERED the premisis".format(person.name))
            person.status=True

        elif packets == "0" and person.status==True:
            print("Bye! {} has LEFT the premisis".format(person.name))
            notification( "Bye!", "{} has LEFT the premisis".format(person.name))
            person.status=False
        
                
