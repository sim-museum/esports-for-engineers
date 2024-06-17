clear

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c//Program Files (x86)/Tacview/Tacview64.exe" ]
then
	wine "$WINEPREFIX/drive_c//Program Files (x86)/Tacview/Tacview64.exe" 2>/dev/null 1>/dev/null
	clear
	exit 0
fi

mv "$WINEPREFIX/../../../tar/Tacview187Setup.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Tacview187Setup.exe" ]
then
	printf "Tacview187Setup.exe file not found in "$WINEPREFIX"/../INSTALL.\nFrom www.tacview.net,\nDownload this file:\n\nTacview187Setup.exe\n\nPlace this file in the "$WINEPREFIX"/../INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

cd "$WINEPREFIX/../INSTALL"
wine "Tacview187Setup.exe" 2>/dev/null 1>/dev/null
clear
printf "\ntacview installed successfully.\n"
exit 0

