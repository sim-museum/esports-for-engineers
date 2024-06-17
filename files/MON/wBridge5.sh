# Script Outline:
# 1. Check if Wbridge5 is already installed. If so, run the application.
# 2. If Wbridge5 is not installed, guide the user through the installation process.
# 3. Check Wine version for compatibility. If incompatible, display message and exit.
# 4. If Wine version is compatible, install Wbridge5 and display exit message.
#!/bin/bash

# This script installs and runs Wbridge5 on Wine, ensuring Wine version compatibility.
# If Wbridge5 is already installed, it launches the application.
# If Wbridge5 is not installed, it guides the user through the installation process.

# Check Wine version and installation
# $PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
# if [ $? -ne 0 ]; then
#     exit 1
# fi

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Check if Wbridge5 is already installed
if [ -d "$WINEPREFIX/drive_c/wbridge5" ]; then
    # If installed, run Wbridge5
    wine "$WINEPREFIX/drive_c/wbridge5/Wbridge5.exe" 2>/dev/null 1>/dev/null
    clear
    # Display exit message
    cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageWbridge5.txt"
    echo ""; echo ""
    exit 0
else
    # Check Wine version for compatibility
    clear
    if wine --version | grep -q "wine-6.0"; then
        printf "Version 6.0 of wine detected.\nFor installation, Omar Sharif Bridge requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine-experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
    fi

    # If Wbridge5 is not installed and Wine version is compatible, install it
    echo "Installing Wbridge5 for the first time; simply accept all defaults."
    echo ""
    echo "Install gecko when prompted."
    echo "this will cause online help, as well as file load and save, to work."; echo ""
    wine "$WINEPREFIX/../INSTALL/Wbridge5_setup.exe" 2>/dev/null 1>/dev/null
    clear
    # Display exit message
    cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageWbridge5.txt"
    echo ""; echo ""   
    exit 0
fi

