
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
    """Notifies the logged in user"""

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
    for i in range(20, 22):
        ip = '192.168.0.{}'.format(i)
        print("checking misc ip {}".format(ip))
        ping_cmd = 'ping -c 1 {} | grep "[0-9] packets received" | cut -f4 -d" "'.format(ip)
        ping_run = subprocess.Popen(ping_cmd, shell=True, stdout=subprocess.PIPE)
        packets = ping_run.communicate()[0][:-1].decode("utf-8")
        if packets == "1":# and ip not in ips_to_names:
            print("Watch out: Misc device connected to your wifi! ")
            notification( "Watchout!", "[{}] Misc device connected to your wifi! ".format(ip))

        #Fast checking recorded data while checking all the other possible misc devices
        for person in people:
            print("Checking "+person.name)
            
            ping_cmd = 'ping -c 1 {} | grep "[0-9] packets received" | cut -f4 -d" "'.format(person.ip)
            ping_run = subprocess.Popen(ping_cmd, shell=True, stdout=subprocess.PIPE)
            packets = ping_run.communicate()[0][:-1].decode("utf-8")

            if packets == "1":
                if person.status==False:
                    print("Hello! {} has ENTERED the premisis".format(person.name))
                    notification("Hello!", "{} has ENTERED the premisis".format(person.name))
                    person.status=True
                else:
                    pass
                    #print("{} is in the premisis already".format(person.name))

            elif packets == "0":
                if person.status==True:
                    print("Bye! {} has LEFT the premisis".format(person.name))
                    notification( "Bye!", "{} has LEFT the premisis".format(person.name))
                    person.status=False
                else:
                    pass
                    #print("{} is not in the premisis".format(person.name))