#!/bin/bash

# Variables
SOURCE_INSTANCE_USER="root" # Replace with the username on the source instance
SOURCE_INSTANCE_IP="172.31.1.133" # Replace with the source instance's IP address
SOURCE_PATH="/root/test_dir" # Path to the directory or file on the source instance

DEST_INSTANCE_USER="root" # Replace with the username on the destination instance
DEST_INSTANCE_IP="172.31.8.197" # Replace with the destination instance's IP address
DEST_PATH="/root" # Path to the directory on the destination instance

# Transfer the data
#scp -i /root/.ssh -r "${SOURCE_INSTANCE_USER}@${SOURCE_INSTANCE_IP}:${SOURCE_PATH}" "${DEST_INSTANCE_USER}@${DEST_INSTANCE_IP}:${DEST_PATH}"

# Alternatively, if the script is running on the source instance, you can transfer directly to the destination instance:
 scp -i /root/.ssh -r "${SOURCE_PATH}" "${DEST_INSTANCE_USER}@${DEST_INSTANCE_IP}:${DEST_PATH}"

 if [ $? -eq 0  ]
 then
	 echo "Data transfer complete."
 else
	 echo "Data not transfer complete."
 fi



