#!/bin/bash
#
#
#
# Set variables
echo "Provide the file path that you need to add to s3 bucket : "
read File_path
#File_path="/root/test_dir/manoj.txt"    # Path to the file you want to upload
echo
echo "provide the S3 BUCKET name where you need to store the file : "
read Bucket_name
#Bucket_name="manoj-server-side-1"    # Name of the S3 bucket
echo
echo "provide the path where you need to store the file in S3 :"
read Dest_path
#Desy_path="main-folder/manoj.txt"    # Path in the bucket where the file will be stored
echo
echo "provide the path for log file, where you need to store :"
read Log_file
#Log_file="/root/test_dir/xyz.txt"          # Log file for tracking the upload process

# Start the upload and log the output
echo "Starting upload of $File_path to s3://$Bucket_name/$Dest_path" | tee -a $Log_file
aws s3 cp "$File_path" "s3://$Bucket_name/$Dest_path" | tee -a $Log_file

# Check for errors during the upload
if [ $? -ne 0 ]; then
    echo "Upload failed. Check the log for details." | tee -a $Log_file
    exit 1
fi

# Confirm the upload
if [ $? -eq 0 ]
then
	echo "Upload successful!!!... File $File_path is now in s3://$Bucket_name/$Dest_path" | tee -a $Log_file
else
        echo "Upload is failed!!!...File $File_path is now in s3://$Bucket_name/$Dest_path" | tee -a $Log_file
fi

