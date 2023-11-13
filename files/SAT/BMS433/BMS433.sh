#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# This script requires that wine be installed.
# On Ubuntu 20.04 or 20.10 the command to install wine is
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

if [ ! -d "$WINEPREFIX/drive_c/MicroProse/Falcon4" ]
then
   clear
   echo "WP/drive_c/MicroProse/Falcon4/ directory not found."; echo ""   
   echo "Before installing the BMS 4.33 free upgrades, you must buy and install the original Falcon 4.0 game."; echo ""
   echo "You can buy Falcon 4 from gog games at this link:"
   echo "https://www.gog.com/game/falcon_collection"; echo ""
   echo "copy the Falcon4 directory under WP/drive_c/MicroProse/"
   echo "or, if you have falcon4 in iso format, install as follows:"
   echo "export WINEPREFIX=$PWD/WP"
   echo "mkdir isoDrive"
   echo "sudo mount -o loop falcon4.iso isoDrive"
   echo "cd isoDrive"
   echo "wine Setup.exe"
   echo ""
   echo "after you've installed the original MicroProse Falcon 4,"
   echo "run this script again to install the BMS 4.33 add-on"
   echo ""; echo ""
   exit 1
fi

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.33 U1" ]
then
# BMS 4.33 already installed
cd "$WINEPREFIX/drive_c/Falcon BMS 4.33 U1"
clear
echo  "starting Falcon BMS 4.33"; echo ""
wine Launcher.exe -window 2>/dev/null 1>/dev/null
exit 0
fi

# Falcon4 installed, now install BMS 4.33
clear
cd "$WINEPREFIX/../INSTALL/baseInstall"
echo "Instaling BMS 4.33 and updates 2-5"
echo "To install, click through the following screens, accepting defaults to install."
echo ""; echo ""
# copy BMS 4.33 into the WP wine prefix directory tree
unzip Falcon_BMS_4.33_U1_Setup.zip -d $WINEPREFIX/drive_c/
# now install the updates 2-5
echo ""; echo "Installing BMS 4.33 update 2 out of 5"; echo ""
wine Falcon_BMS_4.33_U2_Incremental.exe 2>/dev/null 1>/dev/null
echo ""; echo "Installing BMS 4.33 update 3 out of 5"; echo ""
wine Falcon_BMS_4.33_U3_Incremental.exe 2>/dev/null 1>/dev/null
echo ""; echo "Installing BMS 4.33 update 4 out of 5"; echo ""
wine Falcon_BMS_4.33_U4_Incremental.exe 2>/dev/null 1>/dev/null
echo ""; echo "Installing BMS 4.33 update 5 out of 5"; echo ""
wine Falcon_BMS_4.33_U5_Incremental.exe 2>/dev/null 1>/dev/null
cd "$WINEPREFIX/../INSTALL/"
echo ""; 
echo "Installing theater 1 of 3: Balkans"
echo ""
wine Balkans_Theater_4.33.3_v3.6.exe
echo "";
echo "Installing theater 2 of 3: Vietnam"
echo ""
cd vietnam
wine Add-On\ Vietnam\ Vietnam\ v1.0.exe
echo "Installing Vietnam Tactical Engagement: March 1972 Offensive"; 
cd ..
cd "Vietnam TE"
unzip "One Day in a Long War.zip" -d "$WINEPREFIX/drive_c/Falcon BMS 4.33 U1/Data/Add-On Vietnam/Campaign/"
cd "$WINEPREFIX/../INSTALL/somalia"
echo "";
echo "Installing theater 3 of 3: Somalia"
echo ""
wine Add-On\ Somalia\ 1.0.exe

# initialize cockpit settings: callsign is Viper
cp $WINEPREFIX/../INSTALL/Viper.ini "$WINEPREFIX/drive_c/Falcon BMS 4.33 U1/User/Config"

cd "$WINEPREFIX/drive_c/Falcon BMS 4.33 U1"
clear
echo  "starting Falcon BMS 4.33"; echo ""
wine Launcher.exe -window 2>/dev/null 1>/dev/null
exit 0


