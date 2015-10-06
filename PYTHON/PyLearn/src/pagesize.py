#! /usr/bin/python

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

__author__ = "root"
__date__ = "$Mar 9, 2015 3:01:23 PM$"

import os

if __name__ == "__main__":
    
    ## Example checking OS paging space with if else logic:
    PAGE_SIZE =  os.sysconf('SC_PAGE_SIZE')
    
    try:
        if PAGE_SIZE < 2048:
            print "Paging size is lower than 2048"
        else:
            print "Paging size is " + str(PAGE_SIZE) + "MB :OK"
    except IOError:
        print "Cant determine PAGE SIZE"
    ##
