# Checks if Mig Alley setup exists in the Wine prefix. If found, launches Mig Alley.
# Checks the number of connected monitors and prompts the user if not 2.
# Checks if winetricks is installed. If not, displays an error message and exits.
# Checks if Mig Alley setup files exist. If not, provides instructions for mounting the iso and exits.
# Guides the user through Wine configuration for installation.
# Launches Mig Alley and performs post-installation tasks like copying necessary files.
# Finally, launches Mig Alley.

#!/bin/bash

# Store commonly used directory paths in variables for readability
export INSTALL_DIR="$PWD/INSTALL"
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null


export MA_ISO="$INSTALL_DIR/MA_iso"

# Check if Mig Alley setup exists in the Wine prefix
if [ -f "$WINEPREFIX/drive_c/rowan/mig/Mig.exe" ]; then
    # Launch Mig Alley
    cd "$WINEPREFIX/drive_c/rowan/mig"
    wine Mig.exe &>/dev/null
    exit 0
fi

# Check the number of connected monitors no longer needed, thanks to Mig Alley DLL files and wine improvements
#numMonitors=$(xrandr -q | grep connected | grep -v disconnected | wc -l)
#if [ "$numMonitors" -ne 2 ]; then
#    echo -e "\nTo avoid graphics glitches, a dual monitor setup is recommended for Mig Alley."
#    echo -e "\n$numMonitors monitors were detected."
#    echo -e "\nTo stop this script and set up dual monitors, press <CTRL> C."
#    echo -e "To continue with your current monitor setup, press Enter\n"
#    read -r replyString
#fi

# Check if winetricks is installed
if [ ! -f "/usr/bin/winetricks" ]; then
    echo "\nERROR: winetricks not found. This program is needed to install a wine library "
    echo "during Mig Alley installation.  If using Ubuntu 20.04 LTS install winetricks via:"
    echo "sudo apt install -y winetricks\n"
    exit 1
fi

# Check if Mig Alley setup files exist
if [ ! -f "$MA_ISO/setup.EXE" ]; then
    clear
    echo "Before you can install Mig Alley, you must mount the Mig Alley iso."
    echo "\nMount the Mig Alley CD-ROM iso using this command:"
    echo "\nsudo mount -o loop $INSTALL_DIR/'Mig Alley V1.1.iso' $MA_ISO\n"
    echo "Then run this script again."
    exit 1
fi

# Provide instructions for Wine configuration
clear
echo "In the Wine configuration dialog box, which appears next, select the 'Graphics' tab."
echo "Select Windows XP as the windows version."
echo "In the Graphics tab, unselect 'Allow the window manager to decorate the windows'"
echo "Then select OK to continue the installation.\n"
echo "Press enter to display the Wine configuration dialog box."
read -r replyString
winecfg &>/dev/null
winetricks vcrun6 &>/dev/null
wine "$MA_ISO/setup.EXE" &>/dev/null
clear
echo "Select 'CANCEL' in the DirectX(R) Setup dialog box, then press ENTER to continue."
read -r replyString
clear
echo "When Mig Alley starts, select PREFERENCES and set graphics resolution to the highest"
echo "resolution listed, which is probably 1152x864."
echo "Set all other graphics options to maximum values."

# Launch Mig Alley and copy necessary files
wine "$INSTALL_DIR/Mig-Alley_Patch_Win_EN_Patch-123/MIG123.EXE" &>/dev/null
wine "$INSTALL_DIR/bdg_migalley_0.85f/BDG_MiGAlley_0.85F.exe" &>/dev/null
cp "$INSTALL_DIR/bdg.txt" "$WINEPREFIX/drive_c/rowan/mig"
cp -r "$MA_ISO/smacker" "$WINEPREFIX/drive_c/rowan/mig"
cp "$INSTALL_DIR/roots.dir" "$WINEPREFIX/drive_c/rowan/mig"
cp "$INSTALL_DIR/SaveGame/"*.* "$WINEPREFIX/drive_c/rowan/mig/SaveGame"
cp "$INSTALL_DIR/Videos/"*.* "$WINEPREFIX/drive_c/rowan/mig/Videos"
cp "$INSTALL_DIR/keys.xml" "$WINEPREFIX/drive_c/rowan/mig/KEYBOARD"

rsync -a "$INSTALL_DIR/Mig Alley DLL/" "$WINEPREFIX/drive_c/rowan/mig/"
rm "$WINEPREFIX/drive_c/rowan/mig/mfc42.dll" &>/dev/null
cd "$WINEPREFIX/drive_c/rowan/mig"

# Launch Mig Alley
wine Mig.exe &>/dev/null


