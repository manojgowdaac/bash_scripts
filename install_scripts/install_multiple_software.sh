#!/bin/bash
#
#
#
if [ $# -eq 0 ]
then
	echo " usage: please provide softwares name as command line arguments"
	exit 1
fi

#only root can install software
if [ $(id -u) -ne 0 ]
then
	echo " please run from root user or with sudo privilage"
	exit 2
fi

for software in $@
do
	if which $software &> /dev/null
	then
		echo " already $software is installed"
	else
		echo "Installing $software....."
		apt install -y $software &> /dev/null
		if [ $? -eq 0 ]
		then
			echo "successfully installed $software packages"
		else
			echo " unable to install $software"
		fi
	fi
done
