#!/bin/bash

# This script launches the FlightGear flight simulator with a German ME 109G aircraft for learning cockpit instruments,
# and practicing takeoff and landing.

# Check if FlightGear is installed
if [ ! -f /usr/games/fgfs ]; then
    echo " "
    echo "The FlightGear open-source flight simulator is not installed."
    echo "Run ../../optionalFlightgearInstall.sh for installation steps,"
    echo "then run this script again."
    exit 1
fi

# Check if FlightGear add-on aircraft are installed
FG_AIRCRAFT_DIR="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"
if [ ! -d "$FG_AIRCRAFT_DIR" ]; then
    clear
    echo "It appears that the FlightGear add-on aircraft are not installed."
    printf "\nIf you did not install the add-on aircraft yet,\n1. type CONTROL C\n2. follow the instructions in "$PWD"/installFlightgear.sh\n3. run this script again.\n\notherwise, press a key to continue.\n\n"
    read replyString
    echo "then run this script again."
    exit 1
fi

# Launch FlightGear with ME109G aircraft
# Set time to noon on June 1, 2020 at the user's location
echo " "; echo "For landing help select View/Toggle Glide Slope Tunnel"; echo " ";
echo "Study the cockpit instruments and practice takeoff and landing."
echo " "; echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Help/Tutorials"
echo "Bf-109"; echo " "
echo "Note that in Battle of Britain you will be flying an earlier version of"
echo "this aircraft."

fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=bf109g 2>/dev/null 1>/dev/null

# Provide optional script instructions
clear
printf "me109 optional script\n\nStart with the me109 in the air:\n%s/training_me109_startInAir.sh\n\n" "$PWD"


