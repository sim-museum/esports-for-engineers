# Script Outline:
# 1. Check if wine-development is already installed and up-to-date.
# 2. If wine-development is not the current version, install it along with required packages.
#!/bin/bash

# This script checks if wine-development is already installed and up-to-date.
# If wine-development is not the current version, it installs it along with required packages.

# Check if wine-development is already the current version
if wine --version | grep -q "wine-5.5"; then
    echo ""; echo "wine-development is already the current version of wine."; echo ""
    exit 0
fi

# Install wine-development and required packages
sudo apt install -y wine-development wine32-development winetricks 2>/dev/null 1>/dev/null

