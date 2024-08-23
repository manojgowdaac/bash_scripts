#!/bin/bash
#this is command substitution variable example
#

testing=$(date)
echo "this is the date and time info:" $testing

user_id=$(echo "$UID")
echo "this is the user id number:" $user_id
