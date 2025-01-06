# Script Outline:
# 1. Check if FreeFalcon6 is installed.
# 2. If installed, launch Free Falcon.
# 3. If not installed, provide instructions for Wine configuration and proceed with installation steps.
# 4. Install Free Falcon 6 and required components.
# 5. Perform necessary configuration changes.
# 6. Run Free Falcon.

#!/bin/bash

# Set variables for directory paths
export INSTALL_DIR="$PWD/INSTALL"
export WINEPREFIX_DIR="$PWD/WP"


# Export Wine prefix
export WINEPREFIX="$WINEPREFIX_DIR"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Check if FreeFalcon6 is installed
if [ -d "$WINEPREFIX/drive_c/FreeFalcon6" ]; then
    # Free Falcon is installed
    cd "$WINEPREFIX/drive_c/FreeFalcon6"
    # Launch Free Falcon
    wine FFViper.exe -window 2>/dev/null 1>/dev/null
    exit 0
else
    # Free Falcon not installed yet

    # Provide instructions for setting up Wine configuration
    echo "If you run into graphics glitches later, run ./setWineDisplayResolution.sh and"
    echo "In Wine Configuration, in the Graphics"
    echo "tab, select Emulate A Virtual Desktop and set Desktop Size to"
    echo "your screen resolution."

    # Install Free Falcon 6
    echo " "
    echo " "
    echo "Step 1 of 4: Installing Free Falcon 6"
    echo "When you reach the final install screen, Completing the FreeFalcon 6.0 Installation,"
    echo "deselect the option Launch Free Falcon 6 Config Editor"
    echo " "
    cd "$INSTALL_DIR/FF6d"
    wine FreeFalcon6.0_Installer.exe 2>/dev/null 1>/dev/null
    echo " "
    echo " "
    echo "Step 2 of 4: Installing Cockpit art"
    echo " "
    echo " "
    cd "$WINEPREFIX_DIR/../INSTALL/FF6_FreeFalcon5_Cockpit_Pack_www.g4g.it/FreeFalcon5_Cockpit_Pack"
    wine 'FreeFalcon5 Cockpit Pack v1.5.exe'  2>/dev/null 1>/dev/null
    echo " "
    echo " "
    echo "Step 3 or 4: Installing Israel Theater"
    echo " "
    echo " "
    cd "$WINEPREFIX_DIR/../INSTALL/FF6_ITOv4c_www.g4g.it/ITO V4c"
    wine 'ITO2 V4c.exe' 2>/dev/null 1>/dev/null
    echo " "
    echo " "
    echo "Step 4 or 4: Installing Balkans Theater"
    echo " "
    echo " "
    cd "$WINEPREFIX_DIR/../INSTALL/FF6_Balkans3_www.g4g.it/BalkansFF6-3/"
    wine 'Balkans 2.exe' 2>/dev/null 1>/dev/null

    # Remove outdated documentation
    cd "$WINEPREFIX/drive_c/FreeFalcon6/_the_MANUAL"
    rm "FF6 COMPANION_v.5.5.pdf"

    # Move movie directories
    cd "$WINEPREFIX/drive_c/FreeFalcon6"
    mv movies movies_DoNotPlayInGame

    cd "$WINEPREFIX/drive_c/FreeFalcon6/Theaters/Israel"
    mv movies movies_DoNotPlayInGame

    # Change configuration defaults
    cp "$WINEPREFIX/../INSTALL/mods/ffviper.cfg" "$WINEPREFIX/drive_c/FreeFalcon6"
    cp "$WINEPREFIX/drive_c/FreeFalcon6/F4Patch/FFViper/pit/Breathing/BreathingOff/EnviroControlSys.wav" "$WINEPREFIX/drive_c/FreeFalcon6/sounds"
    cp "$WINEPREFIX/drive_c/FreeFalcon6/F4Patch/FFViper/pit/Breathing/BreathingOff/EnviroControlSys.wav" "$WINEPREFIX/drive_c/FreeFalcon6/F4Patch/Persist/Breathing"

    # Add saved campaigns to the Israeli classic theater
    rsync -a "$WINEPREFIX/../INSTALL/mods/israeliClassicSavedCampaigns/" "$WINEPREFIX/drive_c/FreeFalcon6/Theaters/Israel_Classic/campaign/"

    # Run Free Falcon
    cd "$WINEPREFIX/drive_c/FreeFalcon6"
    wine FFViper.exe -window 2>/dev/null 1>/dev/null
    exit 0
fi
exit 0

