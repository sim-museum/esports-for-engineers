#!/bin/bash
# check for correct wine version
# called from scripts that launch wine applications

if [ ! -f /usr/bin/wine ]; then
	echo " "; echo "ERROR: wine not found. "
	echo "run ./wine_experimental.sh in the "
	echo "esports-for-engineers directory."
	exit 1
fi

