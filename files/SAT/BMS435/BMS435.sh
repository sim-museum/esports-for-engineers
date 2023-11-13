#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# To install BMS 4.35, 
# 1. Install a Ubuntu 22.04 LTS linux partition
# 2. Check that your graphics drivers are up to date via
#         sudo ubuntu-drivers devices
#         sudo ubuntu-drivers autoinstall
# 3. Use the offline version of wine-7.6 (Staging) included with esports-for-engineers-v22_04
#         or install the winehq-staging version of wine via 
#         sudo dpkg --add-architecture i386
#         wget -nc https://dl.winehq.org/wine-builds/winehq.key
#         sudo apt-key add winehq.key
#         sudo add-apt-repository 'deb https://dl.winehq.org/wine-builds/ubuntu/ jammy main'
#         sudo apt update
#         sudo apt install --install-recommends winehq-staging
#         sudo apt install winetricks
#         sudo apt winetricks --self-update
# 4. buy and download a copy of the original falcon 4.0 version 1.08  (available from https://www.gog.com/game/falcon_collection) and
# copy the Falcon4 directory under WP/drive_c/Microprose
# 3. run ./BMS435.sh
if [ ! -f /usr/bin/wine ]; then
        echo " "
	echo "ERROR: wine not found.  Run ./wine_experimental.sh in the base esports for engineers directory to install wine."
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi

if  wine --version | grep "wine-5";  then
        echo " "
	echo "ERROR: A later version of wine is required in order to run BMS 4.35  Run ./wine_experimental.sh in the base esports for engineers directory to install wine."
        echo "Note: wine is the MS Windows emulation layer for linux.  It runs MS Windows programs under linux."
        echo " "
        exit 1
fi


export WINEPREFIX="$PWD/WP"

if [ -d "$WINEPREFIX/drive_c/Falcon BMS 4.35" ]
then
# BMS 4.35 already installed
cd "$WINEPREFIX/drive_c/Falcon BMS 4.35"
clear

#if wine --version | grep "wine-7"; then
#        clear
#        printf "Version 7.x of wine detected.\nAlthough installation requires wine 7, Falcon BMS 4.35 runs best with wine 6.0.\n\nFrom the esports-for-engineers directory, run \n\n./wine_default.sh\n\nto switch to wine 6.0.\n\nThen run this script again.\n\n"
#        exit 0
#fi

echo  "starting Falcon BMS 4.35"; echo ""
#echo "If a "falcon bms.exe" is not responding warning dialog appears,"
#echo "select Wait or simply do nothing; the dialog box will disappear in a few seconds."
#echo "Set your BMS 4.35 rudder and throttle axes for your joystick in Setup/Controller/Advanced options."
#echo ""; echo "Note: the Weapon Delivery Planner utility is recommended."
#echo "You can download this utility at http://www.weapondeliveryplanner.nl/"; echo ""
echo ""

#echo "technical note: BMS 4.35 uses the Microsoft Direct X 11 (DX11) graphics library"
#echo "and is best used with the linux vulcan (dxvk) drivers.  All other wine games"
#echo "in the esports-for-engineers suite use DX9 or earlier versions"
#echo "The TUE, SAT and other SUN games can be run with vulkan, but there"
#echo "is no significant speedup from doing so."
#echo ""

wine Launcher.exe -nomovie 2>/dev/null 1>/dev/null
exit 0
fi

if [ ! -d "$WINEPREFIX/drive_c/MicroProse/Falcon4" ]
then
   clear

if wine --version | grep "wine-6.0"; then
        clear
        printf "Version 6.0 of wine detected.\nFor installation, Falcon BMS 4.35 requires wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine_experimental.sh\n\nto install wine 7.\n\nThen run this script again.\n\n"
        exit 0
fi



   echo "WP/drive_c/MicroProse/Falcon4/ directory not found."; echo ""   
   echo "Before installing the BMS 4.35 free upgrades, you must buy and install the original Falcon 4 game."; echo ""
   echo "You can buy Falcon 4.0 version 1.08 from gog games at this link:"
   echo "https://www.gog.com/game/falcon_collection"; echo ""
   echo "copy the Falcon4 directory under WP/drive_c/MicroProse/"
   echo "or, if you have falcon4 in iso format, install as follows,"
   echo "accepting defaults and ignoring warning messages:"; echo " "
   echo "1. export WINEPREFIX=$PWD/WP"
   echo "2. sudo mount -o loop <path>/falcon4Cd.iso $WINEPREFIX/../INSTALL/isoMnt"
   echo "3. cd $WINEPREFIX/../INSTALL/isoMnt"
   echo "4. wine Setup.exe 2>/dev/null 1>/dev/null"
   echo " "
   echo "Click through the dialog boxes and ignore error messages by selecting, e.g., OK, Next, Register Later.  When prompted to install wine mono, do not install it."
   echo "5. cd .."
   echo ""
   echo "after you've installed the original MicroProse Falcon 4,"
   echo "COMPLETE ALL 4 STEPS ABOVE, and then"
   echo "run this script again to upgrade to Falcon BMS version 4.35"
   echo ""; echo ""
   exit 1
fi


# Falcon4 installed, now install BMS 4.35
clear
#echo "Before installing BMS 4.35, issue these commands from the command line:"; 
#echo "Note that after you issue the ./setWineDisplayResolution.sh command,"
#echo "In the wine configuration graphics tab, select virtual desktop and enter your desktop size."
#echo "you will be asked whether to install mono. Do not install mono."; echo ""

echo "Note: the Weapon Delivery Planner utility is recommended."
echo "You can download this utility at http://www.weapondeliveryplanner.nl/"; echo ""
printf "\n\nBefore running BMS4.35, you must issue the following 3 commands in a terminal window:\n1. export WINEPREFIX=\""$PWD"/WP\"\n2. winetricks dxvk 2>/dev/null 1>/dev/null\nAlso, if you plan to install the optional Weapon Delivery Planner,\nissue the additional command:\nwinetricks dotnet48\n\nIf you have issued these commands, press a key.  If not, \nhalt this script with CONTROL C,\nissue the commands and then run this script again.\n\nPress a key to continue\n\n"

read relyString

mv "$WINEPREFIX/../../../tar/Falcon BMS 4.35 Setup (Full).zip" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

cd "$WINEPREFIX/../INSTALL"

if [ ! -f 'Falcon BMS 4.35 Setup (Full).zip' ]
then
	clear
	printf "Download this file:\n\n'Falcon BMS 4.35 Setup (Full).zip'\n\nfrom www.falcon-bms.com and put it in the "$WINEPREFIX"/../INSTALL directory.\nThen run this script again.\n\n"
	exit 0
fi
echo "Unpacking INSTALL/'Falcon BMS 4.35 Setup (Full).zip'"
unzip 'Falcon BMS 4.35 Setup (Full).zip'
cd $WINEPREFIX/../INSTALL/'Falcon BMS 4.35 Setup'
echo "Installing BMS 4.35.3"
echo "To install, click through the following screens, accepting defaults to install."
echo "" 
echo "Installing BMS 4.35"
echo ""
wine Setup.exe 2>/dev/null 1>/dev/null

# initialize cockpit settings: callsign is Viper
cp $WINEPREFIX/../INSTALL/Viper.ini "$WINEPREFIX/drive_c/Falcon BMS 4.35/User/Config"
cp $WINEPREFIX/../INSTALL/Viper.lbk "$WINEPREFIX/drive_c/Falcon BMS 4.35/User/Config"
cp $WINEPREFIX/../INSTALL/Viper.pop "$WINEPREFIX/drive_c/Falcon BMS 4.35/User/Config"
cp $WINEPREFIX/../INSTALL/Viper.plc "$WINEPREFIX/drive_c/Falcon BMS 4.35/User/Config"
echo "" 
#echo "Backing up the windows container (which is the "wine prefix" WP directory) ..."
#echo ""
#cd $WINEPREFIX/..
#$WINEPREFIX/../backup.sh WP newBMS435InstallDirectory
clear
printf "Falcon BMS 4.35.3 installed.\n\nNext steps are:\n\n1. install optional add-on theaters; Iran/Iraq/Kuwait, Balkans, Israel, Somalia, Vietnam and Taiwan are available.\n\n2. run "$WINEPREFIX"/../INSTALL/bmsPatch.sh to patch the theaters.\n\n3. install optional utilities via "$WINEPREFIX"/../INSTALL/tacview.sh, "$WINEPREFIX"/../INSTALL/weaponDeliveryPlanner.sh and "$WINEPREFIX"/../INSTALL/missionCommander.sh\n4. If installed theaters are not listed in BMS, run\n
"$WINEPREFIX"/../runIfTheaterMissing.sh\n\n"
exit 0
echo " "

