#!/bin/bash
#
#
#
file_name=/root/test_dir


if [ -d $file_name ]
then
        echo "you have this directory $file_name"
        cd $file_name
        ls
else
        echo " you don't have this directory. please creat one if need"
fi
