#!/bin/bash
#
#
# region the currect instance is running
Source_region="ap-southeast-2"

# Replace with your EC2 instance ID
Instance_id="i-08985687ddd388939"

# Path to your replication script
Replication_script="/root/bash_scripts/migrating_scripts/ec2_migrate.sh"

# Check instance status
INSTANCE_STATUS=$(aws ec2 describe-instance-status --instance-ids $Instance_id --region $Source_region --query "InstanceStatuses[0].InstanceState.Name" --output text)

if [ "$INSTANCE_STATUS" != "running" ]; then
    echo "Instance $Instance_region is down. Triggering replication..."
    bash $Replication_script
else
    echo "Instance $Instance_id is running."
fi

