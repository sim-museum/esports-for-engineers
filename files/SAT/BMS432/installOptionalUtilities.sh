#!/bin/bash

# linux packages to install before running:
# in Ubuntu 20.04 LTS,
#
# install the Tacview recording viewer and the Weapon Delivery Planner pre-mission briefing utilities.
# 29 Sep 2020

if [ ! -f /usr/bin/wine ]; then
        echo " "
        echo "ERROR: wine not found.  Install wine 5 or later.  If using the recommended Ubuntu 20.04 LTS linux distribution,"
        echo "the command is:"
        echo "sudo apt install -y wine"
        echo "for more information, see https://wiki.winehq.org/Download"
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi

if  wine --version | grep "wine-3";  then
        echo " "
        echo "ERROR: wine version 3 found, but wine version 5 or later is required for esports-for-engineers_3_1."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

if  wine --version | grep "wine-4";  then
        echo " "
        echo "ERROR: wine version 4 found, but wine version 5 or later is required for esports-for-engineers_3_1."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi


if [ ! -f Tacview176Setup.exe ]; then
        echo " "
        echo "ERROR: Tacview176Setup.exe not found in BMS432 directory.  Copy this file from the $HOME/esports-for-engineers-v31/SAT/INSTALL directory."
        exit 1
fi

if [ ! -d  Weapon_Delivery_Planner_3.7.2.69 ]; then
        echo " "
        echo "ERROR: Weapon_Delivery_Planner_3.7.2.69 directory not found in BMS432 directory."
        echo "Download and unpack this file from"
	echo "https://web.archive.org/web/20160330163200/http://weapondeliveryplanner.nl/files/wdp/Weapon_Delivery_Planner_3.7.2.69.7z"
        exit 1
fi

export WINEPREFIX=$PWD/WP
wine Tacview176Setup.exe 2>/dev/null 1>/dev/null

cd Weapon_Delivery_Planner_3.7.2.69

if [ ! -f setup.exe ]; then
        echo " "
        echo "ERROR: Weapon_Delivery_Planner_3.7.2.69/setup.exe not found."
        exit 1
fi

wine setup.exe 2>/dev/null 1>/dev/null
