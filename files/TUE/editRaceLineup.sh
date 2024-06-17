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


clear; echo "Edit completed practice results to, e.g., change your position"
echo "on the starting grid, change types of cars, change the number"
echo "of laps in the race, etc."
echo ""
echo "Note: this editor works only for 67, 67x and 65 carsets."; echo ""
echo "The saved practice sessions available to edit are:"; echo ""
cd $WINEPREFIX
numSavedSessions=$(eval "find . -print | grep svg$ | wc -l")
if [ $numSavedSessions -eq 0 ]; then
	echo "No saved practice sessions found.  Before you"
	echo "can edit a race starting grid, you must have"
	echo "at least one saved practice session using"
	echo "either the 67, 67x or 65 carset.  Save "
	echo "such a practice session and then run this "
	echo "script again."
	exit 1
fi
echo "Saved practice sessions:"
echo "---------------------------------------------------"
find . -print | grep "svg$"
echo "---------------------------------------------------"
echo "" 
echo "Press Enter to run the practice session editor"
read userReply
cd $WINEPREFIX/drive_c/SVG_EDIT
wine SVG-Editor.exe 2>/dev/null 1>/dev/null
exit 0



