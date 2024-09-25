#!/bin/bash

# Set variables
#echo 
#echo "provide the source S3 BUCKET NAME that you need to tansfer the file : "
#read SOURCE_BUCKET
SOURCE_BUCKET="s3://main-server-at-sydney"
#echo
#echo "provide the destination S3 BUCKET NAME where you need to store the file : "
#read DEST_BUCKET
DEST_BUCKET="s3://disaster-recovery-server-mumbai"
LOG_FILE="/root/test_dir/add_s3.log"

# List of files to transfer (provide the paths relative to the bucket root)
#echo
#echo "provide the file path to transfer :"
#read FILES_TO_TRANSFER
FILES_TO_TRANSFER=(
     "main-folder/manoj.txt"
#    "path/to/file2.csv"
#   "path/to/another/file3.json"
)

# Start the transfer and log the output
echo "Starting selective data transfer from $SOURCE_BUCKET to $DEST_BUCKET" | tee -a $LOG_FILE

for file in "${FILES_TO_TRANSFER[@]}"; do
    echo "Transferring $file" | tee -a $LOG_FILE
    aws s3 cp "$SOURCE_BUCKET/$file" "$DEST_BUCKET/$file" | tee -a $LOG_FILE
    
    # Check for errors during the transfer
    if [ $? -ne 0 ]; then
        echo "Data transfer failed for $file. Check the log for details." | tee -a $LOG_FILE
        exit 1
    fi
done

# Verify the transfer
echo "Verifying the data transfer..." | tee -a $LOG_FILE
for file in "${FILES_TO_TRANSFER[@]}"; do
    SOURCE_SIZE=$(aws s3 ls "$SOURCE_BUCKET/$file" | awk '{print $3}')
    DEST_SIZE=$(aws s3 ls "$DEST_BUCKET/$file" | awk '{print $3}')
    
    if [ "$SOURCE_SIZE" -eq "$DEST_SIZE" ]; then
        echo "Verification successful for $file." | tee -a $LOG_FILE
    else
        echo "Verification failed for $file. Source and destination sizes do not match." | tee -a $LOG_FILE
        exit 1
    fi
done

echo "Selective data transfer completed successfully." | tee -a $LOG_FILE

