#!/bin/bash

# Function to create a new user
create_user() {
    read -p "Enter username to create: " username
    sudo adduser "$username"
    echo "User $username created successfully."
}

# Function to modify a user
modify_user() {
    read -p "Enter username to modify: " username
    echo "Choose an option to modify:"
    echo "1. Change user name"
    echo "2. Change user password"
    echo "3. Add user to group"
    read -p "Enter option [1-3]: " option
    
    case $option in
        1)
            read -p "Enter new username: " new_username
            sudo usermod -l "$new_username" "$username"
            echo "Username changed to $new_username."
            ;;
        2)
            sudo passwd "$username"
            echo "Password updated for $username."
            ;;
        3)
            read -p "Enter group name to add user to: " group
            sudo usermod -aG "$group" "$username"
            echo "User $username added to group $group."
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
}

# Function to delete a user
delete_user() {
    read -p "Enter username to delete: " username
    sudo deluser --remove-home "$username"
    echo "User $username deleted successfully."
}

# Main menu
while true; do
    echo "User Management Script"
    echo "1. Create new user"
    echo "2. Modify existing user"
    echo "3. Delete user"
    echo "4. Exit"
    read -p "Enter option [1-4]: " option
    
    case $option in
        1)
            create_user
            ;;
        2)
            modify_user
            ;;
        3)
            delete_user
            ;;
        4)
            echo "Exiting script."
            exit 0
            ;;
        *)
            echo "Invalid option."
            ;;
    esac
done

