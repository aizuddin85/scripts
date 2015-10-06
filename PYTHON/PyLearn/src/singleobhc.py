#!/usr/bin/python -d


import os
import sys
import re
import errno
import pexpect
import tempfile

arg1 = sys.argv[1]
getilopwd = "getotherpwd %s ilo" % (arg1)

ilopwd_stdout = os.popen(getilopwd)
ilopwd_output = ilopwd_stdout.readlines()

#grepilopwd = re.search("Password", ilopwd_output)
fname = tempfile.mktemp()
fout = open(fname, 'w')
fread = open(fname, 'r')

for line in ilopwd_output:
        if re.search("Password", line):
                pwdilo = line.split(" ")[2]
                pwdilostr = str(pwdilo)
                pwdilostrip = pwdilostr.rstrip()

                try:
                        print "Testing ILO password(%s) for %s" % (pwdilostrip, arg1)
                        ilopwd_host = arg1 +"-r"
                        ilopwd_cmd = "ssh -o StrictHostKeyChecking=no -o ConnectTimeOut=20 -l iloadmin %s" % ilopwd_host
                        print ilopwd_cmd
                #       p = pexpect.spawn(ilopwd_cmd)
                #       i = p.expect(['password:'])
        #               p.send(pwdilostrip)


        #               if "None" != p.exitstatus:
                #               print "Password Error"


                        child = pexpect.spawn(ilopwd_cmd)
                        child.expect('password:')
                        print child.before
                        child.sendline(pwdilostrip)
                #       out = child.before.readlines()
                #       print re.search('logged-in',out)
                        child.expect('hpiLO')
                #       child.expect('hpILO', timeout=120)
                        chld_bef =  child.before
                        chld_befstr = str(chld_bef)
                        chld_befstrlines = chld_befstr.split(" ")[2]
                        if chld_befstrlines == "logged-in":
                                print "Password is OK!"
                        else:
                                print "Error: Cant determined response from ILO, proceed manually and file bugs to muhammad.zali@t-systems.com"
                        #for line in chld_befstr:
                        #       print line

                #       child.sendline('show /map1',timeout=120)
        #               print child.before
        #               child.expect('hpiLO', timeout=120)
        #               print child.before
        #               child.sendline('exit')
        #               child.interact()
                #       child.logfile_send=fout
                #       child.logfile_read(fread)


                except (RuntimeError, TypeError, NameError):
                        print "Error: Unable to run"

fout.close()
fread.close()
