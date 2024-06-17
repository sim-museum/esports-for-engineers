
# Script outline
#    This script checks for the presence of the Battle of Britain installation and Wine version compatibility.
#    If Battle of Britain is installed, it launches the game.
#    If not, it checks the monitor setup for graphics compatibility.
#    If all requirements are met, it proceeds to mount the installation ISO and configures Wine for installation.
#    Once the installation is complete, it applies necessary patches and launches the game.

#!/bin/bash

# Define variables for readability
WINEPREFIX="$PWD/WP"
BoB_INSTALL="$PWD/INSTALL"

# Check if BoB is installed
if [ -f "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain/bob.exe" ]; then
    # Check Wine version
    if wine --version | grep "wine-7"; then
        clear
        printf "Version 7.x of wine detected.\nWine 6.0 is recommended for running Battle of Britain.\n\nFrom the ese directory, run \n\n./wine_default.sh\n\nto install wine 6.0.\n\nThen run this script again.\n\n"
        exit 0
    fi
    cd "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain/"
    wine bob.exe 2>/dev/null 1>/dev/null
    exit 0
fi

# Check number of monitors
numMonitors=$(xrandr -q | grep connected | grep -v disconnected | wc -l)
if [ "$numMonitors" -ne 2 ]; then
    echo " "
    echo "To avoid graphics glitches, a dual monitor setup is recommended for Battle of Britain."
    echo " "; echo "$numMonitors monitor(s) detected."; echo " "
    echo "If using 1 monitor, run ./setWineDisplayResolution.sh, select the graphics"
    echo "tab, and enable virtual desktop, using your maximum monitor resolution."
    echo "this will cause many campaign screen 2D icons to disappear, but campaign is"
    echo "still playable. It has the advantage of allowing 3D view at higher resolution"
    echo "than 1024x768."
    echo "To stop this script and set up dual monitors, press <CTRL> C."
    echo "To continue with your current monitor setup, press Enter"; echo " "
    read -r replyString
fi

# Check if BoB installation ISO exists
if [ ! -f "$BoB_INSTALL/BoB_iso/Setup.exe" ]; then
    clear;
    if wine --version | grep "wine-6.0"; then
        clear
        printf "Version 6.0 of wine detected.\nWine version 7 is recommended for installing Battle of Britain.\n\nFrom the ese directory, run \n\n./wine_experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
    fi
    echo "Before you can install Battle of Britain, you must mount the Battle of Britain iso."
    echo " "
    echo "Mount the Battle of Britain CD-ROM iso using this command:"
    echo " "; echo "sudo mount -o loop $PWD/INSTALL/BATTLEOFBRITAIN.iso $PWD/INSTALL/BoB_iso"; echo " "
    echo "Then run this script again."
    exit 1
fi

# Configuration before installation
clear; 
echo "In the Wine configuration dialog box, which appears next, select Windows XP as the Windows version."
echo "Next, select the 'Graphics' tab."
echo "In the Graphics tab, unselect 'Allow the window manager to decorate the windows'" 
echo "Then select OK to continue the installation."; echo " "
echo "Press enter to display the Wine configuration dialog box."
read -r replyString
winecfg 2>/dev/null 1>/dev/null
echo " "; echo "Setting resolution on monitors to maximum resolution to avoid Battle of Britain graphics problems";
./delayedMonitorReset.sh 0
wine "$BoB_INSTALL/BoB_iso/Setup.exe" 2>/dev/null 1>/dev/null

# Installation instructions
echo "When Battle of Britain starts, select PC CONFIG and set graphics resolutions to 1280x1024 or 1024x768."
echo "Set all other graphics options to maximum values. If the mouse cursor disappears, hold down"
echo "CTRL F6 to show the mouse cursor. To view online documentation, install wine gecko when"
echo "prompted. If asked to wait or force quit, use <ALT> TAB to find this gecko prompt dialog."
echo " "
cd "$BoB_INSTALL/RR ROWANBOB GRAPHICS MOD/"
echo " "; echo "Applying patch 1 of 2"; echo " "
wine bob_v099.exe 2>/dev/null 1>/dev/null
echo " "; echo "Applying patch 2 of 2"; echo " "
rsync -a bobMain/ "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain/"
cp "$WINEPREFIX/../INSTALL/keys.xml" "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain/KEYBOARD"
cd "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain"
wine bob.exe 2>/dev/null 1>/dev/null

