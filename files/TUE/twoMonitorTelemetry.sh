#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# this script requires wine.  On Ubuntu 20.04 or 20.10, install wine via:
# sudo apt install -y wine
#
# 21 Mar 2021

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX=$PWD/WP

numMonitors=$(eval "xrandr -q | grep connected | grep -v disconnected | wc -l")

if [ $numMonitors -ne 2 ]; then
        echo " "
	echo "You do not seem to have a dual monitor setup.  Two monitors are needed for the telemetry utility,"
	echo "which runs on your second monitor (ideally set to 1024x768 resolution) after you"
	echo "start GPL on your primary monitor."
	echo "press CTRL C to exit and set up dual monitors, or press Enter"
	echo "if you have a dual monitor setup which this script could not detect."
        read replyString
fi

clear;
echo "The GPLModec real-time telemetry program runs as a second process"
echo "displaying on your second monitor while you are racing in GPL."
printf "Since a virtual desktop uses only one monitor, TURN OFF\nvirtual desktop before running GPLMotec.\nIf virtual desktop is on, type CONTROL C, then ./setWineDisplayResolution.sh, \nthen deselect virtual desktop in the graphics tab.\nThen run this script again.\n\nPress CONTROL C if virtual desktop is on, otherwise\npress any key to continue\n\n"
read replyString
echo "GPLMotec will start in 3 minutes."
echo "You must be racing in the GPL 3D view when GPLMotec starts."
echo ""
echo "After 3 minutes, GPLMotec will appear"
echo "on your second monitor and GPL will freeze."
echo ""
echo "Use ALT TAB, SHIFT ALT TAB and ALT F6 to restore keyboard focus"
echo "to the GPL window.  GPL will start again and your keyboard and"
echo "joystick will work again. This works best with the"
echo "wine-6.3 (Staging) or later version of wine."
echo ""
echo "Run ./gpl.sh in different terminal window, starting now."

sleep 180; wine $WINEPREFIX/drive_c/GPLMotecAdd/GPLMotec.exe 2>/dev/null 1>/dev/null



