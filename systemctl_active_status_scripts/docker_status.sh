#!/bin/bash
#
#
echo " ------------- status check docker service --------------- "
#status=$(systemctl status docker)
#status=$(systemctl status docker |awk 'NR==3 {print}')
#if you need in clean form 
status=" 'systemctl status docker | awk 'NR==3 {print}' | cut -d ':' -f 2 | cut -d '(' -f 1' "

echo "Docker service status:$status"

if [ $status = "active" ]
then 
	echo
	echo "************ service is up and running fine **********"
else
	echo
	echo "-----------------service is not running------------"
	echo " ************Enabling the docker service to run state **********"
	systemctl start docker
	echo 
	echo " --------- NOW SYSTEM IS RUNNING ------------"
fi

