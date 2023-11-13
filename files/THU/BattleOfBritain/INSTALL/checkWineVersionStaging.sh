#!/bin/bash
# check for correct wine version
# called from scripts that launch wine applications

if [ ! -f /usr/bin/wine ]; then
	echo " "; echo "ERROR: wine not found. For instructions on installing it run"
	echo "the esports-for-engineers-v41/wine_experimental.sh script."
	echo "Then run this script again."; echo " "
	exit 1
fi

if wine --version | grep "wine-5.5"; then

echo " "; echo "WARNING: wrong version of wine detected.  You are using the"
eval wine --version
echo "version.  For instructions on installing the recommended version of wine,"
echo "run the esports-for-engineers-v41/wine_experimental.sh script."

echo "press CTRL C to exit and install the recommended version of wine, or ENTER to continue"
read replyString
exit 0 

fi

exit 0
