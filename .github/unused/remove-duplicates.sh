#!/bin/bash

# Define path to hosts files
HOSTS_FILE1="HOSTS.txt"
HOSTS_FILE2="duplicates.txt"
TEMP_FILE=$(mktemp)

# Check if the files exists
if [ ! -f "$HOSTS_FILE1" ]; then
  echo "Error: $HOSTS_FILE1 does not exist."
  exit 1
fi

if [ ! -f "$HOSTS_FILE2" ]; then
  echo "Error: $HOSTS_FILE2 does not exist."
  exit 1
fi

# Delete same terms from the FILE1
grep -vxFf "$HOSTS_FILE2" "$HOSTS_FILE1" > "$TEMP_FILE" && mv "$TEMP_FILE" "$HOSTS_FILE1"

# Completed
echo "Completed: Duplicate entries removed from $HOSTS_FILE1."