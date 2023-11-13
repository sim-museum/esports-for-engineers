WINEPREFIX=$PWD/WP

mv "$WINEPREFIX/../../tar/Speed-Dreams-2.2.3-x86_64.AppImage" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ -f "$WINEPREFIX/../INSTALL/Speed-Dreams-2.2.3-x86_64.AppImage" ]
then
	# even though the AppImage is a native linux binary, to
	# comply with the build conventions used here, move it to $WINEPREFIX

	# by convention, downloaded files are stored in $WINEPREFIX/../INSTALL
	# executables are stored in $WINEPREFIX

	mv "$WINEPREFIX/../INSTALL/Speed-Dreams-2.2.3-x86_64.AppImage" $WINEPREFIX
fi

if [ -f "$WINEPREFIX/Speed-Dreams-2.2.3-x86_64.AppImage" ]
then
        clear
	echo "Speed Dreams open source sim racing"; echo ""
	echo "To race a 67 Grand Prix car at Monza, Choose:"
	echo "Race"
	echo "Practics"
	echo "Configure"
	echo "Now select Grand Prix Circuits on the top line, and Forza on the second line"
	echo "Next"
	echo "Garage"
	echo "For Category on top left select 1967 Grand Prix"
	echo "Apply, Next, Next, Start"

	echo ""
	$WINEPREFIX/Speed-Dreams-2.2.3-x86_64.AppImage 2>/dev/null 1>/dev/null
else
	clear
	printf "\n\nSpeed-Dreams-2.2.3-b1-x86_64.AppImag not found.\n\nDownload it from https://sourceforge.net/projects/speed-dreams/files/latest/download\n\nand place it in the "$WINEPREFIX"/../INSTALL directory\n\n"
        echo ""; echo "Then run this script again."
	echo ""
fi

