#!/bin/bash
#
#
#file back up location
#backup_config_file=/root/test_dir/abc.txt
echo "Please provide the file path that you need to have back-up :"
read backup_config_file
#
#backup directory location
#backup_config_file=/root/test_dir
#echo "please provide the direcotry path that you need to have back-up : "
#read backup_config_file

#destination location to store the file and directory
#backup_destination=/root/backup_dir
echo
echo "Provie the destination path where you to need to store the back-up file : "
read backup_destination
hourly_dir="$backup_destination/$( date +'%Y-%m-%d_%H%M' )"

backup_filename="backup_$(date +'%Y-%m-%d_%H%M%S')_tar.gz"

#source_directory=/root/test_dir
#source_directory=/root
source_directory=/etc

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

#for every hour backup creat a new directory so the accessing of data can be easier
mkdir -p $hourly_dir

source $backup_config_file

tar -czf  "$hourly_dir/$backup_filename" "$source_directory" 2>/dev/null

#checking backup is successfull or not
if [ $? -eq 0 ]
then
	echo " backup completed successfull"
else
	echo " backup failed"
	exit 1
fi

#to take backup every hour set cronjob 
# * 1 * * * /root/bash_scripts/backup_scripts/Daily_backup.sh 
