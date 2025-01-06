# Script Outline:
# 1. Set Wine prefix directory.
# 2. Check if Qplus Bridge 15 is installed. If installed, run the application.
# 3. Check Wine version for compatibility. If Wine version is 6.0, display message and exit.
# 4. If Qplus Bridge 15 is not installed and Wine version is compatible, check if installation file exists.
# 5. If installation file exists, initiate the installation process.
# 6. If installation file does not exist, guide the user on how to install Qplus Bridge 15.
#!/bin/bash

# This script launches Qplus Bridge 15 under Wine, ensuring Wine version compatibility.
# If Qplus Bridge 15 is not installed, it guides the user through the installation process.

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Check if Qplus Bridge 15 is installed
if [ -d "$WINEPREFIX/drive_c/games/qbridge15" ]; then
    # If installed, run Qplus Bridge 15
    cd "$WINEPREFIX/drive_c/games/qbridge15"
    wine QBRIDGE.EXE 2>/dev/null 1>/dev/null
    cd "$WINEPREFIX/.."
    clear
    # Display exit message
    cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageQplus.txt"
    echo ""; echo ""
    exit 0
else
    # Check Wine version for compatibility
    if wine --version | grep "wine-6.0"; then
        # If Wine version is 6.0, display message and exit
        clear
        printf "Version 6.0 of wine detected.\nFor installation, Qplus Bridge requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
    fi

    # If Qplus Bridge 15 is not installed and Wine version is compatible, check if installation file exists
    if [ -f "$WINEPREFIX/../INSTALL/qplus15-eng.exe" ]; then
        # If installation file exists, initiate the installation process
        clear
        echo "Installing Qplus Bridge for the first time; simply accept all defaults."
        echo ""
        wine "$WINEPREFIX/../INSTALL/qplus15-eng.exe" 2>/dev/null 1>/dev/null
        clear
        # Display exit message
        cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageQplus.txt"
        echo ""; echo ""
        exit 0
    else
        # Guide user on how to install Qplus Bridge
        echo " "; echo "To install Qplus Bridge, follow these steps:"
        echo "1. Download qplus15-eng.exe from https://www.q-plus.com/engl/download/download_f.htm"
        echo "2. Copy the exe into the MON/INSTALL directory"
        echo "3. Run this script again."; echo " "
    fi
fi

