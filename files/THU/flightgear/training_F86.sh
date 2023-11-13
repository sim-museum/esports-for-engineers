#!/bin/bash

# learn cockpit instruments, practice takeoff and landing in a US F-86F Sabre 

if [ ! -f /usr/games/fgfs ]; then
	echo " "
	echo "The flightgear open source flight simulator is not installed. To install"
	echo "run ../../optionalFlightgearInstall.sh and follow the instructions,"
	echo "then run this script again."
	exit 1
fi


if [ ! -d "$HOME/.fgfs/Aircraft/org.flightgear.fgaddon.stable_2020" ]; then
	clear
	echo "It appears that the flightgear add-on aircraft are not installed."
	printf "\nIf you did not install the add-on aircraft yet,\n1. type CONTROL C\n2. follow the inst ructions in "$PWD"/flightgear/installFlightgear.sh\n3. run this script again.\n\notherwise, press a key to continue.\n\n"	
	read replyString
	echo "then run this script again."
	exit 1
fi


# set the aircraft to F-86F
# set time to noon on June 1, 2020 at the user's location

echo " "; echo "For landing help select View/Toggle Glide Slope Tunnel"; echo " ";
echo "study the cockpit instruments and practice take off and landing."
echo " "; echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Sabre"; echo " "

fgfs --start-date-sys=2020:06:01:12:00:00 --aircraft=F-86F 2>/dev/null 1>/dev/null

clear
printf "F-86F optional script\n\nStart with the F-86F in the air:\n$PWD/training_F86_startInAir.sh\n\n"

