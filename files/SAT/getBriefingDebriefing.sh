#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX="$PWD/WP"

#copy briefing file to SAT directory

echo " "

if [ -f "$WINEPREFIX/drive_c/FreeFalcon6/Briefing.txt" ]
then 
	echo "Copying mission briefing file Briefing.txt to SAT directory"
	cp "$WINEPREFIX/drive_c/FreeFalcon6/Briefing.txt" $WINEPREFIX/..
else
	echo "No mission briefing file found."
	echo "In Free Falcon select BRIEFING, then PRINT"
fi

echo " "

if [ -f "$WINEPREFIX/drive_c/FreeFalcon6/debrief.txt" ]
then 
	echo "Copying mission debrief file debrief.txt to SAT directory"
	cp "$WINEPREFIX/drive_c/FreeFalcon6/debrief.txt" $WINEPREFIX/..
else
	echo "No mission debriefing file found."
	echo "Debrief is only available after at least one mission has been completed."
fi

echo " "

