#!/bin/bash

# linux packages to install before running:
#
# install the Tacview recording viewer and the Weapon Delivery Planner pre-mission briefing utilities.
# 27 Dec 2020 

if [ ! -f /usr/bin/wine ]; then
        echo " "
        echo "ERROR: wine not found.  Install wine 5 or later.  If using the recommended Manjaro 20.2 linux distribution,"
        echo "the command is:"
        echo "sudo pamac install wine"
        echo "for more information, see https://wiki.winehq.org/Download"
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi

if  wine --version | grep "wine-3";  then
        echo " "
        echo "ERROR: wine version 3 found, but wine version 5 or later is required for esports-for-engineers_v34."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

if  wine --version | grep "wine-4";  then
        echo " "
        echo "ERROR: wine version 4 found, but wine version 5 or later is required for esports-for-engineers_v34."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi


if [ ! -f Tacview184Setup.exe ]; then
        echo " "
        echo "ERROR: Tacview184Setup.exe not found in BMS434 directory."
        exit 1
fi

export WINEPREFIX=$PWD/WP
echo " "; echo "Tacview Recordings are in My Computer/drive_c/Falcon BMS 4.35/User/Acmi"; echo " "

if [ -f "$WINEPREFIX/drive_c/Program Files (x86)/Tacview/Tacview64.exe" ]; then
         cd "$WINEPREFIX/drive_c/Program Files (x86)/Tacview"
	 wine Tacview64.exe 2>/dev/null 1>/dev/null
	 exit 0
fi

cd $WINEPREFIX/../INSTALL
wine Tacview184Setup.exe 2>/dev/null 1>/dev/null

