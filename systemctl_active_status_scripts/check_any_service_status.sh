#!/bin/bash
#
#
#
echo " ***** checking for status check for the service ***** "
read -p "Enter the service name you want to check it's status : " service_name
if [ -z $service_name ]
then
	echo "Please enter the a valid service name "
else
	systemctl status $service_name
fi
