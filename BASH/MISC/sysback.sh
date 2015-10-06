#!/bin/sh
date=`date +%Y-%m-%d`
dir="/root/backup.$HOSTNAME.$date"
echo -e Starting Backup script on $HOSTNAME
echo  
echo  
function mkdir_back {
if [ -d $dir ]; then
echo $dir folder exist, Delete?!
read -p "Are you sure? " -n 1 -r
echo 
if [[ $REPLY =~ ^[Yy]$ ]]
then
    rm -rf $dir; mkdir $dir
else
echo abort!
pkill -15 backup.sh
fi
else
echo "Creating $dir  folder ..DONE"
mkdir $dir
fi
}
 
 
function back_http  {
 
 if [ "$(pidof httpd)" ]; then
        echo Backing up /var/www/
        echo
        if [ -d /var/www ]; then
        cp -vrp /var/www $dir/www
        echo
        fi
else
        echo -e http not running, skipping..
fi
}
 
function back_mysql {
if [ "$(pidof mysqld)" ]; then
        echo Backing up /var/lib/mysql
        echo
        if [ -d /var/lib/mysql ] ; then
        cp -vrp /var/lib/mysql $dir/mysql
        echo 
        fi
else
echo  -e MySQL not running, skipping.
fi
}
 
function compress {
echo 
echo -e Compressing...
echo
echo
 
tar -cjvf $dir.tar.gz $dir
 
echo
echo Compressed Successfully!
echo
 
}
 
 
if [[ $EUID -ne 0 ]]; then
        echo -e You must be root to run this script
        echo
else
 
echo Running user checked! Proceed!
mkdir_back;
back_http;
back_mysql;
compress;
echo Done in $TIME
 
fi
