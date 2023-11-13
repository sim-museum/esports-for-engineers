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



export WINEPREFIX=$PWD/WP
if [ -d "$WINEPREFIX/drive_c/Program Files (x86)/Tacview" ]
then
	# Tacview is installed in BMS432
	cd "$WINEPREFIX/drive_c/Program Files (x86)/Tacview"
	wine Tacview  2>/dev/null 1>/dev/null
else
        # Tacview not installed yet
	wine Tacview176Setup.exe 2>/dev/null 1>/dev/null
fi	
exit 0
