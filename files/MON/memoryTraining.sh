# Script Outline:
# 1. Check if Brain Workshop is already installed. If so, run the application.
# 2. If Brain Workshop is not installed, guide the user through the installation process.
# 3. Check Wine version for compatibility. If incompatible, display message and exit.
# 4. If Wine version is compatible, install Brain Workshop and display README instructions.
#!/bin/bash

# Script to install and run Brain Workshop on Wine, ensuring Wine version compatibility.
# If Brain Workshop is already installed, it launches the application.
# If Brain Workshop is not installed, it guides the user through the installation process.

# Check if Wine is installed and configured properly
# $PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
# if [ $? -ne 0 ]; then
#     exit 1
# fi

#!/bin/bash

# Set Wine prefix directory
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp

# Check if Brain Workshop is already installed
if [ -d "$WINEPREFIX/drive_c/Program Files/Brain Workshop" ]; then
    # If installed, change directory and run Brain Workshop
    cd "$WINEPREFIX/drive_c/Program Files/Brain Workshop"
    wine brainworkshop.exe 2>/dev/null 1>/dev/null
#    deactivate
    clear
    # Display README instructions
    cat Readme-instructions.txt
    printf "\n\n"
    exit 0
else
    # Check Wine version for compatibility
    clear
    if wine --version | grep -q "wine-9.0"; then
        clear
        printf "Version 9.0 of wine detected.  This version of wine will not install Brain workshop.  Versions that will install Brain workshop include:\nwine-ge-8-26-x86 under lutris, and all tested versions of winehq staging. Run this installation .exe from lutris, or install winehq-staging.\n\nThen run this script again.\n\n"
        exit 0
    fi

    # If Brain Workshop is not installed and Wine version is compatible, install it
    echo "Installing Brain Workshop; simply accept all defaults."
    echo ""
    wine "$WINEPREFIX/../INSTALL/brainworkshop-4.8.4-win32-setup.exe" 2>/dev/null 1>/dev/null
    clear
    # Display README instructions
    cat "$WINEPREFIX/drive_c/Program Files/Brain Workshop/Readme-instructions.txt"
    printf "\n\nRun this script again to start the program\n\n"
    exit 0
fi

