#this script is to check multiple ip address are working or not
#
#
#!/bin/bash

check_connectivity(){
	machine=$1
	echo "ping machine....."
	ping -c 3 $machine

	#check the exit status of ping command
	if [ $? -eq 0 ]
	then
		echo " $machine is reachable and working properly... you can connect!!..."
	else
		echo " $machine is not reachable... please check the ip address"
	fi
}

#main script
echo "please provide the file that  contains the list of ip's to check them: "
read ip_input_file

#check if the ip file exits

if [ ! -f $ip_input_file ]
then 
	echo " input file not found, exiting the script...."
	exit 1
fi

# read ip address from fiile that provided and check for the connection
#
while IFS= read -r machine_ip
do
	check_connectivity $machine_ip
done<"$ip_input_file"

# in command line provide the file name: ip_input_file.txt this file contains the multiple ip address in it..
