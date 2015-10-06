#! /usr/bin/python

# To change this license header, choose License Headers in Project Properties.
# To change this template file, choose Tools | Templates
# and open the template in the editor.

__author__ = "root"
__date__ = "$Mar 9, 2015 3:05:52 PM$"
import os

if __name__ == "__main__":


    '''
    os.lseek(fd, pos, how)
    os.read(fd, n) In the first call, fd is 'file descriptor', pos is 'position', and how is an integer of 0, 1, or 2. This indicates how to calculate the position using pos. 0 is relative to the beginning of the file, 1 is relative to the current position within the file, and 2 is relative to the end. In the second call, n is the number of bytes you want to read from the position within the file.
    To get characters 10-15, we first move to the tenth point from the head of the file:
    os.lseek(3, 10, 0)
    Then we can read the 10-16 characters:
    os.read(3,6)
    Depending on the numbers you feed os, you may get any manner of character combinations. As Python sees HTML as simple text, you will get HTML tags and the like. If, however, you copy this article as text and save it, you will get something different:
    'th Pyt'
    Keep in mind that we are telling Python to move within the file according to characters - not words. Therefore, it treats spaces in the same way as it treats letters or numbers. 
    '''


## fd example of file creation
    fd = os.open("/var/log/learnpy", os.O_RDWR|os.O_CREAT)
    os.write(fd , "Hello, test begin")
    os.fsync(fd)
    os.lseek(fd ,200,2)
    str =  os.read(fd , 10000)
    print "Read String is : ", str

    os.close(fd)
   
    print "File closed"
##


## fd append mode
    fd = os.open("/var/log/learnpy", os.O_RDWR|os.O_APPEND)
    os.write(fd, "Appending\n")
    os.fsync(fd)
    os.lseek(fd,1,0)
    str1 = os.read(fd, 100)
    print str1
    os.close(fd)
##

