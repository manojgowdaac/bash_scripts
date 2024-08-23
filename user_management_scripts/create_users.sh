#!/bin/bash
#
#
user_file=/root/bash_scripts/user_management_scripts/users_list.txt
username=$( cat /root/bash_scripts/user_management_scripts/users_list.txt | tr 'A-Z' 'a-z' )
password=abc@123

for user in $username
do
	useradd $user
	#echo $password | passwd --stdin $user
	echo "$user:$password" 

done

echo "$(wc -l /root/bash_scripts/user_management_scripts/users_list.txt) users have been created"
tail -n$(wc -l /root/bash_scripts/user_management_scripts/users_list.txt) /etc/passwd

