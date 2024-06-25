#!/bin/bash

# Check if a file path is provided
if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <hosts_file>"
    exit 1
fi

hosts_file=$1
temp_file=$(mktemp)

# Check if the file exists
if [ ! -f "$hosts_file" ]; then
    echo "File not found: $hosts_file"
    exit 1
fi

# Read the file and check each domain
while IFS= read -r line; do
    # Skip empty lines and comments
    if [[ -z "$line" || "$line" =~ ^# ]]; then
        echo "$line" >> "$temp_file"
        continue
    fi

    # Extract the domain name
    domain=$(echo "$line" | awk '{print $2}')

    # Check if the domain has DNS records
    if dig "$domain" +short | grep -q '[^[:space:]]'; then
        echo "$line" >> "$temp_file"
    else
        echo "Removing line: $line"
    fi
done < "$hosts_file"

# Replace the original file with the temporary file
mv "$temp_file" "$hosts_file"
