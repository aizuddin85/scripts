#!/usr/bin/env python
from subprocess import *
import sys
import os

print "Memory information:"
memFile = open('/proc/meminfo', 'r')



for line in memFile.readlines():	
	if line.startswith("MemFree"):
		memStr = line.split()
		memTotal = memStr[1]
		memFile.close()
		memFree = int(memTotal) / 1024
		print "Free Memory: " + str(memFree) + "MB"

print
print "CPU Information:"
cpuFile = open('/proc/cpuinfo')

for line in cpuFile.readlines():
	if line.startswith("processor"):
		cpuStr = line.split()
		cpuTotal = cpuStr[2]
		cpuFile.close()
		print "Proc: " + cpuTotal + " Cores"

load = Popen(["uptime"], stdout=PIPE, shell=True)
grep = Popen(["awk '{print $8}'"], stdin=load.stdout, stdout=PIPE, shell=True)
cut = Popen(["cut -c1-4"], stdin=grep.stdout, stdout=PIPE, shell=True )
comp = Popen(["cut -c1-4"], stdin=grep.stdout, shell=True )
result = cut.communicate()


print "\n"
print "Verifying machine CPU load:"

if comp.stdout < 1.5:
	print  "Load OK :" + result[0]
else:
	print "Load not OK :"  + result[0]

load.terminate()
grep.terminate()
comp.terminate()


