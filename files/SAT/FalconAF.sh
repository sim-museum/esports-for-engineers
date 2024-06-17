# Script Outline:
#
# This script checks if FalconAF is installed. If not, it looks for the mounted FalconAF iso for installation.
# If the iso is found, it proceeds with the installation. If not, it prompts the user to mount the iso.
# After installation, or if FalconAF is already installed, it launches FalconAF.

#!/bin/bash

# Define variables for directory paths
ISO_MNT_DIR="$PWD/isoMnt"
INSTALL_DIR="$PWD/INSTALL"
export WINEPREFIX="$PWD/WP"
FALCON_EXE_PATH="$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/FalconAF.exe"

# Check if FalconAF is installed
if [ ! -f "$FALCON_EXE_PATH" ]; then
    # Check if FalconAF iso is mounted
    if [ -f "$ISO_MNT_DIR/Setup.exe" ]; then
        clear
        echo ""
        echo "Installing using mounted FalconAF iso ..."
        echo ""
        echo "If asked whether to install wine-mono package, select Cancel."
        echo "When prompted for Setup Type, select Install"
        echo "Before entering 3D view, check that SETUP/GRAPHICS/VIDEO MODE is set to Direct3D HAL"
        echo ""
        
        # Install FalconAF
        wine "$ISO_MNT_DIR/Setup.exe" 2>/dev/null 1>/dev/null
        cp "$INSTALL_DIR/FalconAF/display.dsp" "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/config"
        cp "$INSTALL_DIR/FalconAF/Viper."* "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/config"
        cp "$INSTALL_DIR/FalconAF/global.cfg" "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations"
        cp "$INSTALL_DIR/FalconAF/BFOpslog.txt" "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations"
    else
        echo ""
        echo "FalconAF is not installed, and the FalconAF iso is not mounted at $ISO_MNT_DIR for installation."
        echo ""
        echo "To install FalconAF, follow these 3 steps:"
        echo "1. download the iso from, e.g., https://www.myabandonware.com/game/falcon-4-0-allied-force-e53"
        echo "2. mount the iso to the $ISO_MNT_DIR directory via"
        echo "   sudo mount -o loop <path to iso>FalconAF.iso $ISO_MNT_DIR"
        echo "3. run this script again"
        echo ""
        exit 0
    fi
fi

# Launch FalconAF
wine "$FALCON_EXE_PATH" 2>/dev/null 1>/dev/null

