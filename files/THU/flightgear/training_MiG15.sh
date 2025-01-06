# Script Outline:
#
# 1. Check if FlightGear is installed, exit if not.
# 2. Check if FlightGear add-on aircraft are installed, exit if not.
# 3. Set variables for FlightGear executable and add-on aircraft directory.
# 4. Launch FlightGear with MiG 15 aircraft and set the time.
# 5. Provide instructions for using FlightGear and practicing with the MiG 15.
# 6. Provide information on where to find help for the MiG 15 aircraft.
# 7. Run FlightGear in the background.

#!/bin/bash

# This script launches the FlightGear open source flight simulator with a Soviet MiG 15 aircraft for practice.

# Check if FlightGear is installed
if [ ! -f /usr/games/fgfs ]; then
    echo "The FlightGear open source flight simulator is not installed."
    echo "Run ../../optionalFlightgearInstall.sh for installation instructions, then run this script again."
    exit 1
fi

# Check if the flightgear add-on aircraft are installed
if [ ! -d "$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020" ]; then
    clear
    echo "It appears that the FlightGear add-on aircraft are not installed."
    printf "\nIf you did not install the add-on aircraft yet,\n1. type CONTROL C\n2. follow the instructions in "$PWD"/installFlightger.sh\n3. run this script again.\n\nOtherwise, press any key to continue.\n\n"
    read replyString
    echo "Then run this script again."
    exit 1
fi

# Set variables for improved readability
export flightgear_exec="/usr/games/fgfs"
export fgaddon_dir="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"

# Launch FlightGear with MiG 15 aircraft and set time to noon on June 1, 2020 at the user's location
echo " "
echo "For landing help select View/Toggle Glide Slope Tunnel"
echo " "
echo "Study the cockpit instruments and practice takeoff and landing."
echo " "
echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "MiG-15bis"
echo " "

$flightgear_exec --start-date-sys=2020:06:01:12:00:00 --aircraft=MiG-15bis 2>/dev/null 1>/dev/null

