#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX="$PWD/WP"
if [ -d "$WINEPREFIX/drive_c/FreeFalcon6" ]
then
	# Free Falcon is installed
        cd "$WINEPREFIX/drive_c/FreeFalcon6"
        # note a separate FF6 config program is available
        # wine 'FFViper Config Editor.exe'
        wine FFViper.exe -window 2>/dev/null 1>/dev/null
        exit 0
else
        # Free Falcon not installed yet
        #echo " "
        #echo " "
	#echo "In Wine Configuration,   Select Windows 98 as the Windows version.  In the Graphics"
        echo "If you run into graphics glitches later, run ./setWineDisplayResolution.sh and"
	echo "In Wine Configuration, in the Graphics"
	echo "tab, select Emulate A Virtual Desktop and set Desktop Size to"
        echo "your screen resolution."
        # WINEARCH=win32 winecfg 2>/dev/null 1>/dev/null
        #winecfg 2>/dev/null 1>/dev/null

        echo " "
        echo " "
	echo "Step 1 of 4: Installing Free Falcon 6"
        echo "When you reach the final install screen, Completing the FreeFalcon 6.0 Installation,"
	echo "deselect the option Launch Free Falcon 6 Config Editor"
        echo " "

	cd "$PWD/INSTALL/FF6d"
	wine FreeFalcon6.0_Installer.exe 2>/dev/null 1>/dev/null
	echo " "
        echo " "
        echo "Step 2 of 4: Installing Cockpit art"
        echo " "
        echo " "

	cd "$WINEPREFIX"
        cd "../INSTALL/FF6_FreeFalcon5_Cockpit_Pack_www.g4g.it/FreeFalcon5_Cockpit_Pack"
	wine 'FreeFalcon5 Cockpit Pack v1.5.exe'  2>/dev/null 1>/dev/null

        echo " "
        echo " "
	echo "Step 3 or 4: Installing Israel Theater"
        echo " "
        echo " "

	cd "$WINEPREFIX"
       	cd "../INSTALL/FF6_ITOv4c_www.g4g.it/ITO V4c"
	wine 'ITO2 V4c.exe' 2>/dev/null 1>/dev/null
        
	echo " "
        echo " "
	echo "Step 4 or 4: Installing Balkans Theater"
        echo " "
        echo " "

	cd "$WINEPREFIX"
       	cd "../INSTALL/FF6_Balkans3_www.g4g.it/BalkansFF6-3/"
	wine 'Balkans 2.exe' 2>/dev/null 1>/dev/null
 


        # remove outdated documentation
        cd "$WINEPREFIX/drive_c/FreeFalcon6/_the_MANUAL"
        rm "FF6 COMPANION_v.5.5.pdf"

	# move movie directories so movies aren't played during game
	# (movies seems correlated to crashes)

	cd "$WINEPREFIX/drive_c/FreeFalcon6"
	mv movies movies_DoNotPlayInGame

	cd "$WINEPREFIX/drive_c/FreeFalcon6/Theaters/Israel"
        mv movies movies_DoNotPlayInGame

	# change configuration defaults
	# add MFD's to 1 display
	# campaign produces debrief text file
	cp $WINEPREFIX/../INSTALL/mods/ffviper.cfg $WINEPREFIX/drive_c/FreeFalcon6

	# turn off pilot breathing sounds (which were on only in the Korea theater)
	cp $WINEPREFIX/drive_c/FreeFalcon6/F4Patch/FFViper/pit/Breathing/BreathingOff/EnviroControlSys.wav $WINEPREFIX/drive_c/FreeFalcon6/sounds
        cp $WINEPREFIX/drive_c/FreeFalcon6/F4Patch/FFViper/pit/Breathing/BreathingOff/EnviroControlSys.wav $WINEPREFIX/drive_c/FreeFalcon6/F4Patch/Persist/Breathing

	# add saved campaigns to the Israeli classic theater.  For the 1973 and 1982 campaigns, load one of these saved campaigns rather
	# than starting a new campaign because, when a new campaign is started, a movie plays and crashes the sim.
	# The movie was removed, but the crash still happens whenever you start a new 1973 or 1982 campaign (unless you can
	# abort the movie playing routine with keypresses).

        rsync -a $WINEPREFIX/../INSTALL/mods/israeliClassicSavedCampaigns/ $WINEPREFIX/drive_c/FreeFalcon6/Theaters/Israel_Classic/campaign/	



	# now run Free Falcon

        cd "$WINEPREFIX/drive_c/FreeFalcon6"
        # note a separate FF6 config program is available
        # wine 'FFViper Config Editor.exe'
        wine FFViper.exe -window 2>/dev/null 1>/dev/null
        exit 0

fi	
exit 0
