#!/bin/bash
#
#
#
echo "CPU load average value check"
load=$(top -bn1 | grep "load average" | awk '{printf "%.2f", $(NF-2)}')

echo $load
if [ ${load%.*} > 1 ]
then
	echo "CUP load is very high: $load"
else
	echo " Load is normal"
fi

#run this command on onther tab to see increase in load on CPU, because it will run in infinite loop
# cat /dev/zero > /dev/null 
