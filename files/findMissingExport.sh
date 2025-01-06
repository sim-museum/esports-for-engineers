#!/bin/bash

find . -type f -name "*.sh" -exec grep -l '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*=' {} \; | while read -r file; do
    echo "=== $file ==="
    grep -n '^[[:space:]]*[A-Za-z_][A-Za-z0-9_]*=' "$file" | grep -v '^[[:space:]]*export'
done

