#!/bin/bash

file_name=/root/test_dir/manoj.txt

if [ -f $file_name ]
then
	if [ -s $file_name ]
	then 
		echo "the $file_name file exist and has data in it"
		echo
		echo "don't delete this file $file_name"

	else
		echo "$file_name exit but it is empty"
		echo
		echo " you can delete this file $file_name"
		rm $file_name
	fi

else
	echo "$file_name doesn't found"
fi
