#!/bin/bash

# remove env pointer to experimental version of wine if it exits

# check if wine-development is already the active version of wine

if [ $(wine --version | grep "wine-5.5" | wc -c) -ne 0 ]
then
	# nothing to do; wine-development is the current version of wine
	echo ""; echo "wine-development is already the current version of wine."; echo ""
	exit 0
fi

#if [ $(wine --version | grep "wine-6.7 (Staging)" | wc -c) - ne 0 ]
#then
#echo "#copy and paste the following commands in a terminal window, one by one:"; echo " "

sudo apt install -y wine-development 2>/dev/null 1>/dev/null
sudo apt install -y wine32-development 2>/dev/null 1>/dev/null
sudo apt install -y winetricks 2>/dev/null 1>/dev/null

