# Script Outline:
# 1. Check if Omar Sharif Bridge is already installed. If so, run the application.
# 2. If Omar Sharif Bridge is not installed, guide the user through the installation process.
# 3. Provide instructions for configuring Wine.
# 4. Inform the user about successful installation.
#!/bin/bash

# This script installs and runs Omar Sharif Bridge on Wine, ensuring Wine version compatibility.
# If Omar Sharif Bridge is already installed, it launches the application.
# If Omar Sharif Bridge is not installed, it guides the user through the installation process.

# Check if Wine is installed and configured properly
# $PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
# if [ $? -ne 0 ]; then
#     exit 1
# fi

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Check if Omar Sharif Bridge is already installed
if [ -f "$WINEPREFIX/drive_c/Program Files/BRIDGE2/BR.EXE" ]; then
    # If installed, change directory and run Omar Sharif Bridge
    cd "$WINEPREFIX/drive_c/Program Files/BRIDGE2"
    wine BR.EXE 2>/dev/null 1>/dev/null
    exit 0
fi

# Move the installation file to the INSTALL directory
mv "$WINEPREFIX/../../../tar/Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null

# Check if installation file exists
if [ ! -f "$WINEPREFIX/../INSTALL/Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip" ]; then
    # If installation file not found, provide instructions for downloading and placing the file
    if wine --version | grep -q "wine-6.0"; then
        printf "Version 6.0 of wine detected.\nFor installation, Omar Sharif Bridge requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
    fi
    printf "Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip file not found in $WINEPREFIX/../INSTALL.\nFrom \n\nhttps://www.myabandonware.com/game/bridge-baron-12-f44#download\n\nDownload this file:\n\nBridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip\n\nPlace this file in the $WINEPREFIX/../INSTALL directory,\n\nthen run this script again.\n\n"
    exit 0
fi

# Provide instructions for configuring Wine
printf "In the wine configuration dialog box select Windows 95 for the Windows version,\nthen in the graphics tab select virtual desktop, and enter a screen resolution, such as 800x600.\nUnselect allow the windows manager to decorate the window.\nSelect defaults during game install.\n\nPress any key to continue.\n\n"
read replyString
WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null

# Move the installation file to the Wine prefix directory and unzip it
mv "$WINEPREFIX/../INSTALL/Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip" "$WINEPREFIX/drive_c/Program Files"
cd "$WINEPREFIX/drive_c/Program Files"
unzip Bridge-Deluxe-2-With-Omar-Sharif_Win_EN_RIP-Version.zip 2>/dev/null 1>/dev/null
cd "$WINEPREFIX/drive_c/Program Files/BRIDGE2"
wine INSTALL.EXE 2>/dev/null 1>/dev/null

# Inform user about successful installation
printf "\nOmar Sharif Bridge installed successfully.\nRun this script again to play.  If the menu bar\nis missing in the game press the ALT key to make it appear.  In-game videos are not working at present.\n\n"
exit 0

