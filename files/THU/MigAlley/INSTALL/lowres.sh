#!/bin/bash
# sets all monitors to 1024x768

if [ $# -ne 0 ]; then
	echo " "; echo "Incorrect input."; echo " "
	echo "This command takes no arguments.  It sets all monitors to low (1024x768) resolution."
	echo " "
	exit 1
fi

xrandr -q | grep connected | grep -v disconnected | cut -d ' ' -f 1 | $WINEPREFIX/../INSTALL/lowresHelper.sh

