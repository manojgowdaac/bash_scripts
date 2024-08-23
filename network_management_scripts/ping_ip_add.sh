#this script is to ping the ip address and check they are working properly.
#!/bin/bash

#when have few machine to check we can you this script
if [ $# -eq 0 ]
then
	echo "usage: $0 <machine1> <machine2> ......"
	exit 1
fi

for machine in $@
do
	echo "ping $machine ...."
	#ping the machine 3 times
	ping -c 3 $machine
	echo "..............."
done
