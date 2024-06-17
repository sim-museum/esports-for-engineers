# Script Outline:
# 1. Check if Bridge Baron 12 is already installed. If so, run the application.
# 2. If Bridge Baron 12 is not installed, guide the user through the installation process.
# 3. Provide instructions for configuring Wine.
# 4. Inform the user about successful installation.

#!/bin/bash

# This script installs and runs Bridge Baron 12 on Wine, assuming Wine is properly configured.
# If Bridge Baron 12 is already installed, it launches the application.
# If Bridge Baron 12 is not installed, it guides the user through the installation process.

# Clear the terminal
clear

# Check Wine version and installation
# $PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
# if [ $? -ne 0 ]; then
#     exit 1
# fi

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Check if Bridge Baron 12 is already installed
if [ -f "$WINEPREFIX/Bridge Baron/Baron.exe" ]; then
    # If installed, change directory and run Bridge Baron 12
    cd "$WINEPREFIX/Bridge Baron"
    wine Baron.exe 2>/dev/null 1>/dev/null
    clear
    exit 0
fi

# Move the installation file to the INSTALL directory
mv "$WINEPREFIX/../../../tar/Bridge-Baron-12_Win_EN.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null

# Check if installation file exists
if [ ! -f "$WINEPREFIX/../INSTALL/Bridge-Baron-12_Win_EN.zip" ]; then
    # If installation file not found, provide instructions for downloading and placing the file
    printf "Bridge-Baron-12_Win_EN.zip file not found in $WINEPREFIX/../INSTALL\n\nFrom \n\nhttps://www.myabandonware.com/game/bridge-baron-12-f44#download\n\nDownload this file:\n\nBridge-Baron-12_Win_EN.zip\n\nPlace this file in the $WINEPREFIX/../INSTALL directory,\n\nthen run this script again.\n\n\n"
    exit 0
fi

# Move the installation file to the Wine prefix directory and unzip it
mv "$WINEPREFIX/../INSTALL/Bridge-Baron-12_Win_EN.zip" "$WINEPREFIX"
cd "$WINEPREFIX"
unzip Bridge-Baron-12_Win_EN.zip 2>/dev/null 1>/dev/null

# Provide instructions for configuring Wine
clear
printf "In the wine configuration dialog box select Windows 98 for the Windows version,\nthen in the graphics tab select virtual desktop, and enter a screen resolution, such as 800x600.\nDeselect allow the window manager to decorate the windows.\n\nPress any key to continue.\n\n\n"
read replyString
WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null

# Inform user about successful installation
clear
printf "\nBridge Baron 12 installed successfully.  Run this script again to play.\n\n"
exit 0

