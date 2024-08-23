#!/bin/bash
#
#lets creat a infintate loop that repeatedly gathers and displa system resource
while true
do
	clear

	echo "------- system resource monitoring --------"
	echo " *****************************************"
	echo

	#display CPU usage
	echo "CPU Usage: "
	echo
	#top
	# -n 1 number of flag to display a sigle iteration of CPU usage information
	top -n 1 -b | grep "cpu"
	# 3 iteration of CPU usage
	#top -n 3 -b | grep "cpu"

	#display memory usage
	echo
	echo -e "\nMemory Usage: "
	echo
	free -h

	#display disk space usage
	echo
	echo -e "\nDisk Space Usage: "
	df -Th
        
	#wait for 5 seconds before the next update
	sleep 5 
done
