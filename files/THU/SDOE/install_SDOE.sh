# Script Outline:
# 1. Check if SDOE is already installed.
# 2. Move required files to INSTALL directory.
# 3. Check if installation files exist.
# 4. Provide instructions for Wine configuration and installation.
# 5. Begin installation process.
# 6. Script ends.

#!/bin/bash

# Set WINEPREFIX
export WINEPREFIX="$PWD/WP"

# Define variables for readability
INSTALL_DIR="$WINEPREFIX/../INSTALL"

# Check if SDOE is already installed
if [ -f "$WINEPREFIX/drive_c/Program Files/Fighter Squadron/Sdemons.exe" ] && \
   [ -f "$WINEPREFIX/drive_c/Program Files/FS-WWI/Sdemons.exe" ]; then
    clear
    printf "SDOE already installed. Run ./WWI_SDOE.sh for the World War I aircraft or ./WWII_SDOE.sh for the World War II aircraft.\n\n  SDOE is a Windows 98 flight simulator known for its flight and damage models.\n\n"
    exit 0
elif [ -f "$WINEPREFIX/drive_c/Program Files/FS-WWI/Sdemons.exe" ]; then
    printf "SDOE WWII planes already installed. Run ./installSDOE.sh and install the WWI aircraft next.\n\n"
    exit 0
fi

# Move required files to INSTALL directory
mv "$WINEPREFIX/../../../tar/Fighter_Squadron_SDOE_DVD.iso" "$INSTALL_DIR" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/fspatch150.exe" "$INSTALL_DIR" 2>/dev/null 1>/dev/null

# Check if installation files exist
if [ ! -f "$INSTALL_DIR/Fighter_Squadron_SDOE_DVD.iso" ]; then
    clear
    printf "Fighter Squadron: Screaming Demons Over Europe (SDOE) install files not found in the directory $INSTALL_DIR.\n\n"
    printf "Download the files from: https://www.myabandonware.com/game/fighter-squadron-the-screamin-demons-over-europe-evp#download\n"
    printf "Place these files in the THU/FighterSquadron/INSTALL directory, then run this script again.\n\n"
    exit 0
elif [ ! -f "$INSTALL_DIR/isoMnt/FILES/SDOEDVD.exe" ]; then
    clear
    printf "In the Wine Configuration Dialog that follows:\n1. In the application tab, select WINDOWS 98.\n2. In the graphics tab, deselect 'Allow the window manager to decorate the windows'.\n3. Select virtual Desktop with resolution of AT LEAST 1024x768, otherwise the install dialog box will not fit on the screen.\n4. Then select OK to continue the installation.\n\nPress a key to continue.\n\n"
    read -r replyString
    WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null
    printf "\nTo install Fighter Squadron, run the following command in a terminal:\n\nsudo mount -o loop "$WINEPREFIX/../INSTALL/Fighter_Squadron_SDOE_DVD.iso" "$WINEPREFIX/../INSTALL/isoMnt"\n\nThen run this script again.\n"
    exit 0
fi

# Unpack files and begin installation
if [ -f "$INSTALL_DIR/isoMnt/FILES/SDOEDVD.exe" ]; then
    cd "$INSTALL_DIR/isoMnt/FILES"
    clear
    printf "Fighter Squadron installation instructions:\n\n1. If asked whether to install Mono, do not install it.\n2. Install the WWII content.\n3. After installing, deselect fly. Select Exit.\n4. Repeat with the WWI content.\n\nPress a key to begin installation.\n\n"
    read -r replyString
    wine "SDOEDVD.exe" 2>/dev/null 1>/dev/null
    cd "$INSTALL_DIR"
    wine fspatch150.exe 2>/dev/null 1>/dev/null
    printf "\n\nInstallation completed. Run ./WWI_SDOE.sh or ./WWII_SDOE.sh\n"
    exit 0
fi

