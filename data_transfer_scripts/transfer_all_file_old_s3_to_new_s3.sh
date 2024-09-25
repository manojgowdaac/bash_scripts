#!/bin/bash
#
#
#
# Set variables
echo "Provide the s3 bucket source name : "
read Source_Bucket
echo
echo "provide the s3 bucket destination name : "
read Dest_Bucket
echo
echo "provide the file path where you need to store the output : "
read Log_File
#SOURCE_BUCKET="s3://manoj-server-side-1"
#DEST_BUCKET="s3://manoj-client-side-1"
#LOG_FILE="/root/test_dir/xyz.txt"

# Start the transfer and log the output
echo "Strating data transfer from $Source_Bucket to $Dest_Bucket " | tee -a $Log_File 
#echo "Starting data transfer from $SOURCE_BUCKET to $DEST_BUCKET" | tee -a $LOG_FILE
aws s3 sync $Source_Bucket $Dest_Bucket --exact-timestamps | tee -a Log_File
#aws s3 sync $SOURCE_BUCKET $DEST_BUCKET --exact-timestamps | tee -a $LOG_FILE

# Check for errors during the transfer
if [ $? -ne 0 ]; then
    echo "Data transfer failed!!!.... Check the log for details!!!..." | tee -a $Log_File
    exit 1
fi

# Verify the transfer
echo "--------- Verifying the data transfer!!! ------- " | tee -a $Log_File
Source_File=$(aws s3 ls $Source_Bucket --recursive --summarize | grep "Total Objects" | awk '{print $3}')
Dest_File=$(aws s3 ls $Dest_Bucket --recursive --summarize | grep "Total Objects" | awk '{print $3}')

Source_size=$(aws s3 ls $Source_Bucket --recursive --summarize | grep "Total Size" | awk '{print $3}')
Dest_size=$(aws s3 ls $Dest_Bucket --recursive --summarize | grep "Total Size" | awk '{print $s3}')


if [ "$Source_File" -eq "$Dest_File" ] && [ "$Source_File" -eq "$Dest_File" ]; then
    echo "Data transfer completed successfully!!!....." | tee -a $Log_File
    echo "Total Files: $Source_File" | tee -a $Log_File
    echo "Total Size: $Source_size bytes" | tee -a $Log_File
else
    echo "Data transfer verification failed!!!... Source and destination do not match." | tee -a $Log_File
    echo "Source Files: $Source_file, Destination Files: $Dest_File" | tee -a $Log_File
    echo "Source Size: $Source_size, Destination Size: $Dest_File" | tee -a $Log_File
    exit 1
fi

