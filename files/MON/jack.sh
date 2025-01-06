#!/bin/bash

# Outline of jack.sh:
# This script checks if the Jack 6 demo directory exists in the Wine prefix directory.
# If the directory exists, it runs the Jack 6 demo.
# If the directory does not exist, it installs the Jack bridge for the first time by running the Jack 6 demo installer.

# Set the Wine prefix directory
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Check if the Jack 6 demo directory exists in the Wine prefix
if [ -d "$WINEPREFIX/drive_c/Program Files/Jack 6 demo" ]; then
    # Run the Jack 6 demo
    wine "$WINEPREFIX/drive_c/Program Files/Jack 6 demo/jackdemo.exe" 2>/dev/null 1>/dev/null
    clear
    # Display exit message from reference file
    cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageJack.txt"
    echo ""; echo ""
    exit 0
else
    # Install Jack bridge for the first time
    clear
    echo "Installing jack bridge for the first time; simply accept all defaults."
    echo ""
    # Run the Jack 6 demo installer
    wine "$WINEPREFIX/../INSTALL/Setup-Jack-6-demo-ENG.exe" 2>/dev/null 1>/dev/null
    clear
    # Display exit message from reference file
    cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageJack.txt"
    echo ""; echo ""
    exit 0
fi

