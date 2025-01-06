#!/bin/bash

# Set the Wine prefix to a directory named 'WP' in the current working directory
export WINEPREFIX="$PWD/WP"
#export WINEARCH=win32
#wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Move the Speed Dreams AppImage to the Wine prefix's 'INSTALL' directory
mv "$WINEPREFIX/../../tar/Speed-Dreams-2.2.3-x86_64.AppImage" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null

# Check if the Speed Dreams AppImage exists in the 'INSTALL' directory
if [ -f "$WINEPREFIX/../INSTALL/Speed-Dreams-2.2.3-x86_64.AppImage" ]; then
    # make sure this linux binary is executable
    sudo chmod +x "$WINEPREFIX/../INSTALL/Speed-Dreams-2.2.3-x86_64.AppImage"
    # Move the AppImage to the Wine prefix directory
    mv "$WINEPREFIX/../INSTALL/Speed-Dreams-2.2.3-x86_64.AppImage" "$WINEPREFIX"
fi

# Check if the Speed Dreams AppImage exists in the Wine prefix directory
if [ -f "$WINEPREFIX/Speed-Dreams-2.2.3-x86_64.AppImage" ]; then
    # Clear the screen and provide instructions for launching Speed Dreams
    clear
    echo "Speed Dreams open source sim racing"; echo ""
    echo "To race a 67 Grand Prix car at Monza, Choose:"
    echo "Race"
    echo "Practics"
    echo "Configure"
    echo "Now select Grand Prix Circuits on the top line, and Forza on the second line"
    echo "Next"
    echo "Garage"
    echo "For Category on top left select 1967 Grand Prix"
    echo "Apply, Next, Next, Start"
    echo ""
    # Launch Speed Dreams
    $WINEPREFIX/Speed-Dreams-2.2.3-x86_64.AppImage 2>/dev/null 1>/dev/null
else
    # Display a message if the Speed Dreams AppImage is not found
    clear
    printf "\n\nSpeed-Dreams-2.2.3-b1-x86_64.AppImag not found.\n\nDownload it from https://sourceforge.net/projects/speed-dreams/files/latest/download\n\nand place it in the "$WINEPREFIX"/../INSTALL directory\n\n"
    echo ""; echo "Then run this script again."
    echo ""
fi

# End of script

