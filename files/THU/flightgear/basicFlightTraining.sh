#!/bin/bash

# fly a Cessna 172P using the open source flightgear program

if [ ! -f /usr/games/fgfs ]; then
	echo " "
	echo "The flightgear open source flight simulator is not installed."
	echo "Run ../../optionalFlightgearInstall.sh for installation steps,"
	echo "then run this script again."
	exit 1
fi

# set the aircraft to the Cessna (which is the default when first starting flightgear)
# set time to noon on June 1, 2020 at the user's location
# start the web daemon to enable Cessna/Show Panel in Browser

echo " "; echo "For landing help select View/Toggle Glide Slope Tunnel"; echo " ";
echo " "; echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Help/Aircraft Checklists"
echo "Help/Tutorials"
echo "Cessna C172P"; echo " "

echo " "; echo "to fly at an airport of your choice select Location/Select Airport"
echo "to automatically download scenery for that airport select"
echo "File/Scenery Download/Enable automatic scenery download"
echo " "
echo "To fly at any latitude and longitude, Select Location/Position Aircraft In Air/Position"
echo "for Latitude, negative means South"
echo "for Longitude, negative means West"; echo " "

fgfs --start-date-sys=2020:06:01:12:00:00 --httpd=8080 --aircraft=c172p 2>/dev/null 1>/dev/null

