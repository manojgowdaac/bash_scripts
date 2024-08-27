#!/bin/bash
#
#
#
echo "Provide IP ADDRESSES that need to be deleted : "
read ip_addresses

echo "Provide network interface.. eg: eth0, ens5, enX0 etc.."
read interface

delete_ip(){
	local ip=$1
	ip addr del $ip/20 dev $interface
}

for ip in ${ip_addresses[@]}
do
	delete_ip $ip
	if [ $? -eq 0 ]
	then
		echo
		echo "$ip has been deleted from $interface"
	else
		echo "Failed to delete $ip from $interface"
	fi
done

