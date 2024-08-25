#!/bin/bash
#
#
echo "script to install git"
echo "Installation started......"

#linux based 
if [ $(uname) == "Linux" ]
then
		echo "this is linux box, Installing git now!!!...."
		apt update
		echo
		apt install git
		#to check git is already install in System
		if [ $? -eq 0 ]
		then
			echo 
			echo "git is already installed ....."
			echo
		fi
		echo "---- this is the version of git ----"
		git --version
#for mac-os 	
elif [ $(uname) == "Darwin" ]
then 
	echo "this is not a Linux box!!!"
	echo "this is mac-os"
	brew install git
	echo
	git --version
else
	echo "not installed!!!!....."
fi
