#!/usr/bin/env python

import os
import cgi, cgitb
import sys


print "Content-type:text/html\r\n\r\n"

print 
print "<html>"
print "<head>"

print """

Enter Information below:

"""

print """
<form action="/cgi-bin/processinfo.py" method="get">
Directory Name: <input type="text" name="dir_name">  <br />
<input type="submit" value="Submit" />

</form>

"""



print "</head>"
print "</html>"
