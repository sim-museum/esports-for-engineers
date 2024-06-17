#!/bin/bash

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Check if PokerStove.exe exists
if [ -f "$WINEPREFIX/drive_c/Program Files (x86)/PokerStove/PokerStove.exe" ]; then
    cd "$WINEPREFIX/drive_c/Program Files (x86)/PokerStove/"
    wine PokerStove.exe 2>/dev/null
    exit
else
    # Unzip pokerstove-0.1.zip
    unzip -o "./INSTALL/pokerstove-0.1.zip" -d "./INSTALL/" > /dev/null

    # Change directory to PokerStove installation directory
    cd "./INSTALL/pokerstove-0.1/win32/"

    # Print installation instructions
    clear;
    echo "In the configuration dialog, choose Windows XP as the MS Windows version."
    echo "Press Enter to continue ..."

    read replyString

    winecfg 2>/dev/null 1>/dev/null

    # Run PokerStoveSetup124.exe using Wine
    wine PokerStoveSetup124.exe 2>/dev/null 1>/dev/null

    # clean up the INSTALL/pokerstove-0.1 directory
    rm -rf $WINEPREFIX/../INSTALL/pokerstove-0.1

    # Print success message
    clear
    echo "Hold Em calculator installed, run this script again."
    exit
fi
