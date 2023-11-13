clear

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Falcon BMS 4.35/Launcher.exe" ]
then
	printf "You must install Falcon BMS 4.35.3 before installing\nadd-on theaters.  Run ./BMS435.sh first, then run this script again.\n\n"
	exit 0
fi

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Somalia" ]
then
	printf "Theater already installed.\n"
        exit 0
fi

mv "$WINEPREFIX/../../../tar/Somalia 4.35.3.rar" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Somalia 4.35.3.rar" ]
then
	printf "Somalia theater file not found in BMS435/INSTALL.\nFrom the theaters section of www.falcon-bms.com,\nDownload the latest BMS 4.35.3 Somalia theater file:\n\nSomalia 4.35.3.rar\n\nPlace this file in the BMS435/INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

echo "unpacking rar file.  This may take several mintes ..."
cd "$WINEPREFIX/../INSTALL"
mkdir somaliaInstall
mv "Somalia 4.35.3.rar" somaliaInstall
cd "$WINEPREFIX/../INSTALL/somaliaInstall"

unrar e "Somalia 4.35.3.rar" 2>/dev/null 1>/dev/null
wine "Somalia v4.35.3.exe" 2>/dev/null 1>/dev/null
clear
printf "\nSomalia theater installed successfully.\n"
exit 0

