# Script Outline:
#
# This script automates the installation process for rFactor along with various carsets and tracks.
# It assumes that Wine is properly configured and rFactor is being installed in a Wine environment.
# This script checks for the presence of the rFactor game installation. If found,
# it executes the game and provides optional scripts. If not found, it guides
# the user through the process of installing rFactor and configuring it.
# Configures Wine using winecfg.
# Installs rFactor using a mounted ISO.
# Copies necessary files including the rFactor executable to its installation directory.
# Installs various carsets and tracks required for the game.
# Provides instructions to the user regarding setup and configuration after installation.

#!/bin/bash

# Set the WINEPREFIX environment variable
export WINEPREFIX=$PWD/WP
export WINEARCH=win32
wine winecfg -v winxp   2>/dev/null 1>/dev/null

# Check if rFactor is already installed
if [ -f "$WINEPREFIX/drive_c/Program Files/rFactor/rFactor.exe" ]; then
    # If rFactor is installed, execute it
    cd "$WINEPREFIX/drive_c/Program Files/rFactor"
    wine rFactor.exe 2>/dev/null 1>/dev/null
    clear
    # Provide optional scripts for rFactor
    printf "rFactor Optional Scripts\n\nTelemetry:\n$WINEPREFIX/../addTelemetryLoggerToRfactor.sh\n\nImprove AI:\n$WINEPREFIX/../offlineAIimprovement_rFactor.sh\n\nConfigure Graphics:\n$WINEPREFIX/../graphicsConfig_rFactor.sh\n\nTip: to become owner of all cars in a mod, type the code \"ISI_BABYFACTORY\" in\nthe chat window. (The chat window is at lower left on the screen just before\nyou enter the 3D view.)\n\n"
    exit 0
fi

# Move rFactor installation archive to appropriate location
mv "$WINEPREFIX/../../../tar/rFactorINSTALL_22_04_LTS.tar.gz" "$WINEPREFIX/../INSTALL" 2>/dev/null 1>/dev/null

# Check if rFactor installation archive exists
if [ ! -f "$WINEPREFIX/../INSTALL/rFactorINSTALL_22_04_LTS.tar.gz" ]; then
    clear
    # Provide instructions for downloading rFactor
    printf "rFactor 67 cars and tracks not found. Download rFactorINSTALL_22_04_LTS.tar.gz from:\n\nhttps://www.mediafire.com/file/eihpdopiwdf0odz/rFactorINSTALL_22_04_LTS.tar.gz/file\n\nwith this checksum\n\nc8a14b5f879de47c8ebe20f6e481406096e71d4218e4fb8969efa39e4c81338e rFactorINSTALL_22_04_LTS.tar.gz\n\nand place it in $WINEPREFIX/../INSTALL. Then run this script again.\n\n"
    exit 0
fi

# Check if newTracks directory exists
if [ ! -d "$WINEPREFIX/../INSTALL/newTracks" ]; then
    # Unpack cars and tracks
    cd "$WINEPREFIX/../INSTALL/"
    clear
    printf "Press a key to start unpacking cars and tracks. This takes a few minutes.\n\n"
    tar xzf rFactorINSTALL_22_04_LTS.tar.gz
    rsync -a rFactorINSTALL_22_04_LTS/ "$WINEPREFIX/../INSTALL/"
    rm -rf rFactorINSTALL_22_04_LTS
fi

# Check if rFactor.exe exists after installation
if [ ! -f "$WINEPREFIX/drive_c/Program Files/rFactor/rFactor.exe" ]; then
    # Provide installation instructions
    if [ -f "$WINEPREFIX/../INSTALL/isoMnt/Setup.exe" ]; then
               clear
        printf "In the Wine configuration dialog box, which appears next, select Windows XP,"
	printf "select the 'Graphics' tab.\nUnselect allow window manager to decorate windows."
        echo "Select Virtual Desktop and set the desktop size to your monitor resolution."
        echo "Then select OK to continue the installation."
        echo ""
        echo "Press enter to display the Wine configuration dialog box."
        echo ""
        echo "Later, when you reach the rFactor Video Setup screen, choose"
        echo "Shader Level: Quality (DX9), Anti-Aliasing: Level 4, select the Windowed"
        echo "tic box and leave the input field to the right of "
        echo "Resolution:"
        echo "blank."
        echo "In the next window, Completing the rFactor Setup Wizard, unselect Run rFactor"
        echo "so the script can proceed to install additional cars and tracks."
        read replyString
        # Launch winecfg to configure Wine (silently)
        export WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null
        wine winecfg -v winxp  2>/dev/null 1>/dev/null
	
	clear
        echo "If dxvk is not installed, type CONTROL C and install dxvk via the two commands "
	echo "below, then run this script again:"
        echo "export WINEPREFIX=\$PWD/WP"
        echo "export WINEARCH=win32"
        echo "wine winecfg -v winxp"
        echo "winetricks dxvk  2>/dev/null 1>/dev/null"
        echo ""
        echo "Otherwise, type ENTER to continue ..."
        read replyString
 
        # Inform the user about the installation process
        echo ""
        echo "Installing using mounted rFactor iso ..."
        echo ""
        
        # Provide instructions to the user
        echo "Untick 'Run rFactor' in the 'Completing the rFactor Setup Wizard' dialog box"
        echo "Install directx."
        echo "After the 1958 and 1967 carsets are added, along with several period tracks,"
        echo "rFactor will run. After rFactor starts, choose customize."
        echo "In Customize/Player, choose customize player racing series."
        echo "Choose either '1958 Forumula One World Championship' or"
        echo "'F1 Legends Racing v2.03', which is the 1967 carset"
        echo "In Customize/Vehicle choose a car and select 'buy car'"
        echo "In Customize/Settings/Difficulty turn off automatic shifting and all other driver aids."
        echo "If the 3D view appears too dark, increase monitor brightness setting."
        echo ""
        
        # Run the rFactor setup executable (silently)
        wine "$WINEPREFIX/../INSTALL/isoMnt/Setup.exe" 2>/dev/null 1>/dev/null
        
        # Copy rFactor executable to its installation directory (silently)
        cp "$WINEPREFIX/../../../tar/rFactor.exe" "$WINEPREFIX/drive_c/Program Files/rFactor/" 2>/dev/null 1>/dev/null
       
        # Set directory paths
        formula_e_dir="$WINEPREFIX/../INSTALL/Bravo Formula E 2019-20 Mod/"
        f1_1958_dir="$WINEPREFIX/../INSTALL/F1 1958 by ORM - v4.35 COMPLETE/F1 1958 by ORM - v4.35 COMPLETE/"
        f1_1958_noDir="$WINEPREFIX/../INSTALL/F1 1958 by ORM - v4.35 COMPLETE/F1 1958 by ORM - v4.35 COMPLETE"
        f1lr_mod_dir="$WINEPREFIX/../INSTALL/F1LR_mod_V203/Mod/"
        rfactor_dir="$WINEPREFIX/drive_c/Program Files/rFactor/"

        # Inform about and install the 2019 Formula E carset
        echo ""
        echo "Installing 2019 Formula E carset"
        echo ""
        rsync -a "$formula_e_dir" "$rfactor_dir"
        
        # Inform about and install the 1958 carset
        echo ""
        echo "Installing 1958 carset"
        echo ""
        mv "$f1_1958_noDir/Gamedata" "$f1_1958_noDir/GameData"
        rsync -a "$f1_1958_dir" "$rfactor_dir"
        
        # Inform about and install the 1967 carset
        echo ""
        echo "Installing 1967 carset"
                echo ""
        rsync -a "$f1lr_mod_dir" "$rfactor_dir"


	# Inform about and install various tracks
        echo ""
        echo "Installing 60's sportscars Historix1.9 (large: takes 4 minutes to load)"
        echo ""
        rsync -a "$WINEPREFIX/../INSTALL/Historix1.9/Historix/" "$WINEPREFIX/drive_c/Program Files/rFactor/"
        
        echo ""
        echo "Installing 60's tracks:"
        echo ""

        rsync -a "$WINEPREFIX/../INSTALL/newTracks/FDsign Spa58 Rfactor/" "$WINEPREFIX/drive_c/Program Files/rFactor/GameData/"
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/Aintree 1955 v1 by jpalesi/" "$WINEPREFIX/drive_c/Program Files/rFactor/"
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/Imola1960s_v1.0/GameData/" "$WINEPREFIX/drive_c/Program Files/rFactor/GameData/"
        
       # Script to copy new tracks and setups for rFactor

       # Define the source and destination paths
       SOURCE_DIR="$WINEPREFIX/../INSTALL/newTracks/2"
       SOURCE_OTHER_DIR="$WINEPREFIX/../INSTALL/newTracks/"

       DEST_DIR="$WINEPREFIX/drive_c/Program Files/rFactor/GameData/Locations"
       SETUPS_DIR="$WINEPREFIX/drive_c/Program Files/rFactor/UserData/"
       
       # Function to copy tracks
       copy_tracks() {
           local track_name=$1
           echo ""
           echo "$track_name"
           echo ""
           cp -R "$SOURCE_DIR/$track_name" "$DEST_DIR"
       }
       copy_other_tracks() {
           local track_name=$1
           echo ""
           echo "$track_name"
           echo ""
           cp -R "$SOURCE_OTHER_DIR/$track_name" "$DEST_DIR"
       }

       # Function to copy setups
       copy_setups() {
           echo ""
           printf "\nPlacing HistoricX setups in\n"$WINEPREFIX"/drive_c/Program Files/rFactor/UserData\n"
           cp -R "$WINEPREFIX/../INSTALL/HistorX 1.96 Club setups 2016/" "$SETUPS_DIR"
       }
       
       # Copy tracks
       copy_tracks "Brands Hatch 1950 v1_0 by Rodrrico"
       copy_tracks "Bugatti67"
       copy_tracks "Clermont65"
       copy_other_tracks "67panorama"
       copy_other_tracks "Avus1967_v1.0_by_ZWISS_for_rF/Avus1967"
       copy_other_tracks "BremgartenGP_54"
       copy_other_tracks "Monza_1000km"
       copy_other_tracks "FDsign Spa58 Rfactor"
       copy_tracks "60s Oulton Park v1_0 by philrob/60Oulton"
       copy_tracks "Monaco_1967_by_Fero/Monaco67"
       copy_tracks "Nurburg67"
       copy_tracks "Reims67"
       copy_tracks "Riverside70"
       copy_tracks "Sebring1970_v1"
       copy_tracks "snett"
       copy_tracks "Solitude_64"
       copy_tracks "Zeltweg"
       copy_tracks "Zandvoort67"
       
       # Copy setups
       copy_setups
    else # rFactor iso is not mounted
       clear
       echo "rFactor is not installed, and the rFactor iso is not mounted at INSTALL/isoMnt."
       echo ""
       echo "To install rFactor, follow these 5 steps:"
       echo ""
       echo "1. Purchase the rFactor DVD and make an iso from the DVD"
       echo ""
       echo "2. Mount the iso via:"
       echo "sudo mount -o loop <path to iso>rF.iso $WINEPREFIX/../INSTALL/isoMnt"
       echo ""
       echo "3. cd to the rFactor directory:"
       echo "cd $WINEPREFIX/../"
       echo ""
       echo "4. Install dxvk via:"
       echo "export WINEPREFIX=\$PWD/WP"
       echo "winetricks dxvk 2>/dev/null 1>/dev/null"
       echo "(unless you install the dxvk vulkan drivers, rFactor will be very slow running on linux."
       echo "Step 3 is not needed if running only on MS Windows.)"
        echo ""
       echo "When prompted, do not install wine mono, which is the wine version of MS .net"
      echo ""
       echo "5. Run this script again"
       echo ""
    exit 0
  fi # iso mounted if clause
fi # installation if clause
 

