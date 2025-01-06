#!/bin/bash

# Set the Wine prefix directory
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Function to display installation instructions
display_install_instructions() {
    clear
    printf "\nCut and paste the commands below at a terminal prompt:\n"
    printf "export WINEPREFIX=\$PWD/WP\n"
    printf "winetricks d3dx9 directplay 2>/dev/null 1>/dev/null\n"
    printf "sudo mount -o loop $WINEPREFIX/../INSTALL/Madden.iso $WINEPREFIX/../isoMnt\n\n"
    printf "then run this script again.\n"
}

# Check if game directory exists
if [ -d "$WINEPREFIX/drive_c/Program Files/EA SPORTS/Madden NFL 08" ]; then
    printf "Running CFL football; click and drag on the lower right on the CFL splash screen\n"
    printf "then select click to begin.\n\n"
    printf "Press enter to continue ...\n"
    read -r replyString

    # Handle the use case where, if an ese directory tree with CFL already installed is copied to a new computer, the folder in $HOME/Documents is missing"
    if [ ! -d "$HOME/Documents/Madden NFL 08/MODS" ]; then
         rsync -a  "$WINEPREFIX/../INSTALL/CFLpreinstalled/Madden NFL 08/" "$WINEPREFIX/drive_c/users/$USER/Documents/Madden NFL 08/"
    fi

    cd "$WINEPREFIX/drive_c/Program Files/EA SPORTS/Madden NFL 08"
    wine mainapp.exe 2>/dev/null 1>/dev/null
    exit 0
fi

clear
echo -e "In the Wine configuration dialog box, which appears next, select the 'Graphics' tab."
echo "Select Windows XP as the windows version."
echo "In the Graphics tab, unselect 'Allow the window manager to decorate the windows'"
echo "Set your monitor to max resolution, then select virtual desktop and input your"
echo "monitor resolution."
echo -e "Then select OK to continue the installation.\n"
echo -e "Press enter to display the Wine configuration dialog box."
read -r replyString
winecfg &>/dev/null

clear
echo "Unpacking installation files, this will take a minute ..."
echo ""
# Check for pre-installed archive
if [ -f "$WINEPREFIX/../../tar/CFLpreinstalled.tar.gz" ]; then
    mv "$WINEPREFIX/../../tar/CFLpreinstalled.tar.gz" "$WINEPREFIX/../INSTALL/"
    cd "$WINEPREFIX/../INSTALL"
    tar xzf CFLpreinstalled.tar.gz
#    sudo chmod -R 777 CFLpreinstalled
    
    # Create necessary directories
    mkdir -p "$WINEPREFIX/drive_c/Program Files/EA SPORTS"
    mkdir -p "$WINEPREFIX/drive_c/Program Files/EA SPORTS/Madden NFL 08"
    mkdir -p "$WINEPREFIX/drive_c/users/$USER/Documents/Madden NFL 08"
    
    # Move the installed game directories
#    rsync -a "$WINEPREFIX/../INSTALL/CFLpreinstalled/EA SPORTS/Madden NFL 08/" "$WINEPREFIX/drive_c/Program Files/EA SPORTS/Madden NFL 08/"
    # Use realpath to resolve the actual path
SOURCE_PATH=$(realpath "${WINEPREFIX}/../INSTALL/CFLpreinstalled/EA Sports/Madden NFL 08")
rsync -a "${SOURCE_PATH}/" "${WINEPREFIX}/drive_c/Program Files/EA SPORTS/Madden NFL 08/"
    rsync -a  "$WINEPREFIX/../INSTALL/CFLpreinstalled/Madden NFL 08/" "$WINEPREFIX/drive_c/users/$USER/Documents/Madden NFL 08/"
    
    printf "\nPre-installed Madden NFL 08 with CFL mod has been set up.\n"
    printf "Run this script again to play a Canadian Football League game.\n\n"
    exit 0
fi

# Move required files to INSTALL directory
mv "$WINEPREFIX/../../tar/Madden-NFL-08_Misc_Win_EN_Serial-keys.txt" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../tar/Madden-NFL-08_NoCD_Win_EN_NoDVD.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../tar/Madden-NFL-08_Patch_Win_EN_v3-US.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../tar/Madden-NFL-08_Win_EN_US-ISO.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../tar/JSGME.exe" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../tar/CFL 15 V2.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../tar/Xmod 7-18-14.7z" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null

# Check if installation files exist
if [ ! -f "$WINEPREFIX/../INSTALL/Madden-NFL-08_Win_EN_US-ISO.zip" ]; then
    clear
    echo "Madden NFL 08 install files not found in the INSTALL directory"
    exit 1
fi

# Check if autorun exists in mounted ISO
if [ -f "$WINEPREFIX/../isoMnt/AutoRun.exe" ]; then
    cd "$WINEPREFIX/../isoMnt"
    
    # Configure Wine
    clear
#    printf "Configuring Wine for Madden NFL 08...\n"
#    printf "Windows XP compatibility mode will be set automatically\n"
#    echo "Press ENTER to continue ..."
#    read replyString
    
    WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null
    wine winecfg -v winxp  2>/dev/null 1>/dev/null

    echo "Installing Madden from CD"
    echo "When prompted, enter the serial number J7UL-WFFB-AE12-BMKN-GVTY"
    echo "Press ENTER to continue ..."
    read replyString
    
    # Install game and verify installation
    wine AutoRun.exe 2>/dev/null 1>/dev/null
    
    if [ ! -d "$WINEPREFIX/drive_c/Program Files/EA SPORTS/Madden NFL 08" ]; then
        echo "After installing Madden, run the script again."
	echo "If installation stops with a missing DX 9c error, place"
	echo "CFLpreinstalled.tar.gz in the tar directory and run"
	echo "the script again."
        exit 1
    fi
    
    # Install patch
    cd "$WINEPREFIX/../INSTALL"
    unzip "Madden-NFL-08_Patch_Win_EN_v3-US.zip"
    wine patch.exe 2>/dev/null 1>/dev/null
    
    # Install NoCD
    unzip "Madden-NFL-08_NoCD_Win_EN_NoDVD.zip"
    cp mainapp.exe "$WINEPREFIX/drive_c/Program Files/EA SPORTS/Madden NFL 08/"
    
    # Create Mods structure
    mkdir -p "$WINEPREFIX/drive_c/users/$USER/My Documents/Madden NFL 08/MODS/X mod"
    
    # Extract and install mods
    7z x "Xmod 7-18-14.7z" -o"$WINEPREFIX/drive_c/users/$USER/My Documents/Madden NFL 08/MODS/X mod"
    unzip "CFL 15 V2.zip"
    mv Rosters "$WINEPREFIX/drive_c/users/$USER/My Documents/Madden NFL 08/"
    mv "MODS/CFL 15 V2" "$WINEPREFIX/drive_c/users/$USER/My Documents/Madden NFL 08/MODS/"
    
    # Install JSGME
    cp JSGME.exe "$WINEPREFIX/drive_c/users/$USER/My Documents/Madden NFL 08/"
    
    # Set compatibility mode
    winetricks winxp 2>/dev/null 1>/dev/null
    
    printf "\nMadden NFL 08 installed with CFL mod.\n"
    printf "Run JSGME.exe to enable X mod first, then CFL 15 mod.\n"
    printf "Run this script again to play the game.\n"
    exit 0
fi

# Unpack required files
clear
echo "Unpacking files..."
cd "$WINEPREFIX/../INSTALL"
unzip "Madden-NFL-08_Win_EN_US-ISO.zip"
mv "Madden NFL 08 (USA).iso" "Madden.iso"
wineboot

# Display installation instructions
display_install_instructions
exit 0
