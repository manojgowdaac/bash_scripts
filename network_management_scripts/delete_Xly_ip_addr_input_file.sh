#!/bin/bash
#
#
#

# Input file containing the list of IP addresses to delete
INPUT_FILE="ip_addresses.txt"

# Network interface to delete IP addresses from (e.g., eth0, ens5, enX0 etc.)
echo "provide network interface .... (e.g., eth0, ens5, enX0 etc.) : "
read interface

# Check if the input file exists
if [ ! -f "$INPUT_FILE" ]; then
    echo "Input file not found: $INPUT_FILE"
    exit 1
fi

# Function to delete an IP address from the network interface
delete_ip() {
    local ip=$1
    sudo ip addr del "$ip/20" dev "$interface"
}

# Read IP addresses from the input file and delete them
while IFS= read -r ip; do
    if [[ ! -z "$ip" ]]; then
        delete_ip "$ip"
        if [ $? -eq 0 ]; then
            echo "$ip has been deleted from $interface"
        else
            echo "Failed to delete $ip from $interface"
        fi
    fi
done < "$INPUT_FILE"

