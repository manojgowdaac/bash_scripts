#!/bin/bash
#
#
#
#backup_config_file=/root/scripts/imp_scripts/file_exits.sh
backup_config_file=/root/test_dir/abc.txt
backup_destination=/root/backup_dir
hourly_dir="$backup_destination/$( date +'%Y-%m-%d_%H%M' )"


backup_filename="backup_$(date +'%Y-%m-%d_%H%M%S')_tar.gz"

source_directory=/root/test_dir

if [ -f $backup_config_file ]
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
