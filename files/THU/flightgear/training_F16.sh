
# Script Outline:
#
# This script checks for the existence of the FlightGear simulator and its add-on aircraft.
# If FlightGear is not installed, it prompts the user to run the installation script.
# If the add-on aircraft are not installed, it provides instructions for installation.
# Then, it informs the user about how to use the simulator and suggests studying cockpit instruments.
# Finally, it starts the FlightGear simulator with predefined settings.

#!/bin/bash

# Define variables for readability
FGFS_EXECUTABLE="/usr/games/fgfs"
FGFS_AIRCRAFT_DIR="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"
INSTALL_SCRIPT="../installFlightgear.sh"

# Check if FlightGear simulator is installed
if [ ! -f "$FGFS_EXECUTABLE" ]; then
    echo "FlightGear open source flight simulator is not installed."
    echo "Run $INSTALL_SCRIPT for installation steps, then run this script again."
    exit 1
fi

# Check if FlightGear add-on aircraft are installed
if [ ! -d "$FGFS_AIRCRAFT_DIR" ]; then
    clear
    echo "It appears that the FlightGear add-on aircraft are not installed."
    printf "\nIf you did not install the add-on aircraft yet,\n"
    printf "1. type CONTROL C\n2. follow the instructions in $PWD/$INSTALL_SCRIPT\n3. run this script again.\n\n"
    printf "Otherwise, press any key to continue.\n\n"
    read -n 1 -s -r replyString
    echo "Then run this script again."
    exit 1
fi

# Inform user about how to use the simulator
echo " "
echo "For landing help, select View/Toggle Glide Slope Tunnel"
echo " "
echo "Study the cockpit instruments and practice takeoff and landing."
echo " "
echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Help/Aircraft Checklists"
echo "Help/Tutorials"
echo "F-16CJ Block 52"
echo " "

# Start FlightGear simulator with specified settings
fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=f16-block-52 2>/dev/null 1>/dev/null

