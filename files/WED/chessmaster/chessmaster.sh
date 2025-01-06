# Script Outline:
# 1. Sets Wine prefix to the "WP" folder in the current directory.
# 2. Checks if Chessmaster executable exists and runs it if found, displaying optional scripts.
# 3. Moves installation files to the "INSTALL" directory.
# 4. Checks if Chessmaster installation files are present; if not, prompts the user to download them.
# 5. If ISO file is not found, unpacks Chessmaster ISO file and provides instructions for mounting.
# 6. If setup.exe is found in the mounted ISO directory, provides installation instructions, runs setup.exe using Wine, applies patch, and displays completion message.
# 7. End of script.
#!/bin/bash

# Set the Wine prefix to the current directory's "WP" folder
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Check if Chessmaster executable exists
if [ -f "$WINEPREFIX/drive_c/Program Files/Ubisoft/Chessmaster Grandmaster Edition/Chessmaster.exe" ]; then
    # Navigate to Chessmaster directory
    cd "$WINEPREFIX/drive_c/Program Files/Ubisoft/Chessmaster Grandmaster Edition"
    # Run Chessmaster
    wine Chessmaster.exe >/dev/null 2>&1
    # Clear the terminal
    clear
    # Display optional scripts
    printf "Chessmaster optional scripts\n\nConvert chessmaster output pgn into standard format:\nfixAnnotationsInChessmasterOutputPgnFile.sh\n\n"
    exit 0
fi

# Move installation files to INSTALL directory
mv "$WINEPREFIX/../../../tar/Chessmaster-Grandmaster-Edition_Win_EN-FR.zip" "$WINEPREFIX/../INSTALL" >/dev/null 2>&1
mv "$WINEPREFIX/../../../tar/Chessmaster-Grandmaster-Edition_Patch_Win_EN-FR_patch-v102.exe" "$WINEPREFIX/../INSTALL" >/dev/null 2>&1

# Check if Chessmaster installation files are present
if [ ! -f "$WINEPREFIX/../INSTALL/Chessmaster-Grandmaster-Edition_Win_EN-FR.zip" ]; then
    # Display instructions for obtaining installation files
    clear
    echo "Chessmaster install files not found in the directory $WINEPREFIX/../INSTALL/"
    echo ""
    echo "Download the following 2 files from the link below:"
    echo "1. Chessmaster-Grandmaster-Edition_Win_EN-FR.zip" 
    echo "2. Chessmaster-Grandmaster-Edition_Patch_Win_EN-FR_patch-v102.exe" 
    echo ""
    echo "Place these files in the $WINEPREFIX/../INSTALL/ directory."
    echo ""
    echo "Then run this script again."
    echo ""
    exit 0
else        
    if [ ! -f "$WINEPREFIX/../INSTALL/itw-cge.iso" ]; then
        # Unpack Chessmaster ISO file
        echo "Unpacking Chessmaster ISO file in $WINEPREFIX/../INSTALL/chessmaster"
        cd "$WINEPREFIX/../INSTALL/"
        unzip Chessmaster-Grandmaster-Edition_Win_EN-FR.zip >/dev/null 2>&1
        clear
        # Display instructions for mounting ISO
        printf "To install Chessmaster, run the following command in a terminal,\nthen run this script again.\n\nsudo mount -o loop "$WINEPREFIX"/../INSTALL/itw-cge.iso "$WINEPREFIX"/../INSTALL/isoMnt\n"
        exit 0
    fi
    if [ -f "$WINEPREFIX/../INSTALL/isoMnt/Chessmaster Grandmaster Edition En/setup.exe" ]; then
        # Navigate to ISO mounted directory
        cd "$WINEPREFIX/../INSTALL/isoMnt/Chessmaster Grandmaster Edition En"
        clear
        # Display installation instructions
        printf "Chessmaster installation instructions:\n\n1. If asked whether to install Mono, do not install it.\n2. Do not install the Adobe PDF reader (clear the checkbox next to Adobe).\n3. After Chessmaster is installed and the update dialog appears, exit from Chessmaster.\n\nPress any key to begin installation.\n\n"
        read replyString
        # Run setup.exe using Wine
        wine setup.exe >/dev/null 2>&1
        cd "$WINEPREFIX/../INSTALL/"
        # Apply patch
        wine Chessmaster-Grandmaster-Edition_Patch_Win_EN-FR_patch-v102.exe >/dev/null 2>&1
        printf "\nInstallation completed. Run this script again to start Chessmaster.\n"
        exit 0
    fi
fi

# End of script

