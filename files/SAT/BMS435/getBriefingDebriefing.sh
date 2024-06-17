#!/bin/bash

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



export WINEPREFIX="$PWD/WP"

#copy briefing file to BMS434 directory

echo " "

if [ -f "$WINEPREFIX/drive_c/Falcon BMS 4.34/User/Briefings/Briefing.txt" ]
then 
	echo "Copying mission briefing file Briefing.txt to BMS434 directory"
	cp "$WINEPREFIX/drive_c/Falcon BMS 4.34/User/Briefings/Briefing.txt" $WINEPREFIX/..
else
	echo "No mission briefing file found."
	echo "On Mission screen select BRIEFING, then PRINT"
fi

echo " "

if [ -f "$WINEPREFIX/drive_c/Falcon BMS 4.34/User/Briefings/debrief.txt" ]
then 
	echo "Copying mission debrief file debrief.txt to BMS433 directory"
	cp "$WINEPREFIX/drive_c/Falcon BMS 4.34 U1/User/Briefings/debrief.txt" $WINEPREFIX/..
else
	echo "No mission debriefing file found."
	echo "Debrief is only available after at least one mission has been completed."
fi

echo " "

