#!/bin/bash
#
#using touch command create this file to the test 
#touch -a -m -t 202012180130.09 filename.txt -------> you are creating a file to test date=18-12-2020
##touch -a -m -t 202402180130.09 filename.txt 
#
#
echo "This scripts delete files which is older then 30 days...."
echo "provide the path from where you want to delete the files : "

#used for command line argument
#path=$1
#
#read input path for user
read path
echo " $path from here i deleted the files.."
#find the files mentioned in the path which older then 30 days and delete it.
find $path -mtime +30 -delete

if [ $? -eq 0 ]
then
	echo "files are successfully deleted...."
else
	echo " there is problem in deletion..."
fi
