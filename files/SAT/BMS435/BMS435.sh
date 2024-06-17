# Script Outline:
# 1. Set Wine prefix directory.
# 2. Check if Falcon BMS 4.35 is already installed, if yes, start it.
# 3. Check Wine version, if it's 6.0, notify the user.
# 4. Provide instructions if Falcon4 directory is missing.
# 5. Notify user about the Weapon Delivery Planner utility.
# 6. Check and move Falcon BMS setup file to installation directory.
# 7. Unpack Falcon BMS setup file.
# 8. Install Falcon BMS 4.35.
# 9. Copy configuration files.
# 10. Provide final instructions.

#!/bin/bash

# Set the Wine prefix directory
WINEPREFIX="$PWD/WP"

# Define common directory paths for readability
INSTALL_DIR="$WINEPREFIX/../INSTALL"
FALCON_DIR="$WINEPREFIX/drive_c/Falcon BMS 4.35"

# Check if Falcon BMS 4.35 is already installed
if [ -d "$FALCON_DIR" ]; then
    cd "$FALCON_DIR"
    clear
    echo "Starting Falcon BMS 4.35"; echo ""
    wine Launcher.exe -nomovie 2>/dev/null 1>/dev/null
    exit 0
fi

# Check Wine version, if it's 6.0, notify the user to upgrade
if wine --version | grep "wine-6.0"; then
    clear
    printf "Version 6.0 of Wine detected.\nFalcon BMS 4.35 requires Wine version 7 or greater.\n\nFrom the esports-for-engineers directory, run \n\n./wine_experimental.sh\n\nto install Wine 7.\n\nThen run this script again.\n\n"
    exit 0
fi

if [ ! -d "$WINEPREFIX/drive_c/MicroProse/Falcon4" ]
then
   # Notify user about missing directories and provide instructions
   clear
   echo "WP/drive_c/MicroProse/Falcon4/ directory not found."; echo ""   
   echo "Before installing the BMS 4.35 free upgrades, you must buy and install the original Falcon 4 game."; echo ""
   echo "You can buy Falcon 4.0 version 1.08 from GOG Games at this link:"
   echo "https://www.gog.com/game/falcon_collection"; echo ""
   echo "Copy the Falcon4 directory under WP/drive_c/MicroProse/"
   echo "or, if you have Falcon4 in ISO format, install as follows,"
   echo "accepting defaults and ignoring warning messages:"; echo " "
   echo "1. export WINEPREFIX=$PWD/WP"
   echo "2. sudo mount -o loop <path>/falcon4Cd.iso $WINEPREFIX/../INSTALL/isoMnt"
   echo "3. cd $WINEPREFIX/../INSTALL/isoMnt"
   echo "4. wine Setup.exe 2>/dev/null 1>/dev/null"
   echo " "
   echo "Click through the dialog boxes and ignore error messages by selecting, e.g., OK, Next, Register Later. When prompted to install Wine Mono, do not install it."
   echo "5. cd .."
   echo ""
   echo "After you've installed the original MicroProse Falcon 4,"
   echo "COMPLETE ALL 4 STEPS ABOVE, and then"
   echo "run this script again to upgrade to Falcon BMS version 4.35"
   echo ""; echo ""
   exit 1
fi


# Notify user about Weapon Delivery Planner utility
clear
echo "Note: the Weapon Delivery Planner utility is recommended."
echo "You can download this utility at http://www.weapondeliveryplanner.nl/"; echo ""
printf "\n\nBefore running BMS4.35, you must issue the following 3 commands in a terminal window:\n1. export WINEPREFIX=\""$PWD"/WP\"\n2. winetricks dxvk 2>/dev/null 1>/dev/null\nAlso, if you plan to install the optional Weapon Delivery Planner,\nissue the additional command:\nwinetricks dotnet48\n\nIf you have issued these commands, press a key.  If not, \nhalt this script with CONTROL C,\nissue the commands and then run this script again.\n\nPress a key to continue\n\n"
read relyString

# Move Falcon BMS setup file to installation directory
mv "$WINEPREFIX/../../../tar/Falcon BMS 4.35 Setup (Full).zip" "$INSTALL_DIR" 2>/dev/null 1>/dev/null

# Check if Falcon BMS setup file exists in installation directory
cd "$INSTALL_DIR"
if [ ! -f 'Falcon BMS 4.35 Setup (Full).zip' ]; then
    clear
    printf "Download this file:\n\n'Falcon BMS 4.35 Setup (Full).zip'\n\nfrom www.falcon-bms.com and put it in the "$WINEPREFIX"/../INSTALL directory.\nThen run this script again.\n\n"
    exit 0
fi

# Unpack Falcon BMS setup file
echo "Unpacking INSTALL/'Falcon BMS 4.35 Setup (Full).zip'"
unzip 'Falcon BMS 4.35 Setup (Full).zip'
cd "$INSTALL_DIR/Falcon BMS 4.35 Setup"

# Install Falcon BMS 4.35
echo "Installing BMS 4.35.3"
echo "To install, click through the following screens, accepting defaults to install."
echo "" 
echo "Installing BMS 4.35"
echo ""
wine Setup.exe 2>/dev/null 1>/dev/null

# Copy configuration files
cp "$INSTALL_DIR/Viper.ini" "$FALCON_DIR/User/Config"
cp "$INSTALL_DIR/Viper.lbk" "$FALCON_DIR/User/Config"
cp "$INSTALL_DIR/Viper.pop" "$FALCON_DIR/User/Config"
cp "$INSTALL_DIR/Viper.plc" "$FALCON_DIR/User/Config"

# Final instructions
echo "" 
clear
printf "Falcon BMS 4.35.3 installed.\n\nNext steps are:\n\n1. install optional add-on theaters; Iran/Iraq/Kuwait, Balkans, Israel, Somalia, Vietnam and Taiwan are available.\n\n2. run "$WINEPREFIX"/../INSTALL/bmsPatch.sh to patch the theaters.\n\n3. install optional utilities via "$WINEPREFIX"/../INSTALL/tacview.sh, "$WINEPREFIX"/../INSTALL/weaponDeliveryPlanner.sh and "$WINEPREFIX"/../INSTALL/missionCommander.sh\n4. If installed theaters are not listed in BMS, run\n
"$WINEPREFIX"/../runIfTheaterMissing.sh\n\n"

