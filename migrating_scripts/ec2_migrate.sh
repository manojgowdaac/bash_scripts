#!/bin/bash
# 
echo 
echo "Provide the current region of EC2 Instance : "
read Source_Region
echo
echo "Provide the new region for EC2 Instance where you need to migrate : "
read Destination_Region
echo
echo "Provide EC2 instance id : "
read Instance_id
echo
echo "provide name for AMI as per you required : "
read ami_name
echo
echo "add Description : "
read Description
echo
echo "provide the KEY-PAIR name :"
read key_pair

# Create AMI of the source instance
echo "Creating AMI of instance $Instance_id in region $Source_Region..."
aws ec2 create-image --region $Source_Region --instance-id $Instance_id --name "$ami_name" --description "$Description" --no-reboot

# Wait for AMI creation to complete
echo "Waiting for AMI to be available..."
AMI_ID=$(aws ec2 describe-images --region $Source_Region --filters "Name=name,Values=$ami_name" --query "Images[0].ImageId" --output text)
while [ "$(aws ec2 describe-images --region $Source_Region --image-ids $AMI_ID --query "Images[0].State" --output text)" != "available" ]; do
    sleep 30
    echo "AMI is not yet available. Checking again..."
done
echo "AMI $AMI_ID is now available."

# Copy AMI to destination region
echo "Copying AMI to region $Destination_Region..."
aws ec2 copy-image --source-region $Source_Region --source-image-id $AMI_ID --region $Destination_Region --name "$ami_name" --description "$Description"

# Wait for copied AMI to be available
echo "Waiting for copied AMI to be available in destination region..."
COPY_AMI_ID=$(aws ec2 describe-images --region $Destination_Region --filters "Name=name,Values=$ami_name" --query "Images[0].ImageId" --output text)
while [ "$(aws ec2 describe-images --region $Destination_Region --image-ids $COPY_AMI_ID --query "Images[0].State" --output text)" != "available" ]; do
    sleep 30
    echo "Copied AMI is not yet available. Checking again..."
done
echo "Copied AMI $COPY_AMI_ID is now available."

# Launch new instance from copied AMI
echo "Launching new instance from AMI $COPY_AMI_ID in region $Destination_Region..."
aws ec2 run-instances --region $Destination_Region --image-id $COPY_AMI_ID --count 1 --instance-type t2.micro --key-name $key_pair

if [ $? -eq 0 ]
then
	echo
	echo "Migration process completed...EC2 instance in $Destination_Region "
else
	echo
	echo "ERROR!! during creation of EC2 instnace in $Destination_Region"
fi

