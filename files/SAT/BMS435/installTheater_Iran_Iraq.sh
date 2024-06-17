clear

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Falcon BMS 4.35/Launcher.exe" ]
then
	printf "You must install Falcon BMS 4.35.3 before installing\nadd-on theaters.  Run ./BMS435.sh first, then run this script again.\n\n"
	exit 0
fi

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/Add-On Mideast128" ]
then
	printf "Theater already installed.\n"
        exit 0
fi

mv "$WINEPREFIX/../../../tar/Add-On Mideast128 4-35-U3v10.zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Add-On Mideast128 4-35-U3v10.zip" ]
then
	printf "Iran-Iraq theater file not found in "$WINEPREFIX"/../INSTALL.\nFrom the theaters section of www.falcon-bms.com,\nDownload the latest BMS 4.35.3 Mideast theater file:\nAdd-On Mideast128 4-35-U3v10.zip\nPlace this file in the "$WINEPREFIX"/../INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

echo "unpacking zip file.  This may take several mintes ..."
cd "$WINEPREFIX/../INSTALL"
unzip "Add-On Mideast128 4-35-U3v10.zip" 2>/dev/null 1>/dev/null
cp -R "$WINEPREFIX/../INSTALL/Add-On Mideast128" "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data"
# now add to theater list per instructions
cp $WINEPREFIX/../INSTALL/theater.lst "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/TerrData/TheaterDefinition"

printf "\nIran-Iraq theater added to BMS4.35.3\n"
exit 0

