#!/bin/bash

echo "This script turns on the stable windowed screen mode for Battle of Britain. For full screen,"
echo "two monitors are required so the splash screen doesn't block the main display."
echo  "To run full screen mode, ensure 2 monitors are plugged in and run the script ./runFullScreen.sh"

# Set Wine prefix and change to game directory
export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/drive_c/Program Files (x86)/Rowan Software/Battle Of Britain"

# Update configuration file to enable full screen mode
if [ -f "bdg.txt" ]; then
    # Use sed to replace the string
    sed -i 's/FORCE_WINDOWED_MODE=OFF/FORCE_WINDOWED_MODE=ON/g' bdg.txt
    echo "Full screen mode enabled."
    echo "Note: If the game is unstable in full screen, use ./runWindowed.sh to return to windowed mode"
else
    echo "Error: config file bdg.txt not found."
    echo "Cannot enable full screen mode"
fi
