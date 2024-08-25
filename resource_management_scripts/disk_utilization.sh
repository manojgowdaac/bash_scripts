#!/bin/bash
#
#
#
echo "check disk usage in Linux System...."
echo "enter the disk name that you want to check: "
read disk_name
disk_size=$(df -Th | grep "$disk_name" | awk '{print $6}' | cut -d '%' -f 1)

echo "$disk_size % of disk is filled..."

if [ "$disk_size" -gt 60 ]
then
	echo "disk is utilized more than 60%, expand disk or delete unused files soon!!!..."
else
	echo "enough disk is avaialable..."
fi
