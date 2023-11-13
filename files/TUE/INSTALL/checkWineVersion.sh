#!/bin/bash
# check for correct wine version
# called from scripts that launch wine applications

if [ ! -f /usr/bin/wine ]; then
	echo " "; echo "ERROR: wine not found."
	echo "run ./wine_experimental.sh"
	echo "in the esports-for-engineers-41 directory."
	exit 1
fi
exit 0
