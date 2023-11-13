#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX="$PWD/WP"
if [ ! -d $WINEPREFIX/drive_c/FreeFalcon6 ]
then
	# free falcon not installed yet
	echo ""; echo "Run freeFalcon.sh, then run this script again."; echo ""
fi

if [ ! -f $WINEPREFIX/../INSTALL/alreadyRanDoghouseFlag.txt ]
then
	echo ""; echo " installing mfc42 windows component needed by f4doghouse"; echo ""
	winetricks mfc42
	touch $WINEPREFIX/../INSTALL/alreadyRanDoghouseFlag.txt
fi
clear
echo "To view graphs of flight performance, open an aircraft .dat file in the following directory:"
echo "$WINEPREFIX/drive_c/FreeFalcon6/Zips/sim/ACDATA"; echo ""
wine INSTALL/f4doghouse.exe 2>/dev/null 1>/dev/null
exit 0

