#!/bin/bash
#
#
#
view_routes(){
	echo "Current routing table : "
	ip route show
}


add_route(){
	local destination="$1"
	local gateway="$2"
	local interface="$3"

	if [[ -z "$destination" || -z "$gateway" || -z "$interface" ]] 
	then
		echo "Usage: add_route <destination> <gateway> <interface>"
		return 1
	fi

	echo "adding route to $destination via $gateway on $interface.."
	sudo ip route add "$destination" via "gateway" dev "$interface"
}

delete_route(){
	local destination="$1"
	local gateway="$2"
       	local interface="$3"

    if [[ -z "$destination" || -z "$gateway" || -z "$interface" ]]; then
        echo "Usage: delete_route <destination> <gateway> <interface>"
        return 1
    fi

    echo "Deleting route to $destination via $gateway on $interface..."
    sudo ip route del "$destination" via "$gateway" dev "$interface"
}

# Main menu
while true; do
    echo "Routing Table Manager"
    echo "1. View routing table"
    echo "2. Add route"
    echo "3. Delete route"
    echo "4. Exit"
    read -p "Choose an option [1-4]: " option

    case $option in
        1)
            view_routes
            ;;
        2)
            read -p "Enter destination (e.g., 192.168.1.0/24): " dest
            read -p "Enter gateway (e.g., 192.168.1.1): " gw
            read -p "Enter interface (e.g., eth0): " iface
            add_route "$dest" "$gw" "$iface"
            ;;
        3)
            read -p "Enter destination (e.g., 192.168.1.0/24): " dest
            read -p "Enter gateway (e.g., 192.168.1.1): " gw
            read -p "Enter interface (e.g., eth0): " iface
            delete_route "$dest" "$gw" "$iface"
            ;;
        4)
            echo "Exiting..."
            exit 0
            ;;
        *)
            echo "Invalid option. Please choose 1-4."
            ;;
    esac
done
