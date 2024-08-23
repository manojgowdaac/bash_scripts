#!/bin/bash


search_string="old_string"
replace_string="new_string"
file_dir=/root/test_dir


find $file_dir -type f -exec sed -i "s/$search_string/$replace_string/g" {} +

echo "find and repalce complete!"
