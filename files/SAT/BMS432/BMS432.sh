#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# this script requires wine.  On Ubuntu 20.04 or 20.10, install wine via:
# sudo apt install -y wine
#
# 27 Dec 2020


if [ ! -f /usr/bin/wine ]; then
        echo " "
        echo "ERROR: wine not found.  Install wine 5 or later.  If using the recommended Ubuntu 20.04 LTS linux distribution,"
        echo "the command is:"
        echo "sudo apt install -y wine"
        echo "for more information, see https://wiki.winehq.org/Download"
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi




if  wine --version | grep "wine-3";  then
        echo " "
        echo "ERROR: wine version 3 found, but wine version 5 or later is required for esports-for-engineers_3_0."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi

if  wine --version | grep "wine-4";  then
        echo " "
        echo "ERROR: wine version 4 found, but wine version 5 or later is required for esports-for-engineers_3_0."
        echo "Uninstall wine, then download wine 5 using the instructions at https://wiki.winehq.org/Download"
        echo " "
        exit 1
fi


export WINEPREFIX="$PWD/WP"

echo "Before installing the BMS 4.32 free upgrades, you must buy the original Falcon 4 game."; echo ""
echo "You can buy Falcon 4 from gog games at this link:"
echo "https://www.gog.com/game/falcon_collection"; echo ""
echo "or from store.steampowered.com, or you may be able to buy the CD from eBay."; echo ""
echo "copy the file falcon4.exe to WP/drive_c"
echo "BMS 4.32 does not require that Falcon 4 be installed, just that the file falcon4.exe be in the path"

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.32" ]
then
# BMS 4.32 already installed
cd "$WINEPREFIX/drive_c/Falcon BMS 4.32"
clear
echo  "starting Falcon BMS 4.32"; echo ""
wine Launcher.exe -window 2>/dev/null 1>/dev/null
exit 0
fi

# install BMS 4.32
clear
cd "$WINEPREFIX/../INSTALL/"
echo "Installing BMS 4.32 and updates 1-7"
echo "To install, click through the following screens, accepting defaults to install."
echo "the BMS directory is C:\\Falcon BMS 4.32"
echo ""; echo ""
cd "$WINEPREFIX/../INSTALL/Falcon BMS 4.32 Setup Upd. 1-7"
wine Setup.exe 2>/dev/null 1>/dev/null
cd $WINEPREFIX/../INSTALL
echo "";
echo "Installing theater 1 of 2: Balkans"
echo ""
wine Balkans_3.0_setup.exe 2>/dev/null 1>/dev/null
echo "";
echo "Installing theater 2 of 2: Kuwait"
echo ""
cp -R "Add-On Kuwait" "$WINEPREFIX/drive_c/Falcon BMS 4.32/Data/"
cd $WINEPREFIX/../INSTALL/kuwaitLink
cp *.* "$WINEPREFIX/drive_c/Falcon BMS 4.32/Data/Terrdata/theaterdefinition"
#cd "$WINEPREFIX/drive_c/Falcon BMS 4.32/Data/Terrdata/theaterdefinition"
# add Kuwait to the list of theaters
#cat addTotheater.lst >> theater.lst
# cp $WINEPREFIX/../INSTALL/theater.lst 
# initialize cockpit settings: callsign is Viper
cp $WINEPREFIX/../INSTALL/Viper.* "$WINEPREFIX/drive_c/Falcon BMS 4.32/User/Config"
clear
echo  "starting Falcon BMS 4.32"; echo ""
cd "$WINEPREFIX/drive_c/Falcon BMS 4.32"
wine Launcher.exe -window 2>/dev/null 1>/dev/null
exit 0


