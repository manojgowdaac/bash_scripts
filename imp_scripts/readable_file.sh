#!/bin/bash
#
#
file_name=/root/test_dir/abc.txt


if [ -f $file_name ]
then
	if [ -r $file_name ]
	then
		echo
		echo " you can read the file $file_name"

	else
		echo
		echo "you dont have access to read this file $file_name"
	fi
else
	echo
	echo " file not found"
fi

