#!/bin/bash
#
#
#echo "enter the path from where you need to delete the file : "

for folder in $(find -type d)
do
	echo "the folder is $folder"
	if [ -d test ];
	then 
		echo "this folder exists"
		echo "removing the folder"
		rm -rf test
	else
		echo "test folder doesn't exists"
	fi
done
