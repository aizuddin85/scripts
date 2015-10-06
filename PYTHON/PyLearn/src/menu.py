#!/usr/bin/python
import os
import time
import syslog
import crypt


class colors:
        BOLD = '\033[1m'
        UNDERLINE = '\033[4m'
        END = '\033[0m'

def pause():
        print '\nPausing...  (Hit ENTER to continue, type quit to exit.)'
        try:
                response = raw_input()
                if response == 'quit':
                        raise SystemExit
                else:
                        clear()
        except KeyboardInterrupt:
            print 'Resuming...'

def clear():
        os.system("clear")

def currentTime():
        print "Current date & time " + time.strftime("%c")

def addUser():
        username = raw_input('Enter username to add:')
        password = raw_input('Password for %s:' % username)
        encCred = crypt.crypt(password,"22")
        os.system("useradd -p " +encCred+ " -s /bin/bash " +username)
        syslog.openlog ( 'PhyUserAdd', 0, syslog.LOG_USER )
        syslog.syslog ( '%%Adding-User: %s ' % username )

clear()
ans=True
while ans:
        print (colors.BOLD + colors.UNDERLINE + "SELECT OPTIONS:" + colors.END)
        print ("""
        1.Add a user
        2.Delete a user
        3.Look Up user records
        4.Exit/Quit
        """)
        currentTime()
        ans=raw_input("Key in your choice:")
        if ans == "1":
                addUser()
                pause()
        elif ans == "3":
                print ("\n Student Deleted")
                pause()
        elif ans == "3":
                print ("\n Student record found!")
                pause()
        elif ans == "4":
                print ("\n Bye!")
                raise SystemExit
        else:
                print("\n Not Valid Choice Try again")
                pause()
