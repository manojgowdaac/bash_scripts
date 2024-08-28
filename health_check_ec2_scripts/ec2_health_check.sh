#!/bin/bash
#
#
#
#Define instance id
#Instance_id="i-08985687ddd"
echo
echo "Please provide the instance id to check the health status: "
read Instance_id
#aws region
#Region="ap-southeast-2"
echo
echo "Provide the EC2 instance region where it is locatated: "
read Region

#fetch instance status
instance_status=$(aws ec2 describe-instance-status --instance-ids "$Instance_id" --region "$Region" --query "InstanceStatuses[0].InstanceState.Name" --output text)

#fetch system status
system_status=$(aws ec2 describe-instance-status --instance-ids "$Instance_id" --region "$Region" --query "InstanceStatuses[0].InstanceStatus.Status" --output text)

#fetch instance health
instance_health=$(aws ec2 describe-instance-status --instance-ids "$Instance_id" --region "$Region" --query "InstanceStatuses[0].SystemStatus.Status" --output text)

#check if the instance is running and healthy
if [ "$instance_status" == "running" ] && [ "$system_status" == "ok" ] && [ "$instance_health" == "ok" ]
then
	echo "Instance $Instance_id is healthy...."
else
	echo "Instance $Instance_id is not healthy!!..."
	echo "Instance status: $instance_status"
	echo "System status: $system_status"
	echo "Instance health: $instance_health"
fi
