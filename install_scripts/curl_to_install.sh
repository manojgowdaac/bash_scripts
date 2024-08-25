#!/bin/bash
#
#
#URL="https://github.com/manojgowdaac/python"
echo "Enter the website URL to curl :"
read URL
response=$(curl -s -w "%{http_code}" $URL)

#get the last line
httpl_code=$(tail -n1 <<< "$response") 

#get all but the last line which contains the status code
content=$(sed '$ d' <<< "$response")

echo "$httpl_code"
if [ $httpl_code == 200 ]
then
	echo "Request is working fine"
else
	echo "send slack message that request is denied"
fi
#if we want to store the result in a file instead of displaying on screen '/path to store/filename'
#fi>/root/output_curl.txt
