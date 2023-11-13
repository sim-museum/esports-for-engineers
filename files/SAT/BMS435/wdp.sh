clear

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/../INSTALL/wdp/WeaponDeliveryPlanner.exe" ]
then
	wine "$WINEPREFIX/../INSTALL/wdp/WeaponDeliveryPlanner.exe" 2>/dev/null 1>/dev/null
	clear
	exit 0
fi

mv "$WINEPREFIX/../../../tar/Weapon_Delivery_Planner_3.7.19.208.7z" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/Weapon_Delivery_Planner_3.7.19.208.7z" ]
then
	printf "Weapon_Delivery_Planner_3.7.19.208.7z file not found in BMS435/INSTALL.\nFrom https://www.weapondeliveryplanner.nl/download/index.html,\nDownload this file:\n\nWeapon_Delivery_Planner_3.7.19.208.7z\n\nPlace this file in the BMS435/INSTALL directory,\n\nthen run this script again.\n\n"
	exit 0
fi

clear

printf "WDP require .NET.  If you have not issued the command\n\nsudo winetricks dotnet48\n\npress CONTROL C and do it now, then run this script again.\n\nOtherwise, press a key to continue.\n\n"
read replyString

printf "Installing WDP.  Your callsign is \"Viper\".\nChanging the theater (at top left in WDP) causes WDP to hang.\nTo change theater, edit the Theater=<num> line in INSTALL/wdp/Setup.ini.\n\nValid inputs are:\n1: Balkans theater\n6: Israel theater\n7: Korea theater\n9: Mideast128 theater\n\nPress a key to continue.\n\n"
read replyString
clear

cd "$WINEPREFIX/../INSTALL"
mkdir wdp
mv Weapon_Delivery_Planner_3.7.19.208.7z wdp
cd "$WINEPREFIX/../INSTALL/wdp"
p7zip -d Weapon_Delivery_Planner_3.7.19.208.7z
cp "$WINEPREFIX/../INSTALL/wdpSetup.ini" Setup.ini
clear
printf "\nWeapon Delivery Planner (WDP) installed successfully.  Run this script again to start WDP\n"
exit 0


