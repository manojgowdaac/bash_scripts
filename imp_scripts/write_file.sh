#!/bin/bash
#
#
file_name=/root/test_dir/manoj.txt

if [ -f $file_name ]
then
	if [ -w $file_name ]
	then
		echo " write current time to $ file_name"
		date +%H%M >> $file_name

	else
		echo " file $file_name doesn't have write access"
	fi

else
	echo " file $file_name doesn't found"
fi



