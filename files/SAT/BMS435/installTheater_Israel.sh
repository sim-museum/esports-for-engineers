clear

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Falcon BMS 4.35/Launcher.exe" ]
then
	printf "You must install Falcon BMS 4.35.3 before installing\nadd-on theaters.  Run ./BMS435.sh first, then run this script again.\n\n"
	exit 0
fi

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Israel" ]
then
	printf "Theater already installed.\n"
        exit 0
fi

mv "$WINEPREFIX/../../../tar/Israel_Theater_4.35.3.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/Israel Theater 1.05.4v Patch.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Israel_Theater_4.35.3.zip" ]
then
	printf "Isreal theater files not found in BMS435/INSTALL.\nFrom the theaters section of www.falcon-bms.com,\nDownload the latest BMS 4.35.3 Isreal theater files:\n\nIsrael_Theater_4.35.3.zip\n\nand\n\nIsrael Theater 1.05.4v Patch.zip\n\nPlace these files in the BMS435/INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

echo "unpacking zip files.  This may take several mintes ..."
cd "$WINEPREFIX/../INSTALL"

unzip "Israel_Theater_4.35.3.zip" 2>/dev/null 1>/dev/null
unzip "Israel Theater 1.05.4v Patch.zip" 2>/dev/null 1>/dev/null
wine "Israel_Theater_4.35 v1.05.3.exe" 2>/dev/null 1>/dev/null
clear
printf "\n applying Israel Theater 1.05.4v Patch ...\n\n"
rsync -a "$WINEPREFIX/../INSTALL/Add-On Israel/" "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Israel/"
clear
printf "\nIsreal theater installed successfully.\n"
exit 0

