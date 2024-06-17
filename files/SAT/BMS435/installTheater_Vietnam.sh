clear

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Falcon BMS 4.35/Launcher.exe" ]
then
	printf "You must install Falcon BMS 4.35.3 before installing\nadd-on theaters.  Run ./BMS435.sh first, then run this script again.\n\n"
	exit 0
fi

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Vietnam" ]
then
	printf "Theater already installed.\n"
        exit 0
fi

mv "$WINEPREFIX/../../../tar/Add-On Vietnam 4.35.U1.2.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Add-On Vietnam 4.35.U1.2.zip" ]
then
	printf "Vietnam theater file not found in BMS435/INSTALL.\nFrom the theaters section of www.falcon-bms.com,\nDownload the latest BMS 4.35.3 Vietnam theater file:\n\nAdd-On Vietnam 4.35.U1.2.zip\n\nPlace this file in the BMS435/INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

echo "unpacking zip file.  This may take several mintes ..."
cd "$WINEPREFIX/../INSTALL"
mkdir vietnamInstall
mv "Add-On Vietnam 4.35.U1.2.zip" vietnamInstall
cd "$WINEPREFIX/../INSTALL/vietnamInstall"

unzip "Add-On Vietnam 4.35.U1.2.zip" 2>/dev/null 1>/dev/null
wine "Add-On Vietnam 4.35.U1.2 .exe" 2>/dev/null 1>/dev/null
clear
printf "\nVietnam theater installed successfully.\n"
exit 0

