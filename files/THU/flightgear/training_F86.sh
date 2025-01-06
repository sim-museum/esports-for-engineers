# Script Outline:
#
# 1. Check if FlightGear is installed.
# 2. Check if FlightGear add-on aircraft are installed.
# 3. Set variables for readability.
# 4. Set the aircraft to F-86F and set time to noon on June 1, 2020 at the user's location.
# 5. Provide instructions and guidance for using the script.
# 6. Start FlightGear with specified options.
# 7. Display a message indicating the completion of the script with relevant information.

#!/bin/bash

# Learn cockpit instruments, practice takeoff and landing in a US F-86F Sabre 

# Check if FlightGear is installed
if [ ! -f /usr/games/fgfs ]; then
    echo " "
    echo "The FlightGear open source flight simulator is not installed. To install,"
    echo "run ../../optionalFlightgearInstall.sh and follow the instructions,"
    echo "then run this script again."
    exit 1
fi

# Check if FlightGear add-on aircraft are installed
export addon_aircraft_dir="$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020"
if [ ! -d "$addon_aircraft_dir" ]; then
    clear
    echo "It appears that the FlightGear add-on aircraft are not installed."
    printf "\nIf you have not installed the add-on aircraft yet,\n1. type CONTROL C\n2. follow the instructions in %s/flightgear/installFlightgear.sh\n3. run this script again.\n\nOtherwise, press any key to continue.\n\n" "$PWD"
    read -r replyString
    echo "Then run this script again."
    exit 1
fi

# Set variables for readability
export flight_script="$PWD/training_F86_startInAir.sh"

# Set the aircraft to F-86F and set time to noon on June 1, 2020 at the user's location
echo " "; echo "For landing help select View/Toggle Glide Slope Tunnel"; echo " ";
echo "Study the cockpit instruments and practice takeoff and landing."
echo " "; echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Sabre"; echo " "

# Start FlightGear with specified options
fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=F-86F 2>/dev/null 1>/dev/null

clear
printf "F-86F optional script\n\nStart with the F-86F in the air:\n%s\n\n" "$flight_script"

