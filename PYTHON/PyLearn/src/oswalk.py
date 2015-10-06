#! /usr/bin/python

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

__author__ = "root"
__date__ = "$Mar 9, 2015 2:49:52 PM$"

import os

## os.walk example
for root, dirs, files in os.walk("/root", topdown=True, onerror=None, followlinks=False):
        for name in files:
            print (os.path.join(root,name))
## os.walk ends