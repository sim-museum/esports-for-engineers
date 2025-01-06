#!/bin/bash

# set the aircraft to the Cessna (which is the default when first starting flightgear)
# set time to noon on June 1, 2020 at the user's location
# start the web daemon to enable Cessna/Show Panel in Browser

# fly a Cessna 172P using the open source flightgear program

# Checks if FlightGear is installed by verifying the existence of the executable file.
# Provides instructions for using FlightGear.
# Launches FlightGear with specified parameters.

# Store frequently used directory paths for better readability
export flightgear_path="/usr/games/fgfs"

# Check if FlightGear is installed
if [ ! -f "$flightgear_path" ]; then
    echo "FlightGear open source flight simulator is not installed."
    echo "Run ../../optionalFlightgearInstall.sh for installation steps,"
    echo "then run this script again."
    exit 1
fi

# Provide instructions for FlightGear
echo " "
echo "For landing help select View/Toggle Glide Slope Tunnel"
echo " "
echo "For help on this aircraft, see:"
echo "Help/Aircraft Help"
echo "Help/Aircraft Checklists"
echo "Help/Tutorials"
echo "Cessna C172P"
echo " "
echo "To fly at an airport of your choice select Location/Select Airport"
echo "To automatically download scenery for that airport select"
echo "File/Scenery Download/Enable automatic scenery download"
echo " "
echo "To fly at any latitude and longitude, Select Location/Position Aircraft In Air/Position"
echo "For Latitude, negative means South"
echo "For Longitude, negative means West"
echo " "

# Launch FlightGear
fgfs --start-date-sys=2020:06:01:12:00:00 --httpd=8080 --aircraft=c172p 2>/dev/null 1>/dev/null

