#!/bin/bash
#This script for CSMC Roll-Out for Linux Box
#Written by mymzbe - 10th May 2014 - GLUX
#Email:muhammad.zali@t-systems.com
##Version 1.0##
#First working version
##Version 2.0## - 13th May 2014
#Added function block for better code building and maintenance
#Added failsafe features for config files
#Added user check boolean
#Using variables for csmc gateway IP

################################# VARIABLES START ######################################

ASIAPACDOM="@"
AMERICASDOM="@"
EUROPEDOM="@"
AFRICAMEDOM="@"

################################# FUNCTIONS START ######################################

. /etc/rc.d/init.d/functions


function releaseCheck () {


VERSION=`cat /etc/redhat-release | cut -d" " -f1|cut -d"." -f1`

if [[ $VERSION != "rhel5" ]]
        then
        echo "Version $VERSION not compatible: Not Continue"
        exit 1
fi

}

function disclaimerNote () {

echo
echo "Make sure you understand below statements/rules correctly:"
echo
echo -e "1. Prior to the script execution, make sure all config files transferred to the same directory with this script."
echo -e "2. Compare CSMC Gateway IP in this script (in VARIABLES segment) with what is provided in the change in case its different."
echo -e "3. \033[01;31mROOT USER\033[00;00m: With Great Power Comes Great Responsibility."
echo -e "4. Ask if you feel unsure!"
echo -e "5. Do the right thing. It will gratify some people and astonish the rest."
echo

}


function inputCheck () {

if [[ $* -eq 0 ]]
then
echo "Usage : $0 -h for help"
exit 1
fi

}





function inputVerify () {
echo "++++ VERIFYING CONFIG FILES PRESENCE ++++"
echo
if [[ -z $AUDISPD ]]
 then
 echo "Missing -a input : EXITING"      $(failure)
 echo "For usage: $0 -h for help"
 exit 1
                elif [[ -z $PLUGSYSLOG ]]
                then
                echo "-p missing input : EXITING"       $(failure)
                echo "For usage: $0 -h for help"
                exit 1
                        elif [[ -z $AUDITD ]]
                        then
                        echo "-d missing input : EXITING"       $(failure)
                        echo "For usage: $0 -h for help"
                        exit 1
                                elif [[ -z $AUDITRULES ]]
                                then
                                echo "-r missing input : EXITING"       $(failure)
                                echo "For usage: $0 -h for help"
                                exit 1
fi
}


function preBackup () {
echo "++++ PRE-INSTALLATION BACKUP ++++"

cp -p /etc/audisp/audispd.conf /etc/audisp/audispd.conf.bak-CSMC-`hostname`-`date +%H-%M-%S`
if  [ $? == 0 ]
then
echo "Making backup for /etc/audisp/audispd.conf  ..."  $(success)
else
echo "Failed to backup  /etc/audisp/audispd.conf!"              $(failure)
exit 1
fi

cp -p /etc/audisp/plugins.d/syslog.conf /etc/audisp/plugins.d/syslog.conf.bak-CSMC-`hostname`-`date +%H-%M-%S`
if  [ $? == 0 ]
then
echo "Making backup for /etc/audisp/plugins.d/syslog.conf ..."          $(success)
else
echo "Failed to backup /etc/audisp/plugins.d/syslog.conf!"              $(failure)
exit 1
fi

cp -p /etc/audit/auditd.conf /etc/audit/auditd.conf.bak-CSMC-`hostname`-`date +%H-%M-%S`
if  [ $? == 0 ]
then
echo "Making backup for /etc/audit/auditd.conf  ..."           $(success)
else
echo "Failed to backup /etc/audit/auditd.conf!"          $(failure)
exit 1
fi


cp -p /etc/audit/audit.rules /etc/audit/audit.rules.bak-CSMC-`hostname`-`date +%H-%M-%S`
if  [ $? == 0 ]
then
echo "Making backup for /etc/audit/audit.rules  ..."           $(success)
else
echo "Failed to backup /etc/audit/audit.rules!"          $(failure)
exit 1
fi


cp -p /etc/syslog.conf /etc/syslog.conf.bak-CSMC-`hostname`-`date +%H-%M-%S`
if  [ $? == 0 ]
then
echo "Making backup for /etc/syslog.conf  ..."           $(success)
else
echo "Failed to backup /etc/syslog.conf!"          $(failure)
exit 1
fi


if [ ! -f /etc/syslog.conf.orig ]
then
cp -p /etc/syslog.conf /etc/syslog.conf.orig
fi

}



function packageInstall () {
echo
echo "++++ PACKAGES INSTALLATION ++++"
rpm -qa|grep "audit-1.8" > /dev/null 2>&1
if  [ $? -gt 0 ]
then
yum install -y audispd-plugins
else
echo "audispd-plugins package already installed. Skipping ..."  $(success)
fi

rpm -qa|grep "psacct" > /dev/null 2>&1
if  [ $? -gt 0 ]
then
yum install -y psacct
else
echo "psacct package already installed. Skipping ..."  $(success)
fi

chkconfig psacct on
if [ $? -gt 0 ]
then
echo "Unable to make psacct to run on boot, check later. Non-fatal, continue ..." $(success)
fi

}


function preconfigBackup () {

echo
echo "++++ PRE-CONFIG BACKUP ++++"
cp -p /etc/audisp/audispd.conf /etc/audisp/audispd.conf_orig_`hostname`-`date +%H-%M-%S`
cp -p /etc/audisp/plugins.d/syslog.conf /etc/audisp/plugins.d/syslog.conf_orig_`hostname`-`date +%H-%M-%S`
cp -p /etc/audit/auditd.conf /etc/audit/auditd.conf_orig_`hostname`-`date +%H-%M-%S`
cp -p /etc/audit/audit.rules /etc/audit/audit.rules_orig_`hostname`-`date +%H-%M-%S`
echo "Backup done ..." $(success)
}

function postConfig () {
echo
echo "++++ DEPLOYING CONFIGURATION FILES ++++ "
cat $AUDISPD > /etc/audisp/audispd.conf
        if [ $? -eq 0 ]
        then
        echo "Deploying /etc/audisp/audispd.conf ..." $(success)
        else
        echo "Exiting, please verify again, failed execute copy source file to /etc/audisp/audispd.conf ..." $(failure)
        exit 1
        fi


cat $PLUGSYSLOG > /etc/audisp/plugins.d/syslog.conf
        if [ $? -eq 0 ]
        then
        echo "Deploying /etc/audisp/plugins.d/syslog.conf ..." $(success)
        else
        echo "Exiting, please verify again, failed execute copy source file to /etc/audisp/plugins.d/syslog.conf ..." $(failure)
        exit 1
        fi


cat $AUDITD > /etc/audit/auditd.conf
        if [ $? -eq 0 ]
        then
        echo "Deploying /etc/audit/auditd.conf ..." $(success)
        else
        echo "Exiting, please verify again, failed execute copy source file to /etc/audit/auditd.conf ..."
        exit 1
        fi




cat $AUDITRULES > /etc/audit/audit.rules
        if [ $? -eq 0 ]
        then
        echo "Deploying /etc/audit/audit.rules ..." $(success)
        else
        echo "Exiting, please verify again, failed execute copy source file to /etc/audit/audit.rules ..." $(failure)
        exit 1
        fi
}


function gatewaySyslog () {

echo
echo "++++ CONFIGURING SYSLOG CSMC GATEWAY ++++"

#Make sure original file restored if this script is re-run
cp -p /etc/syslog.conf.orig /etc/syslog.conf

NAME=`hostname`
DOMAIN=`nslookup $NAME  | grep Name | cut -d"." -f2`



echo >> /etc/syslog.conf
echo "# Send a copy to CSMC Syslog Daemon" >> /etc/syslog.conf


if [[ $DOMAIN == "asia-pac" ]]
then

echo "auth,authpriv.info;user,local4.debug                                      $ASIAPACDOM" >> /etc/syslog.conf
        if [ $? == 0 ]
        then
        echo "Server is in $DOMAIN domain. Updating /etc/syslog.conf"   $(success)
        else
        echo "Unable to update /etc/syslog.conf. Fatal Error!" $(failure)
        exit 1
        fi
fi


if [[ $DOMAIN == "americas" ]]
then

echo "auth,authpriv.info;user,local4.debug                                $AMERICASDOM" >> /etc/syslog.conf
        if [ $? == 0 ]
        then
        echo "Server is in $DOMAIN domain. Updating /etc/syslog.conf"   $(success)
        else
        echo "Unable to update /etc/syslog.conf. Fatal Error!" $(failure)
        exit 1
        fi
fi


if [[ $DOMAIN == "africa-me" ]]
then

echo "auth,authpriv.info;user,local4.debug                                $AFRICAMEDOM" >> /etc/syslog.conf
        if [ $? == 0 ]
        then
        echo "Server is in $DOMAIN domain. Updating /etc/syslog.conf"   $(success)
        else
        echo "Unable to update /etc/syslog.conf. Fatal Error!" $(failure)
        exit 1
        fi
fi



if [[ $DOMAIN == "europe" ]]
then
echo Server is in $DOMAIN domain.
echo "auth,authpriv.info;user,local4.debug                                      $EUROPEDOM" >> /etc/syslog.conf
        if [ $? == 0 ]
        then
        echo "Server is in $DOMAIN domain. Updating /etc/syslog.conf"   $(success)
        else
        echo "Unable to update /etc/syslog.conf. Fatal Error!" $(failure)
        exit 1
        fi
fi

}

function restartDaemon () {

echo
echo "++++ RESTARTING AUDITD & SYSLOG ++++"
service auditd restart
if [ $? -gt 0 ]
then
echo "Unable to restart auditd, please verify and re-run - EXITING"
exit 1
fi

service syslog restart
if [ $? -gt 0 ]
then
echo "Unable to restart syslog, please verify and re-run - EXITING"
exit 1
fi

}

function verifyDaemon () {

echo
echo "++++ VERIFYING AUDITD AND SYSLOG SERVICE ++++"
AUDITDPID=`pidof auditd`
SYSLOGPID=`pidof syslogd`

if [[ $AUDITDPID -gt 0 ]]
then
echo "auditd is running: PID $AUDITDPID"  $(success)
else
echo "auditd not running, please verify"  $(failure)
fi

if [[ $SYSLOGPID -gt 0 ]]
then
echo "syslog is running: PID $SYSLOGPID" $(success)
else
echo "syslog not running, please verify" $(failure)
fi

}


function  footNote() {

echo
echo
echo -e "\e[44mFor testing purpose you may use tcpdump :\033[00;00m"
echo -e "\e[44mtcpdump dst host ip_of_csmc_gateway\033[00;00m"
echo -e "\e[44mYou will see packet is sent to csmc once someone is logging in using root\033[00;00m"
echo
echo

}
############################# SCRIPT EXECUTE STARTS HERE ######################################


if [[ $EUID -eq 0 ]];
then

echo 
echo -e "Running as Super User"
#Disclaimer Note
#disclaimerNote

#read -p "Agree and want to continue (yes/no)? " ANSWER
#if [[ $ANSWER == "yes" ]]
#then

#RHEL Version Verification - RHEL5 Only Allowed
releaseCheck

#Check if no flag input provided
#inputCheck

#Getting file input
while getopts ":ha:p:d:r:" OPTION; do

        case $OPTION in
        "h")
                echo "Usage : $0
                 -h : print this help
                 -a : audispd.conf file
                 -p : syslog.conf for plugins.d file
                 -d : auditd.conf file
                 -r : audit.rules file
                 eg: ./csmc.sh -a <audispd.conf_filename> -p <syslog.conf_filename> -d <auditd.conf_filename> -r <audit.rules_filename>"
                exit 0
                ;;
        "a")
                AUDISPD=${OPTARG}
                ;;
        "p")
                PLUGSYSLOG=${OPTARG}
                ;;
        "d")
                AUDITD=${OPTARG}
                ;;
        "r")
                AUDITRULES=${OPTARG}
                ;;

        ?)
                echo "Check your input again." $(failure)
                                echo "Run $0 -h for help"
                exit 1
                ;;
        esac
done

#Checking input files existance
inputVerify

#Pre-Installation Backup
preBackup

#Installation procedure
packageInstall

#PRE-CONFIG Backup
preconfigBackup

#POST Installation Configuration
postConfig

#Syslog CSMC Gateway Server Config based on region.
gatewaySyslog

#Restarting and verifying auditd and syslog services
restartDaemon

#Verify daemon
verifyDaemon

#Just a footnote
footNote


#elif [[ $ANSWER == "no" ]]
#then
#echo
#echo "Terminated!"
#exit 1
#else
#echo "Please answer yes or no"
#fi

else
echo "Run this script as root" $(failure)
fi

echo   "Script Finished."


############################# SCRIPT EXECUTE ENDS HERE ######################################

