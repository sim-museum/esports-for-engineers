#!/bin/bash

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null


# Check if PokerStove.exe exists
if [ -f "$WINEPREFIX/drive_c/Program Files/PokerStove/PokerStove.exe" ]; then
    cd "$WINEPREFIX/drive_c/Program Files/PokerStove/"
    wine PokerStove.exe 2>/dev/null
    exit
else
    # Change directory to PokerStove installation directory
    cd "./INSTALL/"

    # Print installation instructions
    clear;
    echo "In the configuration dialog, choose Windows XP as the MS Windows version."
    echo "Press Enter to continue ..."

    read replyString

    winecfg 2>/dev/null 1>/dev/null

    # Run PokerStoveSetup124.exe using Wine
    wine PokerStoveSetup124.exe 2>/dev/null 1>/dev/null

    # Print success message
    clear
    echo "Hold Em calculator installed, run this script again."
    exit
fi
