#!/bin/bash
#
#
#file back up location
backup_config_file=/root/bash_scripts/backup_scripts/xyz.txt
#backup_config_file=/root/test_dir/abc.txt
#
#backup directory location
#backup_config_file=/root/test_dir

#destination location to store the file and directory
backup_destination=/root/backup_dir
hourly_dir="$backup_destination/$( date +'%Y-%m-%d_%H%M' )"

backup_filename="backup_$(date +'%Y-%m-%d_%H%M%S')_tar.gz"

#source_directory=/root/test_dir
source_directory=/root

#back up for file
if [ -f $backup_config_file ]

#backup for directory
#if [ -d $backup_config_file ]
#
then
	echo " backup config file found processing with backup"
else
	echo " file not found"
	exit 1
fi

mkdir -p $hourly_dir

source $backup_config_file

tar -czf  "$hourly_dir/$backup_filename" "$source_directory" 2>/dev/null

if [ $? -eq 0 ]
then
	echo " backup completed succesfull"
else
	echo " backup failed"
	exit 1
fi
