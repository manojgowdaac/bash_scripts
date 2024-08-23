#this is for who login 
#
#
#
#!/bin/bash

output_file="current_user_login_info.txt"


# Extract login names and UIDs from /etc/passwd and store them in the output file
awk -F: ' $3 > 999 {print "Login Name: " $1 ", UID: " $3}' /etc/passwd > $output_file

# Notify the user
echo "User login names and UIDs have been saved to $output_file."

