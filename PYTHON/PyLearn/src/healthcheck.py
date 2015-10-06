#!/usr/bin/python

import os
import re
import subprocess
try:
        print "Verifying " + os.uname()[1] + " host health."

##MemInfo
        meminfo = open('/proc/meminfo','r')
        readmem = meminfo.readlines()

        for k in readmem:
                if re.search('MemTotal',k):
                        split = k.split (" ")
                        totmemkb = int(split[7])
                        totmemgb = totmemkb/1000000
        for i in readmem:
                if  re.search('MemFree', i):
                        split = i.split(" ")
                        memkb = int(split[8])
                        memgb = memkb/1000000
                        if memgb < 2:
                                print "Warning memory usage is below : " + str(memgb) + "GB free"  + " from total of : " + str(totmemgb) + "GB"
                        else:
                                print "Free Memory is OK : " + str(memgb) + "GB free"  + " from total of :" + str(totmemgb) + "GB"

##Disk Utilization
        df = subprocess.Popen(["df", "/"], stdout=subprocess.PIPE)
        dfout = df.communicate()[0]

        dfoutsplt =  dfout.split()[11]
        dfvalue = dfoutsplt.split("%")[0]
        dfint =  int(dfvalue)
        if dfint > 99:
                print "Disk Usage is high at :" + str(dfvalue) + "%"
        else:
                print "Disk Usage is OK at :" + str(dfvalue) + "%"

##Load average
        load = os.getloadavg()[1]
        value = int(load)
        if value > 5:
                print "Load is high :" + str(value)
        else:
                print "Load is OK :" + str(value)



        meminfo.close()


except (ValueError, RuntimeError):
        print "Error"
