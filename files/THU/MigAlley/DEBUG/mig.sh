#!/bin/bash

# run the Mig Alley program
# this linux script file is from https://github.com/bencaddigan/esports-for-engineers
# wine must be loaded before running this script
# tested on Ubuntu 20.04
# on Ubuntu 20.04, the command to load wine is
# sudo apt install -y wine 
#
# preferences/controls set for Logitech Extreme 3D Pro joystick

# 30 May 2020

if [ ! -f /usr/bin/wine ]; then
        echo " "
        echo "ERROR: wine not found.  Install wine 5 or later for your version of linux using the instructions at https://wiki.winehq.org/Download"
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi


if  wine --version | grep "wine-3";  then
        echo " "
        echo "ERROR: wine version 3 found, but wine version 5 or later is required for esports-for-engineers_3_0."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

if  wine --version | grep "wine-4";  then
        echo " "
        echo "ERROR: wine version 4 found, but wine version 5 or later is required for esports-for-engineers_3_0."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

export WINEPREFIX=$PWD/WP
clear
echo "Review the descriptions of graphics settings in the documentation."
echo "Briefly - to run Mig Alley without graphics problems, you need either"
echo "1. (this is the recommended option) two computer monitors, both set to their maximum resolution, all .setWineDisplayResolution.sh graphics "
echo "tic boxes unselected except \"Allow the window manager to control the windows\", which should be selected"
echo "and Mig Alley resolution set to the 1024x768 (if that works you can try increasing resolution to 1152x864)"
echo "or "
echo "2. alternating virtual desktop as described below:"
echo "virtual desktop turned on if flying in 3D mode."
echo "If you're going to be using the 2D campaign screen, you need virtual desktop turned off."
echo "After setting up a mission in 2D campaign screen (with virtual desktop turned off), save and exit."
echo "Then start Mig Alley again with virtual desktop turned on,"
echo "load the mission you just saved, and fly the mission."
echo ""
echo "to summarize:"
echo "If planning to fly in the 3D mode, turn on Graphics/emulate virtual desktop and set the desktop size to match you display resolution."
echo ""
echo "If using the 2D campaign screen, turn OFF Graphics/emulate virtual desktop."
echo ""
echo "The graphics configuration screen will appear next.  When you exit from this screen, Mig Alley will start."
echo ""
echo "Within Mig Alley, you can set the graphics resolution via the Resolutions entry in the PREFERENCES/3D tab.  It is recommened to set"
echo "the PREFERENCES/3D resolution in Mig Alley to the same as your virtual desktop resolution."
echo ""
#winecfg
cd $WINEPREFIX/drive_c/rowan/mig
wine Mig.exe 2>/dev/null 1>/dev/null
#clear
#   cat "$WINEPREFIX/../DOC/REFERENCE/MIG123_patch_readme.txt"
#   cat "$WINEPREFIX/../DOC/REFERENCE/BDG_community_patch_0.85F_readme.txt"
   echo ""; echo ""

exit 0
