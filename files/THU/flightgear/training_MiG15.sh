#!/bin/bash

# learn cockpit instruments, practice takeoff and landing in a Soviet MiG 15

if [ ! -f /usr/games/fgfs ]; then
	echo " "
	echo "The flightgear open source flight simulator is not installed."
	echo "Run ../../optionalFlightgearInstall.sh for installation instructions,"
	echo "then run this script again."
	exit 1
fi


if [ ! -d "$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020" ]; then
	clear
	echo "It appears that the flightgear add-on aircraft are not installed."
	printf "\nIf you did not install the add-on aircraft yet,\n1. type CONTROL C\n2. follow the instructions in "$PWD"/installFlightger.sh\n3. run this script again.\n\notherwise, press a key to continue.\n\n"	
	read replyString
	echo "then run this script again."
	exit 1
fi



# set the aircraft to MiG 15
# set time to noon on June 1, 2020 at the user's location

echo " "; echo "For landing help select View/Toggle Glide Slope Tunnel"; echo " ";
echo "study the cockpit instruments and practice take off and landing."
echo " "; echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "MiG-15bis"; echo " "

fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=MiG-15bis 2>/dev/null 1>/dev/null

