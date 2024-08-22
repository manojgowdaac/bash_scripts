#!/bin/bash
#
#
#

file_name=/root/test_dir/abc.txt


if [ -e $file_name ]
then
	echo
	echo " file exist $file_name"

else
	echo 
	echo "file not found"
fi
