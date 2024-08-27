#!/bin/bash
#
#
#
echo "Please provide IP ADDRESSES that needs to be added : "
read ip_addresses

echo "please provide the network interface.. eg:- eth0, enX0 etc.. :"
read interface

#add ip address to network interface
add_ip(){
	local ip=$1
	ip addr add "$ip/20" dev "$interface"
}

#ping the ip address that you have added and check for reachable
ping_ip(){
	local ip=$1
	echo "Pinging $ip ...."
	ping -c 3 "$ip"
	if [ $? -eq 0 ]
	then
		echo
		echo "$ip is reachable....."
	else
		echo
		echo "$ip is not reachable...."
	fi
}

#add every  ip add to network inteface that you have provide in input
for ip in ${ip_addresses[@]}
do
	add_ip $ip
done

#ping every ip addresses that you add now and check for reachable

for ip in ${ip_addresses[@]}
do
	ping_ip $ip
done

