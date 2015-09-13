#!/bin/bash

cpu=`lscpu | grep "^Core(s)" | awk '{print $4}'`
mem=`free -m | grep Mem | awk '{print $2}'`
disk=`df -h /var/lib/libvirt/images/ | grep mapper | awk '{print $4}'`

read -p "Enter the hostname (this will be created as disk image name as well) :" hostname
read -p "Enter maximum CPU count (max $cpu) :" cpucount
read -p "Enter disk size (max $disk in GB, eg 10G) :" disksize
read -p "Enter memory size in MB (max $mem MB, eg 2048) :" memsize
read -p "Enter IP Address (eg x.x.x.x) : " ip

echo "Please verify below details:"
echo "Hostname: $hostname"
echo "Disk Image: $hostname.qcow2"
echo "CPU Count: $cpucount"
echo "Disk size: $disksize"
echo "Memory size: $memsize MB"
echo "IP Address: $ip"
echo
read -p "Continue [Yes/No}? " input

if [ $input == "Yes" ]; then
	if [ $cpucount -gt $cpu ]; then
		echo "CPU Count is greater then available core. Terminating..."
		exit 1
	elif [ $memsize -gt $mem ]; then
		echo "Memory size is greater than available memory. Terminating..."
		exit 1
	elif [ $disksize -gt $disk ]; then
		echo "Disk size is greater then available space. Terminating..."
		exit 1
	else
		echo "Parameters OK. Continue..."	
	fi

elif [ $input == "No" ]; then
	echo "Terminating..."
	exit 1
else
	echo "Wrong input. Please enter Yes or No! Exiting."
	exit 1
fi


echo "Creating qcow2 image of $disksize for $hostname"
cd /var/lib/libvirt/images/

/usr/bin/qemu-img create -f qcow2 ${hostname}.qcow2 $disksize 

if [ $? == 0 ]; then
	echo "Image created succesfully!"
else
	echo "Fatal, unable to create disk image!"
	exit 1
fi


echo "Kickstarting EL7 machine..."
/usr/bin/virt-install --name=${hostname} -f /var/lib/libvirt/images/${hostname}.qcow2 --ram=${memsize} --vcpus=${cpucount} --os-varian=rhel7 --extra-args "console=ttyS0 ks=http://172.28.0.5/cblr/svc/op/ks/profile/centos7os:1:SpacewalkDefaultOrganization  SERVERNAME=$hostname ip=$ip netmask=255.255.255.0 gateway=172.28.0.1 dns=172.28.0.2" --location=http://172.28.0.2/images/centos7


if [ $? == 0 ]; then
	echo " Machine kickstarted!"
else
	echo "Kickstar failed!"
fi



