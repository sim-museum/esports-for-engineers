#!/bin/bash

# Outline of the script:
#
# This script checks if FlightGear simulator and its add-on aircraft are installed.
# If not installed, it provides instructions for installation and exits.
# It then sets the aircraft to Spitfire and starts the FlightGear simulator for practice.
#
# Script dependencies:
# - FlightGear simulator (fgfs)
# - Add-on aircraft directory (org.flightgear.fgaddon.stable_2020)
#
# Steps:
# 1. Check if FlightGear simulator is installed.
# 2. Check if FlightGear add-on aircraft are installed.
# 3. Set the aircraft to Spitfire and time to noon on June 1, 2020.
# 4. Start the FlightGear simulator.

# Define variables for readability
FGFS_EXEC="/usr/games/fgfs"
FGFS_AIRCRAFT_DIR="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"
INSTALL_SCRIPT="./installFlightgear.sh"

# Check if FlightGear simulator is installed
if [ ! -f "$FGFS_EXEC" ]; then
    echo " "
    echo "The FlightGear open source flight simulator is not installed."
    echo "Run $INSTALL_SCRIPT for installation steps,"
    echo "then run this script again."
    exit 1
fi

# Check if FlightGear add-on aircraft are installed
if [ ! -d "$FGFS_AIRCRAFT_DIR" ]; then
    clear
    echo "It appears that the FlightGear add-on aircraft are not installed."
    printf "\nIf you did not install the add-on aircraft yet,\n1. type CONTROL C\n2. follow the instructions in $PWD/$INSTALL_SCRIPT\n3. run this script again.\n\nOtherwise, press any key to continue.\n\n"
    read replyString
    echo "Then run this script again."
    exit 1
fi

# Set the aircraft to Spitfire and time to noon on June 1, 2020 at the user's location
echo " "
echo "For landing help select View/Toggle Glide Slope Tunnel"
echo " "
echo "Study the cockpit instruments and practice takeoff and landing."
echo " "
echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Help/Tutorials"
echo "Spitfire"
echo " "

# Start FlightGear simulator
fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=spitfireIIa 2>/dev/null 1>/dev/null

