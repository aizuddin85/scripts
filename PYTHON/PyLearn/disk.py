#!/bin/env python
import subprocess




def uname_func():

	uname = "uname"
	uname_args = "-a"
	print "Gathering sys info with %s command: \n" 
	subprocess.call([uname, uname_args])

def disk_func():

	diskspace = "df"
	diskspace_args = "-h"
	print "Disk space info %s command: \n" 
	subprocess.call([diskspace, diskspace_args])



def main():
	disk_func()
	uname_func()

main()
