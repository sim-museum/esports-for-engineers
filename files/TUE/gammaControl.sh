#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX="$PWD/WP"
if [ ! -d "$WINEPREFIX/drive_c/Program Files (x86)/DesktopNerds/Gamma Control" ]
then
	echo ""; echo "Installing Gamma Control.  Select add to desktop so you can"
	echo "Click to run it, then click to run rFactor from the desktop."; echo ""
	wine "$WINEPREFIX/../INSTALL/GammaControlv4setup.exe" 2>/dev/null 1>/dev/null
fi	

wine "$WINEPREFIX/drive_c/Program Files (x86)/DesktopNerds/Gamma Control/GammaControlv4setup.exe" 

exit 0

