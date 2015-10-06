#! /usr/bin/python

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

__author__ = "root"
__date__ = "$Mar 9, 2015 3:23:47 PM$"
import os

if __name__ == "__main__":
    
    print os.system('env')
    
    print "DISPLAY is set to: " + os.getenv('DISPLAY')
    env = os.getenv('DISPLAY')
    
     
    splt = env.split(":")
    if splt[0] == "localhst":
        print "OK"
    else:
        print "Error:DISPLAY is set to: " + splt[0]
    
    
