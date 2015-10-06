#!/usr/bin/env python

import os
import cgi, cgitb
import sys

form = cgi.FieldStorage()
dirf = form['dir_name']
dir = dirf.value
dirSizecmd = "df -h %s" % dir

dirSize = os.popen(dirSizecmd).read()

print "Content-type:text/html\r\n\r\n"

print
print dirSize
