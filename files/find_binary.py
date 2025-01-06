import os
import mimetypes
from collections import Counter

# Directory to scan
directory = '.'

# Counter for binary file suffixes
binary_suffixes = Counter()

# Walk through the directory tree
for root, _, files in os.walk(directory):
    for file in files:
        file_path = os.path.join(root, file)
        try:
            # Try to open the file in text mode
            with open(file_path, 'r', encoding='utf-8') as f:
                f.read()
        except (UnicodeDecodeError, IOError):
            # If it fails, consider it binary and record the suffix
            suffix = os.path.splitext(file)[1]
            if suffix:
                binary_suffixes[suffix] += 1

# Write binary suffixes to .gitignore
with open('.gitignore', 'a') as gitignore:
    for suffix in binary_suffixes:
        gitignore.write(f'*{suffix}\n')

