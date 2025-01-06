#!/bin/bash

echo "This script enables full screen mode for Battle of Britain. For full screen,"
echo "two monitors are required so the splash screen doesn't block the main display."
echo  "If full screen mode is unstable, revert to windowed mode using ./runWindowed.sh"

# Check for two monitors
numMonitors=$(xrandr -q | grep connected | grep -v disconnected | wc -l)
if [ "$numMonitors" -ne 2 ]; then
        echo "Two monitors are needed for full screen display"
        echo "If the game is unstable in full screen, use ./runWindowed.sh"
        echo "Exiting"
        exit 1
fi

# Set Wine prefix and change to game directory
export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain"

# Update configuration file to enable full screen mode
if [ -f "bdg.txt" ]; then
    # Use sed to replace the string
    sed -i 's/FORCE_WINDOWED_MODE=ON/FORCE_WINDOWED_MODE=OFF/g' bdg.txt
    echo "Full screen mode enabled."
    echo "Note: If the game is unstable in full screen, use ./runWindowed.sh to return to windowed mode"
else
    echo "Error: config file bdg.txt not found."
    echo "Cannot enable full screen mode"
fi
