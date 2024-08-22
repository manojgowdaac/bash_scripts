#!/bin/bash
#
#
file_name=/root/test_dir/abc.txt


echo "checking if you run $file_name"
if [ -f $file_name ]
then
	if [ -x  $file_name ]
	then
		echo
		echo "you can execute $file_name"
		
	else
		echo
		echo "you don't have access to execute $file_name"
	fi

else
	echo "file don't found"
fi
