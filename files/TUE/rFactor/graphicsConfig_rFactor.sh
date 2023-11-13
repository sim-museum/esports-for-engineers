#!/bin/bash

#$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
#if [ $? -ne 0 ]; then
#        exit 1
#fi

export WINEPREFIX="$PWD/WP"
if [ ! -d "$WINEPREFIX/drive_c/Program Files (x86)/rFactor" ]
then
	echo ""; echo "rFactor not installed.  Run rFactor.sh first, then run"
	echo "this script again."
fi	

cd "$WINEPREFIX/drive_c/Program Files (x86)/rFactor"

wine "rF Config.exe" 

exit 0

