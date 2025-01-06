
# Script outline:
#
# This script automates the installation and execution of Hoyle Poker 1997.
# If the Poker directory exists, it checks for the presence of 'autoplay.exe' and launches the game.
# If 'autoplay.exe' is not found, it provides instructions for mounting the game ISO.
# If the game ISO is mounted, it configures Wine and initiates the installation.
# If 'autoplay.exe' is still not found, it unpacks the game files from the ISO.
# Before exiting, it provides instructions for mounting the ISO if needed.

#!/bin/bash

# Set Wine prefix
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null


# Directory paths
INSTALL_DIR="$WINEPREFIX/../INSTALL"
POKER_DIR="$WINEPREFIX/drive_c/SIERRA/Poker"
ISO_MOUNT="$INSTALL_DIR/isoMnt"

# Check if Poker directory exists
if [ -d "$POKER_DIR" ]; then
    # Check if autoplay.exe exists
    if [ -f "$INSTALL_DIR/isoMnt/autoplay.exe" ]; then
        # Run Poker executable
        cd "$POKER_DIR"
        wine POKER.EXE >/dev/null 2>&1
        clear
        exit 0
    else
        # Print instructions for mounting ISO
        printf "Cut and paste the commands below at a terminal prompt:\n"
        cd "$WINEPREFIX/../"
        echo "export WINEPREFIX=\$PWD/WP"
        echo "sudo mount -o loop $INSTALL_DIR/hoyle.iso01.iso $ISO_MOUNT"
        printf "\nThen run this script again.\n"
        exit 0
    fi
fi

# Move Hoyle Poker zip file if exists
mv "$WINEPREFIX/../../tar/Hoyle-Poker_Win_EN_ISO-Version.zip" "$INSTALL_DIR" >/dev/null 2>&1

# Check if Hoyle Poker zip file exists
if [ ! -f "$INSTALL_DIR/Hoyle-Poker_Win_EN_ISO-Version.zip" ]; then
    clear
    echo "Hoyle Poker 1997 ISO version install file not found in the directory SUN/INSTALL"
    echo ""
    echo "Download the file from: https://www.myabandonware.com/game/hoyle-poker-dk4#download"
    echo "Place this file in the SUN/INSTALL directory."
    echo ""
    echo "Then run this script again."
    echo ""
    exit 0
else
    # Check if autoplay.exe exists
    if [ -f "$INSTALL_DIR/isoMnt/autoplay.exe" ]; then
        # Mount ISO and configure Wine
        cd "$ISO_MOUNT"
        clear
        printf "In the Wine configuration dialog, in the Applications tab select Windows Version: Windows XP\nSet your monitor resolution to 800x600.\n\nPress a key to continue ...\n"
        winecfg >/dev/null 2>&1
        read -r replyString
        printf "Installing Hoyle Poker 1997\n\nSelect Install\nDo not select Register or Test System.  Select install even though system doesn't meet specifications.  Select save to hard drive. Finally, select exit installer.\nPress a key to begin installation ...\n"
        read -r replyString
        wine "$INSTALL_DIR/isoMnt/setup.exe" >/dev/null 2>&1
        clear
        printf "Run this script again to play Hoyle Poker.\n"
        exit 0
    else
        # Unpack files if ISO not mounted
        if [ ! -f "$INSTALL_DIR/Hoyle-Poker_Win_EN_ISO-Version.zip" ]; then 
            printf "INSTALL/Hoyle-Poker_Win_EN_ISO-Version.zip missing\n\n"
            exit 0
        fi
        clear
        echo "Unpacking files"
        cd "$INSTALL_DIR"
        unzip Hoyle-Poker_Win_EN_ISO-Version.zip
        cd "Hoyle Poker ISO"
        bchunk cd.BIN cd.cue hoyle.iso
        mv hoyle.iso01.iso "$INSTALL_DIR"
        printf "Cut and paste the commands below at a terminal prompt.\nDo not install mono, if prompted to do so:\n"
        cd "$WINEPREFIX/../"
        echo "export WINEPREFIX=\$PWD/WP"
        echo "sudo mount -o loop $INSTALL_DIR/hoyle.iso01.iso $ISO_MOUNT"
        printf "\nThen run this script again.\n"
    fi
fi

