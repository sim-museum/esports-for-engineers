#!/usr/bin/bash

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Weapon Delivery Planner/WeaponDeliveryPlanner.exe" ]
then
	echo ""; echo "running Weapon Delivery Planner"; echo ""
	cd "$WINEPREFIX/drive_c/Weapon Delivery Planner"
	wine WeaponDeliveryPlanner.exe 2>/dev/null 1>/dev/null
	exit 0
else
	if [ -f $PWD/Weapon_Delivery_Planner_3.7.2.69/setup.exe ]
	then
		clear; echo "installing Weapon Delivery Planner"; echo ""
		echo "Install libraries needed by Weapon Delivery Planner via these two commands:"
		echo "winetricks dotnet48"
		echo "winetricks mdac28 jet40"
		echo "If you haven't already, press <CTRL> C, run the two winetricks commands and then"
		echo "run this script again."
		echo ""
		echo "If you've already run these two winetricks commands, press ENTER to continue."
		read replyString
		echo ""; echo "When prompted, enter the default callsign, which is Viper."; echo ""

		cd $PWD/Weapon_Delivery_Planner_3.7.2.69
		wine setup.exe 2>/dev/null 1>/dev/null
		echo ""; echo "Installation complete.  Now run this script again to run Weapon Delivery Planner."
		exit 0
	else
	        clear	
                echo "A very helpful add-on to BMS is the Weapon Delivery Planner (WDP) utility."
                echo "This utility generates maps and schedule sheets for your missions and makes it"
                echo "easy to view and change your cockpit settings."
                echo ""
                echo "To install WDP, first download it from this link:"
                echo "https://web.archive.org/web/20160330163200/http://weapondeliveryplanner.nl/files/wdp/Weapon_Delivery_Planner_3.7.2.69.7z"
                echo ""
                echo "This will download Weapon_Delivery_Planner_3.7.2.69, the version of WDP what was tested with BMS432"
                echo ""
                echo "Unpack the .7z compressed file, then copy the Weapon_Delivery_Planner_3.7.2.69 under BMS432"
                echo "Then run this script again."; echo ""
         fi
fi


