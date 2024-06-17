#!/usr/bin/bash

export WINEPREFIX=$PWD/WP
if [ ! -d $WINEPREFIX/../INSTALL ]
then
        clear
        echo "$WINEPREFIX/../INSTALL not found.  Download the directory before proceeding."; echo ""
        echo "See the file 'additionalGames.txt' for information about where to download the"
        echo "INSTALL add-on package. Unpack this file into the INSTALL directory."
	echo "Then run this script again."
        exit 0
fi

if [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/rFactor.exe"  ]
then # open installation if clause
        clear
	echo "Run rFactor.sh to install rFactor, then run this script again."
	exit 0
fi

clear
echo "Installing JR's rFactor AI improvement plugin v. 1.21"
echo "This prevents the AI from forcing you off the road or crashing into your car as if you weren't there."
echo "For best results, let the AI practice on a track for the complete practice session before racing."
echo "Set AI at 100% strength, 0% aggressiveness."
echo "This plugin is for offline racing against the AI only.  If racing online, remove this plugin via"; echo ""
echo "rm -rf $WINEPREFIX/drive_c/Program Files (x86)/rFactor/Plugins/rFJRPlugin"
echo "rm $WINEPREFIX/drive_c/Program Files (x86)/rFactor/Plugins/rFJRPlugin.dll"; echo ""
echo "After plugin installation, it may be harder to select buttons in rFactor.  Select near the top of the button."
echo "Make sure rFactor is set to run in a window via graphicsConfig_rFactor.sh"
echo ""

echo "Installing java runtime environment ..."
wine $WINEPREFIX/../INSTALL/jre-8u291-windows-i586.exe /s 2>/dev/null 1>/dev/null
echo "Installing AI improvement plugin v. 1.21" 
rsync -a "$WINEPREFIX/../INSTALL/Plugins/"   "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/Plugins/"
echo ""
