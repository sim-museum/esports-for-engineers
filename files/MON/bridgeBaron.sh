#!/bin/bash

# This script launches Bridge Baron 29 under Wine, assuming Wine is properly configured.
# If Bridge Baron 29 is not installed, it guides the user through the installation process.

# Set the Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Check if Bridge Baron 29 is installed
if [ -d "$WINEPREFIX/drive_c/Program Files (x86)/Great Game Products/Bridge Baron 29" ]; then
    # Run Bridge Baron 29 if installed
    wine "$WINEPREFIX/drive_c/Program Files (x86)/Great Game Products/Bridge Baron 29/Baron.exe" 2>/dev/null 1>/dev/null
    clear
    # Display exit message
    cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageBridgeBaron.txt"
    echo ""; echo ""
    exit 0
else
    # If Bridge Baron 29 is not installed, check if installation file exists
    if [ -f "$WINEPREFIX/../INSTALL/BB29WinEngDownload.exe" ]; then
        # Run the installation file if it exists
        clear
        echo "Installing Bridge Baron for the first time; simply accept all defaults."
        echo ""
        wine "$WINEPREFIX/../INSTALL/BB29WinEngDownload.exe" 2>/dev/null 1>/dev/null
        clear
        # Display exit message
        cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageBridgeBaron.txt"
        echo ""; echo ""
        exit 0
    else
        # Guide user on how to install Bridge Baron
        echo " "; echo "To install Bridge Baron, follow these steps:"
        echo "1. download BB29WinEngDownload.exe from https://www.greatgameproducts.com/download"
        echo "2. copy the exe into the MON/INSTALL directory"
        echo "3. run this script again."; echo " "
    fi
fi

