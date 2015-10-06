#!/bin/bash

GUEST=$1

if [  -z $1 ];
then
echo "No guest name input given. Terminating..." 
exit 1
fi

echo "Destroying $1 instance"
/usr/bin/virsh destroy $1


if [ -a /var/lib/libvirt/images/$1.qcow2 ];
then
echo "$1.qcow2 virtual disk exist, deleting ..."
rm -rf /var/lib/libvirt/images/$1.qcow2 
else 
echo "No /var/lib/libvirt/images/$1.qcow2 found. Continue..."
fi

echo Deleting $1 guest...
/usr/bin/virsh undefine $1
echo Done!

