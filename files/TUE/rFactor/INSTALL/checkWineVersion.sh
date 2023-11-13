#!/bin/bash
# check for correct wine version
# called from scripts that launch wine applications

if [ ! -f /usr/bin/wine ]; then
	echo " "; echo "ERROR: wine not found. If using Ubuntu 20.04 LTS install it via:"
	echo "sudo apt install -y wine-development"; echo " "
	exit 1
fi

if wine --version | grep "wine-5"; then
	exit 0
fi

echo " "; echo "WARNING: wrong version of wine detected.  You are using the"
eval wine --version
echo "version instead of the recommended wine-development (wine-5.5) version." 
echo "To install wine-development using Ubuntu 20.04 LTS use this command:"
echo "sudo apt install -y wine-development"; echo " "

echo "press CTRL C to exit or ENTER to continue"
read replyString
exit 0 
