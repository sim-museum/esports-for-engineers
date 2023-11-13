export WINEPREFIX=$PWD/WP

		clear; echo "installing Weapon Delivery Planner"; echo ""
		echo "Install libraries needed by Weapon Delivery Planner via these two commands:"
		echo "winetricks dotnet48"
		echo "winetricks mdac28 jet40"
		echo "If you haven't already, press <CTRL> C, run the two winetricks commands and then"
		echo "run this script again."
		echo ""
		echo "If you've already run these two winetricks commands, press ENTER to continue."
		read replyString

cd $WINEPREFIX/../INSTALL/wdp
wine WeaponDeliveryPlanner.exe
