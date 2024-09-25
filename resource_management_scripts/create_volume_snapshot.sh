#!/bin/bash
#
#
#user for input
read -p "Enter the EC2 instance ID: " Instance_id
read -p "Enter the EC2 instance region: " Region

#validate inputs
if [ -z "$Instance_id" ] || [ -z "$Region" ]; then
    echo "Instance ID and region must be provided."
    exit 1
fi

#snapshot description
sanpshot_description="Snapshot created on $(date)"

#volume IDs associated with the instance
VOLUME_IDS=$(aws ec2 describe-instances \
	--instance-ids "$Instance_id" \
    --region "$Region" \
    --query 'Reservations[*].Instances[*].BlockDeviceMappings[*].Ebs.VolumeId' \
    --output text)

if [ -z "$VOLUME_IDS" ]; then
    echo "No volumes found for instance $Insatance_id."
    exit 1
fi

# Create snapshots for each volume
for VOLUME_ID in $VOLUME_IDS; do
    SNAPSHOT_ID=$(aws ec2 create-snapshot \
        --volume-id "$VOLUME_ID" \
        --description "$sanpshot_description" \
        --region "$Region" \
        --query 'SnapshotId' \
        --output text)

    echo "Created snapshot $SNAPSHOT_ID for volume $VOLUME_ID."
done
if [ $? -eq 0 ]
then
	echo
	echo "All snapshots created successfully."
else
	echo
	echo "Got problem while creating the snapshot"
fi

