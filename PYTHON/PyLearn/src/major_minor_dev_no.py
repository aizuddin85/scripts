#! /usr/bin/python

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

__author__ = "root"
__date__ = "$Mar 9, 2015 2:57:10 PM$"

import os

if __name__ == "__main__":
    ## Example to get major and minor device number usiong os.stat st_dev result:
    print os.stat("/")
    print "Major number for / is: " +  str(os.major(64770L))
    print "Minor number for / is: " +  str(os.minor(64770L))
    ##
