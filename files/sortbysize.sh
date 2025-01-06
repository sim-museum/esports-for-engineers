#!/bin/bash

# Check if directory argument is provided
if [ $# -eq 0 ]; then
    DIR="."
else
    DIR="$1"
fi

# Find all files and sort by size
find "$DIR" -type f -exec ls -lh {} + | \
    sort -rh -k5 | \
    awk '{print $5 "\t" $9}'

