#!/bin/bash

# Set the Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Function to display installation instructions
display_install_instructions() {
    clear
    printf "\nCut and paste the commands below at a terminal prompt.\nDo not install mono, if prompted to do so:\n"
    printf "cd TUE/NR2003\n"
    printf "export WINEPREFIX=\$PWD/WP\n"
    printf "winetricks vcrun2003 2>/dev/null 1>/dev/null\n"
    printf "sudo mount -o loop $WINEPREFIX/../INSTALL/NR2003.iso $WINEPREFIX/../isoMnt\n\n"
    printf "then run this script again.\n"
}

# Check if game directory exists
if [ -d "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season" ]; then
    # Navigate to the game directory
    cd "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season"
    
    # Run the game executable
    wine NR2003.exe 2>/dev/null 1>/dev/null
    
    # Clear the screen and display optional scripts information
    clear
    printf "NR2003 Optional Scripts:\n\n"
    printf "Add additional 1960's era cars and tracks:\n$WINEPREFIX/../additionalCarsAndTracks.sh\n\n"
    printf "Change NR2003 track parameters, AI, etc:\n$WINEPREFIX/../trackEditor.sh\n\n\n\n"
    printf "Tip: always run NR2003 with the same version of Wine\nthat was used to install it, to avoid an 'installation\nappears to be incorrect' error message.\n\n"
    
    # Exit the script with success
    exit 0
fi

# Move required files to INSTALL directory
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/NASCAR-Racing-2003-Season_NoCD_Win_EN.zip" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null

# Check if installation files are missing
if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip" ]; then
    clear
    echo "Nascar Racing 2003 install files not found in the directory TUE/NR2003/INSTALL"
    echo ""
    echo "From this link:"; echo ""
    echo "https://www.myabandonware.com/game/nascar-racing-2003-season-cox#download"
    echo ""
    echo "download the following 4 files:"
    echo "1. NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip"
    echo "2. NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe"
    echo "3. NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe"
    echo "4. NASCAR-Racing-2003-Season_NoCD_Win_EN.zip"
    echo ""
    echo "Place these files in the TUE/NR2003/INSTALL directory."
    echo ""
    echo "Then run this script again."
    echo ""
    exit 0
fi

# Check if autorun file exists
if [ -f "$WINEPREFIX/../isoMnt/autorun.exe" ]; then
    # Navigate to the isoMnt directory
    cd "$WINEPREFIX/../isoMnt"
    
    # Display Wine configuration instructions
    clear
    printf "In the Wine configuration dialog, in the Applications tab select Windows Version: Windows XP\n"
    printf "In the Graphics tab, deselect Allow the window manager to decorate the windows,\n"
    printf "select Emulate a virtual desktop,\n"
    printf "and set Desktop size to your monitor display resolution.\n\n"
    printf "Press a key to continue ...\n"
    
    # Run winecfg and wait for user input
    winecfg 2>/dev/null 1>/dev/null
    read -r replyString
    
    # Display installation instructions
    printf "Installing NR2003\n\n"
    printf "Select Install\n"
    printf "Do not select Register or look for updates\n\n"
    printf "When asked for a serial number, enter\nRAB2-RAB2-RAB2-RAB2-8869\n"
    printf "Write down this serial number, as it will not be displayed on the screen during installation.\n"
    printf "Press a key to begin installation ...\n"
    
    # Run autorun and wait for user input
    read -r replyString
    wine autorun.exe 2>/dev/null 1>/dev/null
    clear
    printf "\nPress a key to install the 1201 patch\n"
    read -r replyString
    
    # Navigate to INSTALL directory and install patches
    cd "$WINEPREFIX/../INSTALL"
    wine NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe 2>/dev/null 1>/dev/null
    printf "\nPress a key to install the fix to 1201 patch\n"
    read -r replyString
    
    # Copy executable to game directory
    cp "$WINEPREFIX/../INSTALL/Nascar_Racing_2003_Season_1201_NoCD/NR2003.exe" "$WINEPREFIX/drive_c/Papyrus/NASCAR Racing 2003 Season"
    printf "\n Nascar Racing 2003 Season installed.  To install optional 1960's era cars and tracks in NR2003, run:\n\n"
    printf "$WINEPREFIX/../additionalCarsAndTracks.sh\n\nRun this script again to race.\n"
    exit 0
fi

# Check if required files are missing
clear 
if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe" ]; then 
    printf "INSTALL/NASCAR-Racing-2003-Season_Fix_Win_EN_Fix-for-Version-1201.exe missing\n\n"
    exit 0
fi
if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_NoCD_Win_EN.zip" ]; then
    printf "NASCAR-Racing-2003-Season_NoCD_Win_EN.zip missing\n\n"
    exit 0
fi
if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe" ]; then
    printf "NASCAR-Racing-2003-Season_Patch_Win_EN_Patch-1201.exe missing\n\n"
    exit 0
fi
if [ ! -f "$WINEPREFIX/../INSTALL/NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip" ]; then
    printf "NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip missing\n\n"
    exit 0
fi

# Unpack required files
clear
echo "unpacking files"
cd "$WINEPREFIX/../INSTALL"
unzip NASCAR-Racing-2003-Season_Win_EN_ISO-Version.zip
unzip NASCAR-Racing-2003-Season_NoCD_Win_EN.zip
cd NASCAR_Racing_2003_Season_ISO
bchunk Nascar_Racing_2003_Season.FLT.ShareReactor.BIN Nascar_Racing_2003_Season.FLT.ShareReactor.CUE NR2003.iso 2>/dev/null 1>/dev/null
mv NR2003.iso01.iso "$WINEPREFIX/../INSTALL/NR2003.iso"
wineboot

# Display installation instructions
display_install_instructions

# Exit the script
exit 0

