#!/bin/bash

# Function to create a user
create_user() {
    local username=$1
    sudo adduser "$username"
    echo "User $username created successfully."
}

# Function to modify a user
modify_user() {
    local username=$1
    local action=$2
    case $action in
        new_username)
            local new_username=$3
            sudo usermod -l "$new_username" "$username"
            echo "Username changed to $new_username."
            ;;
        password)
            sudo passwd "$username"
            echo "Password updated for $username."
            ;;
        group)
            local group=$3
            sudo usermod -aG "$group" "$username"
            echo "User $username added to group $group."
            ;;
        *)
            echo "Invalid modification action."
            ;;
    esac
}

# Function to delete a user
delete_user() {
    local username=$1
    sudo deluser --remove-home "$username"
    echo "User $username deleted successfully."
}

# Process the input file
process_file() {
    local new_users_input_file=$1
    while IFS= read -r line; do
        # Skip empty lines and comments
        [[ -z "$line" || "$line" =~ ^# ]] && continue
        
        # Parse command and parameters
        local command=$(echo "$line" | awk '{print $1}')
        local username=$(echo "$line" | awk '{print $2}')
        
        case $command in
            create)
                create_user "$username"
                ;;
            modify)
                local action=$(echo "$line" | awk '{print $3}')
                modify_user "$username" "$action" $(echo "$line" | awk '{print $4}')
                ;;
            delete)
                delete_user "$username"
                ;;
            *)
                echo "Invalid command: $command"
                ;;
        esac
    done < "$new_users_input_file"
}

# Main execution
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 input_file.txt"
    exit 1
fi

new_users_input_file=$1
if [ ! -f "$new_users_input_file" ]; then
    echo "Input file does not exist."
    exit 1
fi

process_file "$new_users_input_file"

