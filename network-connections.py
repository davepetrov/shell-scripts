#scans.csv format requirenments
#ipv4Address,displayName

#This script scans and notifys you if the people specified in the scans.csv file enter/exit the premisis of the machine

#Imports
import csv
import sys
import subprocess
import os 

def notify(title, text):
    os.system("""osascript -e 'display notification "{}" with title "{}"'""".format(text, title))

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
    nodes = [n for n in nodecsv][1:]

ips_to_names = {}
people=[]

for n in nodes:
    ip = n[0]
    name = n[1]
    people.append(Person(ip, name, False))

while True:
    for person in people:
        ping_cmd = 'ping -c 1 {} | grep "[0-9] packets received" | cut -f4 -d" "'.format(person.ip)
        ping_run = subprocess.Popen(ping_cmd, shell=True, stdout=subprocess.PIPE)
        packets=ping_run.communicate()[0][:-1].decode("utf-8")

        if packets == "1" and person.status==False:
            print("Hello! {} has ENTERED the premisis".format(person.name))
            notify("{} has ENTERED the premisis".format(person.name), "Hello!")
            person.status=True

        elif packets == "0" and person.status==True:
            print("Bye! {} has LEFT the premisis".format(person.name))
            notify("{} has LEFT the premisis".format(person.name), "Bye!")
            person.status=False
        
                
