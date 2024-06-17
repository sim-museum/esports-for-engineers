clear

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Falcon BMS 4.35/Launcher.exe" ]
then
	printf "You must install Falcon BMS 4.35.3 before installing\nadd-on theaters.  Run ./BMS435.sh first, then run this script again.\n\n"
	exit 0
fi

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Balkans" ]
then
	printf "Theater already installed.\n"
        exit 0
fi

mv "$WINEPREFIX/../../../tar/Balkans_Theater_4.35.3.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Balkans_Theater_4.35.3.zip" ]
then
	printf "Balkans theater file not found in BMS435/INSTALL.\nFrom the theaters section of www.falcon-bms.com,\nDownload the latest BMS 4.35.3 Balkans theater file:\nBalkans_Theater_4.35.3.zip\nPlace this file in the BMS435/INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

echo "unpacking zip file.  This may take several mintes ..."
cd "$WINEPREFIX/../INSTALL"
unzip "Balkans_Theater_4.35.3.zip" 2>/dev/null 1>/dev/null
wine "Balkans_Theater_4.35.3 v0393.exe" 2>/dev/null 1>/dev/null

echo "Installing Tactical Engagement (TE) Mission set for Korea and Balkans Theaters"
rsync -a "$WINEPREFIX/../INSTALL/Mission set for Falcon BMS 4.35/1. Korea Theater/" "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Campaign/"
rsync -a "$WINEPREFIX/../INSTALL/Mission set for Falcon BMS 4.35/2. Balkans Theater/" "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Balkans/Campaign/"

clear
printf "\nBalkans theater added to BMS4.35.3\n"

exit 0

