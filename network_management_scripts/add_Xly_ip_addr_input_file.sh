#!/bin/bash
#
#
#

# Input file containing the list of IP addresses (one per line)
INPUT_FILE="ip_addresses.txt"

# Network interface to add IP addresses to (e.g., eth0, ens5, enX0 etc.)
echo "Provide nnetwork interface...(e.g., eth0, ens5, enX0 etc.)"
read interface

# Function to add an IP address to the network interface
add_ip() {
    local ip=$1
    sudo ip addr add "$ip/20" dev "$interface"
}

# Function to ping an IP address to check if it is reachable
ping_ip() {
    local ip=$1
    echo "Pinging $ip..."
    ping -c 3 "$ip"
    if [ $? -eq 0 ]; then
	echo
        echo "------ $ip is reachable -------"
    else
        echo "------ $ip is not reachable ------"
    fi
}

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Input file $INPUT_FILE not found!"
    exit 1
fi

# Read IP addresses from the input file and add them to the network interface
while IFS= read -r ip; do
    if [ -n "$ip" ]; then
        add_ip "$ip"
        ping_ip "$ip"
    fi
done < "$INPUT_FILE"

