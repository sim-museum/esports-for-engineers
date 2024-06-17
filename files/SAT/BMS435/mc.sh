clear

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/../INSTALL/mc/Mission Commander.exe" ]
then
	wine "$WINEPREFIX/../INSTALL/mc/Mission Commander.exe" 2>/dev/null 1>/dev/null
	clear
	exit 0
fi

mv "$WINEPREFIX/../../../tar/Mission_Commander_0.5.20.685.7z" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Mission_Commander_0.5.20.685.7z" ]
then
	printf "Mission_Commander_0.5.20.685.7z file not found in BMS435/INSTALL.\nFrom https://www.weapondeliveryplanner.nl/download/index.html,\nDownload this file:\n\nMission_Commander_0.5.20.685.7z\n\nPlace this file in the BMS435/INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

clear

printf "Mission Commander require .NET.  If you have not issued the command\n\nsudo winetricks dotnet48\n\npress CONTROL C and do it now, then run this script again.\n\nOtherwise, press a key to continue.\n\n"
read replyString

clear

cd "$WINEPREFIX/../INSTALL"
mkdir mc 
mv Mission_Commander_0.5.20.685.7z mc
cd "$WINEPREFIX/../INSTALL/mc"
p7zip -d Mission_Commander_0.5.20.685.7z

clear
printf "\nMission CommanderWeapon (MC) installed successfully.  Run this script again to start MC\n"
exit 0

