#!/bin/bash

GUEST=$1

if [  -z $1 ];
then
echo "No guest name input given. Terminating..." 
exit 1
fi





if [ -a /var/lib/libvirt/images/$1.qcow2 ];
then
echo "$1.qcow2 virtual disk exist, terminating..."
else 
echo "Creating $1.qcow2 virtual disk..."
/usr/bin/qemu-img create -f qcow2 /var/lib/libvirt/images/$1.qcow2 15G
chown qemu.qemu /var/lib/libvirt/images/$1.qcow2
echo Done!
fi

echo Starting kickstart...
virt-install -r 1024 --accelerate -n $1 -f /var/lib/libvirt/images/$1.qcow2 --extra-args="console=ttyS0 ksdevide=eth0 ip=dhcp  ks=http://172.28.0.52/centos7.ks" --location=http://172.28.52/centos7/
echo Done!

