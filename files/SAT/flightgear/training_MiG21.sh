# Outline of what the script does:
# This script checks if FlightGear simulator and its add-on aircraft
# are installed. It then sets up the environment for practicing
# takeoff and landing in a Soviet MiG-21 aircraft. The user is
# provided with instructions on cockpit instrument study and given
# assistance for landing maneuvers. Finally, the script launches the
# FlightGear simulator with the specified aircraft and time settings.

#!/bin/bash

# This script facilitates learning cockpit instruments and practicing takeoff and landing in a Soviet MiG-21.

# Check if FlightGear simulator is installed
#
# Define variables for readability
export FGFS_EXECUTABLE="/usr/games/fgfs"
export FGFS_AIRCRAFT_DIR="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"
export INSTALL_SCRIPT="$HOME/ese/THU/flightgear/installFlightgear.sh"

# Check if FlightGear simulator is installed
if [ ! -f "$FGFS_EXECUTABLE" ]; then
    echo "FlightGear open source flight simulator is not installed."
    echo "Run $INSTALL_SCRIPT for installation steps, then run this script again."
    exit 1
fi

#if ! command -v fgfs &>/dev/null; then
#    echo "FlightGear open source flight simulator is not installed."
#    echo "Run ../../optionalFlightgearInstall.sh for installation steps, then run this script again."
#    exit 1
#fi

# Check if FlightGear add-on aircraft are installed
if [ ! -d "$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020" ]; then
    clear
    echo "It appears that the FlightGear add-on aircraft are not installed."
    printf "\nIf you have not installed the add-on aircraft yet,\n1. Type CTRL+C\n2. Follow the instructions in $PWD/installFlightgear.sh\n3. Run this script again.\n\nOtherwise, press any key to continue.\n\n"
    read -r replyString
    echo "Then run this script again."
    exit 1
fi

# Set variables for readability
export fgfs_path="/usr/games/fgfs"
export fgfs_aircraft_dir="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"

# Display instructions
echo  "\nFor landing help, select View/Toggle Glide Slope Tunnel\n"
echo "Study the cockpit instruments and practice takeoff and landing."

echo "\nFor help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "MiG-21bis"

# Start FlightGear simulator
fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=MiG-21bis 2>/dev/null 1>/dev/null

