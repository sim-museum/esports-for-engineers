#!/bin/bash
export WINEPREFIX=$HOME/ese/BMS432/WP
if [ -d "$WINEPREFIX/drive_c/Program Files (x86)/Tacview" ]
then
	# Tacvire is installed in Free Falcon wine bottle
	cd "$WINEPREFIX/drive_c/Program Files (x86)/Tacview"
	wine Tacview  2>/dev/null 1>/dev/null
else
        # Tacview not installed yet
	wine Tacview176Setup.exe 2>/dev/null 1>/dev/null
fi	
exit 0
