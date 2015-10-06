#!/usr/bin/env python

import os
import cgi
import sys


def errorDie(errmsg):
        print errmsg
        print """
        Usage: <http://rhnserver.europe.shell.com/shell-adi/exportcheck.py?ipaddress=156.149.178.4>
        """
        sys.exit(1)


def main():
        input = cgi.FieldStorage()
        if not input.has_key('ipaddress'):
                errorDie("Came on dude! Give me something that I can understand! :-)")

        ipaddrf = input['ipaddress']
        ipaddr = ipaddrf.value

        zonecmd = "/etc/httpd/exportcheck/getzone.py %s" % ipaddr
        zone = os.popen(zonecmd).read().rstrip()
        print zone


        getListcmd = "grep -i %s /etc/httpd/exportcheck/configs/distributions.ini" % zone
        print getListcmd
        getList = os.popen(getListcmd).read()
        print getList

print "Content-type: text/plain\n\n"
print
main()
