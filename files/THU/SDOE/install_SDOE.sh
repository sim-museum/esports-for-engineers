$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
	exit 1
fi

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Program Files/Fighter Squadron/Sdemons.exe" ]
then
	if [ -f "$WINEPREFIX/drive_c/Program Files/FS-WWI/Sdemons.exe" ]
	then
		clear
		printf "SDOE already installed.  Run ./WWI_SDOE.sh\nfor the World War I aircraft or ./WWII_SDOE.sh for the\nWorld War II aircraft.\n\n  SDOE is a Windows 98 flight simulator known for its flight and damage models.\n\n"
		exit 0
	fi
	                printf "SDOE WWII planes already installed.  Run ./installSDOE.sh\nand install the WWI aircraft next.\n\n"
exit 0
fi

mv "$WINEPREFIX/../../../tar/Fighter_Squadron_SDOE_DVD.iso" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null
mv "$WINEPREFIX/../../../tar/fspatch150.exe" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f $WINEPREFIX/../INSTALL/Fighter_Squadron_SDOE_DVD.iso ]
then
	clear
	printf "Fighter Squadron: Screaming Demons Over Europe (SDOE)\ninstall files not found in the directory "$WINEPREFIX"/../INSTALL"
	echo ""
	echo "From this link:"; echo ""
	echo "https://www.myabandonware.com/game/fighter-squadron-the-screamin-demons-over-europe-evp#download"
	echo ""
	echo "download the following 2 files:"
	echo "1. Fighter_Squadron_SDOE_DVD.iso"
	echo "2. fspatch150.exe" 
	echo ""
	echo "Place these files in the THU/FighterSquadron/INSTALL directory."
	echo ""
	echo "Then run this script again."
	echo ""
	exit 0
else        
	if [ ! -f "$WINEPREFIX/../INSTALL/isoMnt/FILES/SDOEDVD.exe" ]
	then

	clear
        printf "In the Wine Configuration Dialog that follows:\n1. In the application tab, select Windows 98.\n2. In the graphics tab, deselect  'Allow the window manager to decorate the windows'\n3. Select virtual Desktop with resolution of at least 1024x768.\n4.Then select OK to continue the installation.\n\nPress a key to continue.\n\n"
        read replyString

        WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null

		echo "fighter squadron iso file found in THU/FighterSquadron/INSTALL"
		cd $WINEPREFIX/../INSTALL
        	clear
		printf "To install Fighter Squadron, run the following command in a terminal:\n\nsudo mount -o loop "$WINEPREFIX"/../INSTALL/Fighter_Squadron_SDOE_DVD.iso "$WINEPREFIX"/../INSTALL/isoMnt\n\nThen run this script again.\n"
		exit 0
	fi
        
# unpack files	
        if [ -f "$WINEPREFIX/../INSTALL/isoMnt/FILES/SDOEDVD.exe" ]
	then
# iso mounted, not installed
                cd "$WINEPREFIX/../INSTALL/isoMnt/FILES"
		clear
		printf "Fighter Squadron installation instructions:\n\n1. If asked wither to install Mono, do not install it.\n2. Install the WWII content. \n3. After installing, deselect fly.\nSelect Exit.\n 4. Repeat with the WWI content.\n\nPress a key to begin installation.\n\n"
		read replyString
		wine "SDOEDVD.exe" 2>/dev/null 1>/dev/null
		cd $WINEPREFIX/../INSTALL
		wine fspatch150.exe 2>/dev/null 1>/dev/null

		printf "\n\nInstallation completed.  Run ./WWI_SDOE.sh or ./WWII_SDOE.sh \n"
		exit 0
	fi
fi
