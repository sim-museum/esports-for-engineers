#!/bin/bash


$PWD/INSTALL/checkWineVersion.sh
if [ $? -ne 0 ]; then
        exit 1
fi


echo ""
echo "It is important to read the online help in order to understand the Mig Alley"
echo "campaign icons.  To do so, place the online help screen on the second monitor in a "
echo "dual monitor arrangement, then place the Mig Alley campaign screen on the "
echo "primary monitor as follows."
echo ""
echo "run this program and place the mig help application on a second monitor"
echo "in a dual monitor setup.  Then run ./mig.sh"
echo "Select Single Player/Campaign, then select a campaign to navigate to"
echo "the 2D campaign map view."
echo "Click on the campaign mode icons one by one while reading about each"
echo "icon in the online help screen on your other monitor."
echo ""

export WINEPREFIX="$PWD/WP"
cd $WINEPREFIX/drive_c/rowan/mig/English/TEXT
wine winhlp32.exe mig.hlp 2>/dev/null 1>/dev/null
exit 0
