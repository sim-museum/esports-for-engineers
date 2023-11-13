#!/usr/bin/bash
# this script requires wine.  On Ubuntu 20.04, install wine via:
# sudo apt install -y wine

#$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
#if [ $? -ne 0 ]; then
#        exit 1
#fi

export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/rFactor.exe" ]
then
cd "$WINEPREFIX/drive_c/Program Files (x86)/rFactor"
wine rFactor.exe  2>/dev/null 1>/dev/null
clear
printf "rFactor Optional Scripts\n\nTelemetry:\n"$WINEPREFIX"/../addTelemetryLoggerToRfactor.sh\n\nImprove AI:\n"$WINEPREFIX"/../offlineAIimprovement_rFactor.sh\n\nConfigure Graphics:\n"$WINEPREFIX"/../graphicsConfig_rFactor.sh\n\nTip: to become owner of all cars in a mod, type the code \"ISI_BABYFACTORY\" in\nthe chat window.  (The chat window is at lower left on the screen just before\n you enter the 3D view.)\n\n" 
exit 0
fi

mv "$WINEPREFIX/../../../tar/rFactorINSTALL_22_04_LTS.tar.gz" $WINEPREFIX/../INSTALL 2>/dev/null 1>/dev/null

if [ ! -f "$WINEPREFIX/../INSTALL/rFactorINSTALL_22_04_LTS.tar.gz" ]
then
	clear
	printf "rFactor 67 cars and tracks not found.  Download rFactorINSTALL_22_04_LTS.tar.gz from:\n\nhttps://www.mediafire.com/file/eihpdopiwdf0odz/rFactorINSTALL_22_04_LTS.tar.gz/file\n\nwith this checksum\n\nc8a14b5f879de47c8ebe20f6e481406096e71d4218e4fb8969efa39e4c81338e  rFactorINSTALL_22_04_LTS.tar.gz\n\nand \nplace it in "$WINEPREFIX"/../INSTALL.  Then run this script again.\n\n"; 
	exit 0
fi

if [ ! -d "$WINEPREFIX/../INSTALL/newTracks" ]
then
cd "$WINEPREFIX/../INSTALL/"
clear
printf "Press a key to start unpacking cars and tracks.  This takes a few minutes.\n\n"
tar xzf rFactorINSTALL_22_04_LTS.tar.gz
# copy the new files into the INSTALL directory
# note: when installing on MS Windows, 
# replace "rsync -a" with "xcopy /e"
rsync -a rFactorINSTALL_22_04_LTS/ "$WINEPREFIX/../INSTALL/"
# with the files copied, the unpack directory is no longer needed.
rm -rf rFactorINSTALL_22_04_LTS
fi
#	echo ""; echo "Background: rFactor is non-free software that must be purchased.  You can use linux for installation, then run on MS Windows."
#	echo "rFactor is an old sim racing game that was released in 2005, and for which lots of free add-ons are available."
#	echo "Buy the rFactor (not rFactor 2) CD, install on MS Windows and make an iso to use with"
 #       echo "this install script on linux."; echo ""
#	echo "This installation script adds free carsets and tracks.  This install can then be copied to"
#	echo "Windows to run. Copy the 'drive_c/rFactor' directory on linux to 'C:\' on MS Windows."; echo ""
#	echo ""
#	echo "A tar file containing the needed rFactor 1 tracks and plugings can be downloaded here:"
#	echo "https://www.mediafire.com/file/v1i86pdsv6y9h75/INSTALL-v43.tar.gz/file"
#	echo ""
#	echo "To verify download integrity, run sha256sum on the downloaded file.  The output should be:"
#	echo "2a1053df0a790cb5ad56a8d25236c0e990afff96fa6a2e158c4c33bb77836438  INSTALL-v43.tar.gz"
#	echo ""
#	echo "Unpack the tar.gz file into this directory."
 #       echo "Then execute this commands in TUE/rFactor directory:"; 
#	echo "winetricks --self-update"; 
#	echo "winetricks dxvk"
#	echo ""
#	exit 0
#fi

if [ ! -f "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/rFactor.exe"  ]
then # open installation if clause

if [ -f "$WINEPREFIX/../INSTALL/isoMnt/Setup.exe" ]
then
        
	clear
        echo "If you have not already done so with this WP directory,"
        echo "If you have not already installed dxvk in this WP directory, type <CTRL> C"
	echo "and install dxvk via the two commands below, then run this script again:"
        echo "export WINEPREFIX=\$PWD/WP"
	echo "winetricks dxvk  2>/dev/null 1>/dev/null"; echo ""
	echo "Otherwise, type ENTER to continue ..."
        read replyString
	
        clear
        printf "In the Wine configuration dialog box, which appears next, select the 'Graphics' tab.\nUnselect allow window manager to decorate windows."
	echo "Select Virtual Desktop and set the desktop size to your monitor resolution."
	echo "Then select OK to continue the installation."; echo " "
        echo "Press enter to display the Wine configuration dialog box."
	echo ""; echo "Later, when you reach the rFactor Video Setup screen, choose"
	echo "Shader Level: Quality (DX9), Anti-Aliasing: Level 4, select the Windowed"
	echo "tic box and leave the input field to the right of "
	echo "Resolution:"
        echo  "blank."
	echo "In the next window, Completing the rFactor Setup Wizard, unselect Run rFactor"
	echo "so the script can proceed to install additional cars and tracks."

	read replyString
        winecfg 2>/dev/null 1>/dev/null

        echo ""; echo "Installing using mounted rFactor iso ..."; echo ""
	echo "Untick 'Run rFactor' in the 'Completing the rFactor Setup Wizard' dialog box"
	echo "Install directx."
	echo "After the 1958 and 1967 carsets are added, along with several period tracks,"
	echo "rFactor will run.  After rFactor starts, choose customize."
	echo "In Customize/Player, choose customize player racing series."
	echo "Choose either '1958 Forumula One World Championship' or"
	echo "'F1 Legends Racing v2.03', which is the 1967 carset"
	echo "In Customize/Vehicle choose a car and select 'buy car'"
	echo "In Customize/Settings/Difficulty turn off automatic shifting and all other driver aids."
	echo "If the 3D view appears too dark, increase monitor brightness setting."
       	echo ""
        wine "$WINEPREFIX/../INSTALL/isoMnt/Setup.exe" 2>/dev/null 1>/dev/null
	# copy exe patched to allow 4GB using 4gb_patch.exe from 58 mod
        cp "$WINEPREFIX/../../../tar/rFactor.exe" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/" 2>/dev/null 1>/dev/null

	echo ""; echo "Installing 2019 Formula E carset"; echo ""
	rsync -a "$WINEPREFIX/../INSTALL/Bravo Formula E 2019-20 Mod/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"
	# reference: https://www.youtube.com/watch?v=MLL-3sENySg
	# It was in the comments under this You tube video
	# https://www.youtube.com/watch?v=MLL-3sENySg

	echo ""; echo "Installing 1958 carset"; echo ""
#	rsync -a "$WINEPREFIX/../INSTALL/F1 1958 v.4.30 by ORM/Mod/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"
#mv "$WINEPREFIX/../INSTALL/F1 1958 by ORM - v4.35 COMPLETE/F1 1958 by ORM - v4.35 COMPLETE/Gamedata" "$WINEPREFIX/../INSTALL/F1 1958 by ORM - v4.35 COMPLETE/F1 1958 by ORM - v4.35 COMPLETE/GameData"
rsync -a "$WINEPREFIX/../INSTALL/F1 1958 by ORM - v4.35 COMPLETE/F1 1958 by ORM - v4.35 COMPLETE/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"

       	echo ""; echo "Installing 1967 carset"; echo "" 
	rsync -a $WINEPREFIX/../INSTALL/F1LR_mod_V203/Mod/ "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"

#        echo ""; echo "Installing 1937 carset Grand Prix 1937 v1.0"; echo ""
#        rsync -a "$WINEPREFIX/../INSTALL/Grand Prix 1937 v1.0/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"

        echo ""; echo "60's sportscars Historix1.9 (large: takes 4 minutes to load)"; echo ""
        rsync -a "$WINEPREFIX/../INSTALL/Historix1.9/Historix/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"

        echo ""; echo "Installing 60's tracks:"; echo ""
	echo ""; echo "Panorama Track"; echo ""
        cp -R $WINEPREFIX/../INSTALL/newTracks/67panorama "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"
	echo ""; echo "Avus Track"; echo ""
        cp -R $WINEPREFIX/../INSTALL/newTracks/Avus1967_v1.0_by_ZWISS_for_rF/Avus1967 "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"
	echo ""; echo "Bremergarten Track"; echo ""
        cp -R $WINEPREFIX/../INSTALL/newTracks/BremgartenGP_54 "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"
	echo ""; echo "Spa Track"; echo ""
	rsync -a "$WINEPREFIX/../INSTALL/newTracks/FDsign Spa58 Rfactor/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/"
	echo ""; echo "Monza Track"; echo ""
        cp -R $WINEPREFIX/../INSTALL/newTracks/Monza_1000km "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

		        echo ""; echo "Monza Track"; echo ""
        cp -R $WINEPREFIX/../INSTALL/newTracks/Monza_1000km "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

	       echo ""; echo "60s Oulton Park v1_0 by philrob"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/60s Oulton Park v1_0 by philrob/60Oulton" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"


                echo ""; echo "Aintree 1955 v1 by jpalesi"; echo ""
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/Aintree 1955 v1 by jpalesi/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/"

	      echo ""; echo "Brands Hatch 1950 v1_0 by Rodrrico"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Brands Hatch 1950 v1_0 by Rodrrico/BrandsHatch1950" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

             echo ""; echo "Bugatti67"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Bugatti67" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"


             echo ""; echo "Clermont65"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Clermont65" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

                echo ""; echo "Imola1960s_v1.0"; echo ""
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/Imola1960s_v1.0/GameData/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/"

             echo ""; echo "Monaco_1967_by_Fero"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Monaco_1967_by_Fero/Monaco67" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

                             echo ""; echo "Nurburg67"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Nurburg67" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

                             echo ""; echo "Reims67"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Reims67" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

                             echo ""; echo "Riverside70"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Riverside70" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

                             echo ""; echo "Sebring1970_v1"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Sebring1970_v1" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"
                             echo ""; echo "Snetterton"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/snett" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

                           echo ""; echo "Solitude_64"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Solitude_64" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

               echo ""; echo "Targa_Florio_v1.0"; echo ""
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/Targa_Florio_v1.0/GameData/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/"

               echo ""; echo "Thruxton_v0.99"; echo ""
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/Thruxton_v0.99/GameData/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/"

               echo ""; echo "TRACK - Anderstorp 1975"; echo ""
        rsync -a "$WINEPREFIX/../INSTALL/newTracks/2/TRACK - Anderstorp 1975/GameData/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/"

               echo ""; echo "Zeltweg"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Zeltweg/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

               echo ""; echo "Zandvoort67"; echo ""
        cp -R "$WINEPREFIX/../INSTALL/newTracks/2/Zandvoort67/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/GameData/Locations"

	printf "\nPlacing HistoricX setups in\n"$WINEPREFIX"/drive_c/Program Files (x86)/rFactor/UserData\n"
	cp -R "$WINEPREFIX/../INSTALL/HistorX 1.96 Club setups 2016/" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/UserData/"

else
	clear
	echo "rFactor is not installed, and the rFactor iso is not mounted at INSTALL/isoMnt."; echo ""
	echo "To install rFactor, follow these 5 steps:"
	echo ""; echo "1. Purchase the rFactor DVD and make an iso from the DVD"
	echo ""; echo "2. mount the iso via:"
	echo "sudo mount -o loop <path to iso>rF.iso $WINEPREFIX/../INSTALL/isoMnt"
	echo ""; echo "3. cd to the rFactor directory:"
	echo "cd $WINEPREFIX/../"
		echo ""; echo "4. Install dxvk via"
	echo "export WINEPREFIX=\$PWD/WP"
	#echo "sudo winetricks --self-update"
	echo "winetricks dxvk 2>/dev/null 1>/dev/null"; echo ""
	echo "When prompted, do not install wine mono, which is the wine version of MS .net"
	echo "(unless you install the dxvk vulkan drivers, via step 3, rFactor will be very slow running on linux."
	echo "Step 3 is not needed if running only on MS Windows.)"
	echo "4. run this script again"; echo ""
	exit 0
fi # close installation if clause
fi
# note that 
# wine <path> exe
# leads to a "can't find codeshaders.mas" error while
# cd <path>
# wine exe

