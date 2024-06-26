#!/bin/bash

# File names
INPUT_FILE="HOSTS.txt"
OUTPUT_FILE="reachable_domains.txt"

# Clear the output file
> $OUTPUT_FILE

# Read each line from the input file
while IFS= read -r line; do
    # Skip empty lines and comment lines
    [[ -z "$line" || "$line" =~ ^# ]] && continue
    
    # Extract the domain (assuming the domain is the second field)
    domain=$(echo "$line" | awk '{print $2}')
    
    # Check HTTP access
    if curl --silent --head --fail "http://$domain" > /dev/null; then
        echo "http://$domain is reachable"
        echo "$line" >> $OUTPUT_FILE
    # Check HTTPS access
    elif curl --silent --head --fail "https://$domain" > /dev/null; then
        echo "https://$domain is reachable"
        echo "$line" >> $OUTPUT_FILE
    else
        echo "$domain is not reachable"
    fi
done < "$INPUT_FILE"

echo "Reachable domains have been saved to $OUTPUT_FILE"
