#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# this script requires wine.  On Ubuntu 20.04 or 20.10, install wine via:
# sudo apt install -y wine
#
# A note on software archeology:
# How can a script automatically configure a program?  Here are the steps:
# 1. install the program
# 2. wait 10 minutes
# 3. run the program, go into setup and configure, e.g., graphics settings
# This is often important to prevent a crash the first time the user
# runs the program.  (For example, with FalconAF SETUP/GRAPHICS/VIDEO MODE
# is set to Direct3D T&L HAL by default, which will cause a crash upon 
# entry into 3D under wine 6.4 (Staging).  How to change this setting
# in a script? Read on.)
# 4. copy all the files that changed in the last five minutes to
# the afterGameReport directory via
# find . -name "*.*" -type f -mmin -5 -not -path "./afterGameReport/*" -exec cp {} ./afterGameReport \;
# 5. find the path to each of these changed files via
# find . -print | grep <name of the file you're seeking>
# 6. copy these files to the install directory
# 7. add lines to the script to copy these files over during script execution 
# (see the comment SET CONFIGURATION below)
# The goal is to recreate the state of the program after the configuration
# was set manually, but to do this automatically via a script
#
# 20 Mar 2021

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX=$PWD/WP

if [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/FalconAF.exe"  ]
then # open installation if clause

if [ -f "$WINEPREFIX/../isoMnt/Setup.exe" ]
then
clear
        echo ""; echo "Installing using mounted FalconAF iso ..."; echo ""
        echo "If asked whether to install wine-mono package, select Cancel."
	echo "When prompted for Setup Type, select Install"
	echo "Before entering 3D view, check that SETUP/GRAPHICS/VIDEO MODE is set to Direct3D HAL"
	# THis is to prevent a graphics glitch followed by an unresponsive keyboard., in order to prevent unresponsive keyboard
	# If FalconAF does hang, in Ubuntu 20.04 press <CTR><ALT>F3, run top and kill the FalconAF process in text mode
        # then press <CTRL><ALT>F1 to return to graphics mode.
        echo ""
        wine "$WINEPREFIX/../isoMnt/Setup.exe" 2>/dev/null 1>/dev/null
	# SET CONFIGURATION
	cp INSTALL/FalconAF/display.dsp "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/config"
	cp INSTALL/FalconAF/Viper.* "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/config"
	cp INSTALL/FalconAF/global.cfg "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations"
	cp INSTALL/FalconAF/BFOpslog.txt "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations"

else
	echo ""; echo "FalconAF is not installed, and the FalconAF iso is not mounted at $WINEPREFIX/../isoMnt for installation."; echo ""
	echo "To install FalconAF, follow these 3 steps:"
	echo "1. download the iso from, e.g., https://www.myabandonware.com/game/falcon-4-0-allied-force-e53"
	echo "2. mount the iso to the $WINEPREFIX/../isoMnt directory via"
	echo "sudo mount -o loop <path to iso>FalconAF.iso $WINEPREFIX/../isoMnt"
	echo "3. run this script again"; echo ""
	exit 0
fi # close installation if clause
fi
wine "$WINEPREFIX/drive_c/Program Files (x86)/Lead Pursuit/Battlefield Operations/FalconAF.exe"  2>/dev/null 1>/dev/null

