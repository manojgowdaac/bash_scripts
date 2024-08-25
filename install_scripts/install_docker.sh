#!/bin/bash
#
#
echo "script to install DOCKER"
if [ "$(lsb_release -is)" == "Ubuntu" ]
then
	echo "Installation started......"
	echo " this is Ubuntu machine..."
	 apt update
	 echo
	 docker --version
	 # checing if docker is installed or not 
	  if [ $? -eq 0 ]
                then
                        echo
                        echo "************* DOCKER is already installed in your system *************"
                        echo
		else
			echo "now installing docker" 
			apt install -y docker.io
			echo " ###################### DOCKER INSTALLED ######################"
	  fi

	 echo "enabling docker service"
	 systemctl enable docker
	 echo
	 systemctl status docker
	 echo "docker installed Successfully!!!!......"
else
	echo " could not installed the DOCKER!!!!....."
fi




