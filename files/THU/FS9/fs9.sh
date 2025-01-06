#!/bin/bash

# Set Wine prefix
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null


# Check if Flight Simulator executable exists
if [ -f "$WINEPREFIX/drive_c/Program Files/Microsoft Games/Flight Simulator 9/fs9.exe" ]; then
    clear

    # Run Flight Simulator
    wine "$WINEPREFIX/drive_c/Program Files/Microsoft Games/Flight Simulator 9/fs9.exe" 2>/dev/null 1>/dev/null
    exit 0
fi

# Define commonly used directory path
export INSTALL_DIR="$WINEPREFIX/../INSTALL"

# Move installation files
mv "$WINEPREFIX/../../../tar/Microsoft-Flight-Simulator-2004-A-Century-of-Flight_Win_EN_OEM-version-Updated-to-91.zip" "$INSTALL_DIR" 2>/dev/null 1>/dev/null

# Check if installation files exist
if [ ! -f "$INSTALL_DIR/Microsoft-Flight-Simulator-2004-A-Century-of-Flight_Win_EN_OEM-version-Updated-to-91.zip" ]; then
    clear
    printf "Microsoft Flight Simulator 2004: A Century of Flight\ninstall files not found in the directory THU/FS9/INSTALL\n"
    echo ""
    echo "From this link:"; echo ""
    echo "https://www.myabandonware.com/game/microsoft-flight-simulator-2004-a-century-of-flight-g3u#download"
    echo ""
    echo "download the following file:"
    echo "Microsoft-Flight-Simulator-2004-A-Century-of-Flight_Win_EN_OEM-version-Updated-to-91.zip"
    echo ""
    echo "Place this file in the THU/FS9/INSTALL directory."
    echo ""
    echo "Then run this script again."
    echo ""
    exit 0
fi

# Check if setup executable exists
if [ ! -f "$INSTALL_DIR/isoMnt/Setup.Exe" ]; then
    clear

    printf "In the Wine Configuration Dialog that follows:\n1. In the application tab, to the right of \"Windows Version\" select Windows XP.\n2. In the graphics tab, deselect  'Allow the window manager to decorate the windows'\n3. Select virtual Desktop and enter your monitor resolution.\n4.Then select OK.\n\nPress a key to continue.\n\n"
    read replyString

    winecfg 2>/dev/null 1>/dev/null

    echo "Microsoft Flight Simulator 2004 (Flight Simulator 9) zipped iso file found in THU/FS9/INSTALL"
    cd "$INSTALL_DIR"
    clear
    printf  "\nunpacking iso ...\n"
    unzip "Microsoft-Flight-Simulator-2004-A-Century-of-Flight_Win_EN_OEM-version-Updated-to-91.zip" 2>/dev/null 1>/dev/null
    printf "To install Flight Simulator 9, run the following command in a terminal:\n\nsudo mount -o loop \"$INSTALL_DIR/Microsoft Flight Simulator 2004/FS_OEM.mdf\" \"$INSTALL_DIR/isoMnt\"\n\nThen run this script again.\n"
    exit 0
fi

# If setup executable exists, start installation
if [ -f "$INSTALL_DIR/isoMnt/Setup.Exe" ]; then
    # Iso mounted, not installed
    cd "$INSTALL_DIR/isoMnt/"
    clear
    printf "Flight Simulator 9 installation instructions:\n\n1. If asked wither to install Mono, do not install it.\n2. Install. \n3. After installing, deselect fly.\nSelect Exit by clicking on the X at upper right.\n\nPress a key to begin installation.\n\n"


    read replyString
    wine "Setup.exe" 2>/dev/null 1>/dev/null

    printf "\n\nInstallation completed.  Run this script again to start fs9.  (Ignore missing font warnings). \n"
    exit 0
fi

