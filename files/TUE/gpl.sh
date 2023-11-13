#!/usr/bin/bash
# this linux script file is from https://github.com/sim-museum/esports-for-engineers
# this script requires wine.  On Ubuntu 20.04 or 20.10, install wine via:
# sudo apt install -y wine
#
# 21 Mar 2021

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX=$PWD/WP


if [ ! -f "$WINEPREFIX/drive_c/Sierra/GPL/gpl.exe" ]
then # open installation if clause
clear

if [ -f "$WINEPREFIX/../isoDir/SETUP.EXE" ] 
then
	echo ""; echo "Installing using mounted GPL iso ..."; echo ""
	echo ""; echo "Step 1 of 2: install GPL version 1.08"; 
	echo "If asked whether to install wine-mono package, select Cancel."
	echo "When asked for path to GPL, select isoDir."
	echo "If prompted about a missing readme file, select Ignore."
	echo "If prompted with a file exists error dialog box, (which may be behind another dialog box), select OK."
	echo "Later in the install, when prompted to choose two names for chat, choose any names you want."
	echo ""
	wine INSTALL/gplinstall_beta_1.08.exe 2>/dev/null 1>/dev/null
else
	echo ""; echo "Installing the free Grand Prix Legends demo version or "
	echo "(optional) the full version if you have downloaded the iso"; echo ""
	echo ""; echo "Note: you can download the iso at this link: https://www.myabandonware.com/game/grand-prix-legends-9zz"
        echo ""; echo "If you have a copy of the Grand Prix Legends (GPL) iso, and have not mounted it yet then"
        echo "1. press CTRL C to exit"; echo ""
        echo "2. cd to the TUE directory, mount your GPL iso to the isoDir directory via the command"
        echo "sudo mount -o loop <path>/<name of GPL iso>.iso $WINEPREFIX/../isoDir"; echo ""
        echo "3. run this script again."; echo ""
        echo "Press ENTER to install the free GPL demo version"
	echo "or press CTRL C and download the GPL iso (recommended)."
        read replyString

	echo ""; echo "Installing free GPL demo ..."; echo ""
	echo ""; echo "Step 1 of 2: Installing GPL free version"; echo ""
	echo "In the GPL 2004 DEMO dialog box, DO NOT use the default Installation folder.  Use"
	echo "---------------"
	echo "C:\Sierra\GPL"
	echo "---------------"
	echo "as the installation folder.  COPY THE PATH IN THE LINE ABOVE AND BE READY TO PASTE IT"
	echo "in both the GPL 2004 DEMO dialog box (Step 1), and later in the GEM+ path to GPL dialog box (Step 2)."
	echo "If asked whether to install wine-mono package, select Cancel."
	echo "Choose any names for the two chat names."
	echo "Press ENTER to continue."
	read replayString

	wine "$WINEPREFIX/../INSTALL/gpl_2004_demo.exe" 2>/dev/null 1>/dev/null
        
	if [ ! -f "$WINEPREFIX/drive_c/Sierra/GPL/gpl.exe" ]
        then
		echo "ERROR: used default installation path instead of typing in the correct path,"
		echo "C:\Sierra\GPL"
		echo "You will need to start again.  Run ./gpl.sh, and this time paste in "
		echo "C:\Sierra\GPL for the GPL 2004 Demo installation path."
		echo ""
		rm -rf WP
		mkdir WP
		exit 0
         fi

        wine "$WINEPREFIX/../INSTALL/gplrast_v2.5.exe" 2>/dev/null 1>/dev/null
	sed -i 's/rd3d7v2.dll/roglv2.dll/' $WINEPREFIX/drive_c/Sierra/GPL/app.ini
	wine "$WINEPREFIX/../INSTALL/GPL_67_PATCH/1967_PATCH_v1.3_Setup.exe" 2>/dev/null 1>/dev/null
fi
	echo ""; echo "Step 2 of 2: install GEM+ car, track switcher/multiplayer/setup manager"; echo ""

	# must create player in GPL before running GEM+
#	echo "break??"
#	exit 0

        # remove driver created if using free GPL demo
        rm -rf $WINEPREFIX/drive_c/Sierra/GPL/players
        mkdir $WINEPREFIX/drive_c/Sierra/GPL/players
        # a driver name must be created before starting GEM+
        # create the driver "Driver 67"
        cp -r $WINEPREFIX/../INSTALL/*__Driver $WINEPREFIX/drive_c/Sierra/GPL/players
	# GPL init file App.ini contains player name, so copy that too
        cp -r $WINEPREFIX/../INSTALL/app.ini $WINEPREFIX/drive_c/Sierra/GPL/

	wine INSTALL/GEMPackage_2.5.0.32.exe 2>/dev/null 1>/dev/null
	# must remove ini file so GEM+ initializes correctly ...
	mv $WINEPREFIX/drive_c/users/Public/Documents/GEM+/GEM.ini  $WINEPREFIX/drive_c/users/Public/Documents/GEM+/GEM.ini.bak
	cp INSTALL/GEM.ini $WINEPREFIX/drive_c/users/Public/Documents/GEM+
        # correct igor website URL
	sed -i 's/gplrank.info/igor.gplrank.de/' $WINEPREFIX/drive_c/GPLSecrets/iGOR/iGOR.ini

	# replace old GPL Setup Manager v 1.16 with version 2.7
	rm -rf "$WINEPREFIX/drive_c/GPLSecrets/GPL Setup Manager"
        cp -R "$WINEPREFIX/../INSTALL/GPL Setup Manager" "$WINEPREFIX/drive_c/GPLSecrets"

	# install pribluda files (needed if using free GPL demo, redundant if using GPL iso)
	cp $WINEPREFIX/../INSTALL/pribluda/*.* $WINEPREFIX/drive_c/Sierra/GPL
	# make options, such as pribluda telemetry and head motion, available in GEM+
	cp $WINEPREFIX/../INSTALL/GEM_options/*.* $WINEPREFIX/drive_c/GPLSecrets/GEM+/Options

	# add Challenge Rank and Historic Rank tracks per:
	# http://srmz.net/index.php?showtopic=13167&hl=gplrank

#	echo ""; echo "The first time you run GPL from GEM+, you will be prompted"
#	echo "to enter a new driver name.  You can do so, or you can simply"
#	echo "press the right arrow icon and choose Driver 67."
#	echo ""
#	echo "Two carsets are installed by default, the original 67"
#	echo "and the more physically realistic 67x."
#	echo "To use 67x in GEM+, select Driver 67x at top right,"
#	echo "Then select Race and 1967-X on the left above where it says Race Options"
#	echo "For more details, refer to page 15 of "
#	echo "GPL_Easy_Installation_Guide_ENG_v2.1.pdf in the DOC folder."
#	echo ""
#	echo "Installing and starting GEM+ will take a few moments ..."
        echo " "; echo "step 1 of 8"; echo " "
	echo ""; echo "Installing Challenge Rank tracks ..."; echo ""
	rsync -a "$WINEPREFIX/../INSTALL/Challenge Rank/" $WINEPREFIX/drive_c/Sierra/GPL/tracks

        echo " "; echo "step 2 of 8"; echo " "       
	echo "Installing Historical Rank tracks ..."; echo ""
	rsync -a "$WINEPREFIX/../INSTALL/Historic Rank/" $WINEPREFIX/drive_c/Sierra/GPL/tracks

	# create Challenge Rank and Historic Rank season files
        cp $WINEPREFIX/../INSTALL/67*.ini $WINEPREFIX/drive_c/Sierra/GPL/seasons

	# install the 67x carset 
	# reference: http://67f1.gplworld.de/downloads.htm
        rsync -a "$WINEPREFIX/../INSTALL/carsets/GPL 1967 F1 Extra Mod - Online Edition (2018)/GPL/" $WINEPREFIX/drive_c/Sierra/GPL/
	
        # installer may put files in GPL/mods rather than GPL/Mods directory
	if [ -d $WINEPREFIX/drive_c/Sierra/GPL/mods ]
	then
	   rsync -a $WINEPREFIX/drive_c/Sierra/GPL/mods/  $WINEPREFIX/drive_c/Sierra/GPL/Mods/ 2>/dev/null 1>/dev/null
	   # if the GPL/mods directory is present, iGor fails with the message
	   # could not open gplmods.ini
	   # apparently iGor looks in mods, if it exists, before looking in Mods
	   rm -rf $WINEPREFIX/drive_c/Sierra/GPL/mods/
        fi

	# install saved practice session editting utility

	cp -r $WINEPREFIX/../INSTALL/SVG_EDIT $WINEPREFIX/drive_c

	# install GPLmotec advanced telemetry 

	cp -r $WINEPREFIX/../INSTALL/GPLMotecAdd $WINEPREFIX/drive_c

	# tracks obtained from GPL track database

# reference: http://gpltd.bcsims.com
        echo " "; echo "step 3 of 8"; echo " "
echo ""; echo "Adding tracks: Montjuic Park v2 (Barcelona), Thruxton, Goodwood 65, Spa 67, Isle of Man, Beal Valley, Wilmot, skidfun"


# Montjuic Park v2
wine $WINEPREFIX/../INSTALL/additionalTracks/GPL_Montjuic_Park_1969_v1.0.02.exe 2>/dev/null 1>/dev/null

# Thruxton
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/tracks/thruxton
wine $WINEPREFIX/../INSTALL/additionalTracks/gpltrackinstall_thruxton_v1.0.exe 2>/dev/null 1>/dev/null
rsync -a $WINEPREFIX/../INSTALL/additionalTracks/Thruxton_DB_extra_files/gpl/ $WINEPREFIX/drive_c/Sierra/GPL/
rsync -a $WINEPREFIX/../INSTALL/additionalTracks/Thruxton_PS_mpost_update/gpl/ $WINEPREFIX/drive_c/Sierra/GPL/
cp $WINEPREFIX/../INSTALL/additionalTracks/Thruxton_High_Res_textures/*.* $WINEPREFIX/drive_c/Sierra/GPL/tracks/thruxton

# Goodwood 65
wine $WINEPREFIX/../INSTALL/additionalTracks/GPL_goodwd65_v1.0.exe 2>/dev/null 1>/dev/null


# Spa 67
wine $WINEPREFIX/../INSTALL/additionalTracks/spa67.exe 2>/dev/null 1>/dev/null

# Isle of Man
cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/other/IsleMan
wine TrackInstall.exe 2>/dev/null 1>/dev/null


# Beal60s
wine $WINEPREFIX/../INSTALL/additionalTracks/gpltrackinstall_Beal60s_v1.12.exe 2>/dev/null 1>/dev/null


# Wilmot
wine $WINEPREFIX/../INSTALL/additionalTracks/GPL_Wilmot_v1.0.exe 2>/dev/null 1>/dev/null


# skifun skid pad
wine $WINEPREFIX/../INSTALL/additionalTracks/GPL_Skidfun_v1.0.exe 2>/dev/null 1>/dev/null
rsync -a $WINEPREFIX/../INSTALL/additionalTracks/skidfun_No-lava_cones-for-women/skidfun/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/skidfun/

echo ""; echo "adding additional tracks needed by carsets"
# tracks needed by 65 carset
wine $WINEPREFIX/../INSTALL/additionalTracks/GPL65ModTracks_0.5.exe 2>/dev/null 1>/dev/null
rsync -a $WINEPREFIX/../INSTALL/tracks/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/
echo " "; echo "step 4 of 8"; echo " "
echo ""; echo "installing 55, 65, 66, 67 sports cars, 69 carsets"; echo ""


# install 55 carset mod
# reference: http://55f1.gplworld.de/
wine $WINEPREFIX/../INSTALL/carsets/GPL55F1_1.0.3.exe 2>/dev/null 1>/dev/null
# copy update directory into GPL folder
rsync -a $WINEPREFIX/../INSTALL/carsets/55Mod_Update_Patch/ $WINEPREFIX/drive_c/Sierra/GPL/

# install 65 carset
# reference: http://65f1.gplworld.de/downloads.htm
wine $WINEPREFIX/../INSTALL/carsets/GPL65F1_Alternative__2.0.2.exe 2>/dev/null 1>/dev/null

# install 66 carset mod
# reference: http://66f1.gplworld.de/downloads.html
wine $WINEPREFIX/../INSTALL/carsets/gpl1966_1.0.exe 2>/dev/null 1>/dev/null
#  It is essential to remove the gpl66 folder from mods/gem+ before installing this 66_Patch_v2.0!
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/GPL66
wine $WINEPREFIX/../INSTALL/carsets/1966_Mod_PATCH_v2.0/1966mod_PATCH_v2.0_Setup.exe 2>/dev/null 1>/dev/null

# install 67SC (sports cars) carset mod
# reference: http://sportscars67.gplworld.de/
wine $WINEPREFIX/../INSTALL/carsets/GPLSC_EXTRA_1.1.exe 2>/dev/null 1>/dev/null

# install 69x carset mod
# reference: http://69f1.gplworld.de/Part%204%20EXTRA.htm
wine "$WINEPREFIX/../INSTALL/carsets/69mod X'tra for Grand Prix Legends.exe" 2>/dev/null 1>/dev/null

# 65 installer puts files in GPL/mod rather than GPL/Mod directory
rsync -a $WINEPREFIX/drive_c/Sierra/GPL/mods/  $WINEPREFIX/drive_c/Sierra/GPL/Mods/ 2>/dev/null 1>/dev/null

# copy files needed by randomizeDrivers.sh
cp -r $WINEPREFIX/../INSTALL/originalDriverIniFiles $WINEPREFIX/drive_c/Sierra/GPL

# copy files needed by shorterGplRaces.sh
cp -r $WINEPREFIX/../INSTALL/shortRaceFiles $WINEPREFIX/drive_c/Sierra/GPL

# install replay analyzer
echo " "; echo "step 5 of 8"; echo " "

echo ""; echo "Install Replay Analyzer utility"; echo "" 2>/dev/null 1>/dev/null


wine $WINEPREFIX/../INSTALL/replayAnalyzerInstall.exe 2>/dev/null 1>/dev/null
rsync -a $WINEPREFIX/../INSTALL/replay/ $WINEPREFIX/drive_c/Sierra/GPL/replay/

# arrange for switching between 35 frames per second (for AI) and
# 60 frames per second (for most online racing)
mkdir $WINEPREFIX/drive_c/Sierra/GPL/bak
cp $WINEPREFIX/drive_c/Sierra/GPL/gpl_ai.ini $WINEPREFIX/drive_c/Sierra/GPL/bak
cp $WINEPREFIX/../INSTALL/frameRateSwitching/gpl_ai*.ini $WINEPREFIX/drive_c/Sierra/GPL
# with the demo sometimes there is no GEM+/<mod>/Options directory, sometimes the directory is spelled "options"
# delete whatever [Oo]ptions directory was there and create a uniform Options directory
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl55/options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl65/options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl66/options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67/options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67x/options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gplSC/options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/69-extra/options

rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl55/Options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl65/Options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl66/Options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67/Options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67x/Options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gplSC/Options
rm -rf $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/69-extra/Options

mkdir $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl55/Options
mkdir $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl65/Options
mkdir $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl66/Options
mkdir $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67/Options
mkdir $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67x/Options
mkdir  $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gplSC/Options
mkdir $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/69-extra/Options

cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsv2newmod.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl55/Options
cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsv2newmod.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl65/Options
cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsv2newmod.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl66/Options
cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsv2newmod.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67/Options
cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsaiv1.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gpl67x/Options
cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsaiv1.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/gplSC/Options
cp $WINEPREFIX/../INSTALL/frameRateSwitching/60fpsaiv1.xml $WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/69-extra/Options

# add some GEM+ track brochure photos that were missing

cp $WINEPREFIX/../INSTALL/addGEMpics/aintree.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/aintree
cp $WINEPREFIX/../INSTALL/addGEMpics/bugatti.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/bugatti
cp $WINEPREFIX/../INSTALL/addGEMpics/montlh66.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/montlh66
cp $WINEPREFIX/../INSTALL/addGEMpics/monza10k.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/monza10k
cp $WINEPREFIX/../INSTALL/addGEMpics/norisrng.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/norisrng
cp $WINEPREFIX/../INSTALL/addGEMpics/zelt67.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/zelt67
cp $WINEPREFIX/../INSTALL/addGEMpics/iofman.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/IofMan
cp $WINEPREFIX/../INSTALL/addGEMpics/Beal60s.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/Beal60s
cp $WINEPREFIX/../INSTALL/addGEMpics/Wilmot.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/Wilmot
cp $WINEPREFIX/../INSTALL/addGEMpics/skidfun.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/skidfun


echo " "; echo "step 6 of 8"; echo " "
echo ""; echo "installing tracks needed by 66 Can Am carset."; echo ""


echo ""; echo "installing St. Jovite"; echo ""

cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/gpl_stjovite
wine trackInstall.exe 2>/dev/null 1>/dev/null
# use stjovite exe instead?

echo ""; echo "installing BHampton"; echo ""

cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/GPL_Bhampton_v1.01
wine GPL_Bhampton_v1.01.exe 2>/dev/null 1>/dev/null

echo ""; echo "installing Riverside 66"; echo ""

cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/GPL_Riverside_66_6v1.0
wine GPL_Riverside_66_6v1.0.exe 2>/dev/null 1>/dev/null

echo ""; echo "installing Nassau"; echo ""

cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/GPL_Nassau_v1.0
wine GPL_Nassau_v1.0.exe 2>/dev/null 1>/dev/null

echo ""; echo "installing Stardust"; echo ""

cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/Stardust v1.0"
wine "Stardust v1.0.exe" 2>/dev/null 1>/dev/null

# laguna not installing, don't know why
#echo ""; echo "installing Laguna 67"; echo ""

#cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/Laguna67_v1.1"
#wine TrackInstall.exe 2>/dev/null 1>/dev/null


rsync -a $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/TrackINI_fix/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/nassau/ 2>/dev/null 1>/dev/null


rsync -a $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/StJovite_mini_texture_addon/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/stjovite 2>/dev/null 1>/dev/null


#rsync -a "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/CanAm gfx addons x laguna67/laguna67/" $WINEPREFIX/drive_c/Sierra/GPL/tracks/laguna67/ 2>/dev/null 1>/dev/null


rsync -a "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/CanAm gfx x Stardust/stardust/" $WINEPREFIX/drive_c/Sierra/GPL/tracks/stardust 2>/dev/null 1>/dev/null

# add missing brochure pictures
#cp $WINEPREFIX/../INSTALL/addGEMpics/laguna67.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/laguna67
cp $WINEPREFIX/../INSTALL/addGEMpics/stjovite.jpg $WINEPREFIX/drive_c/Sierra/GPL/tracks/stjovite


echo " ";        echo "step 7 of 8"; echo " "
echo ""; echo "installing 67 Formula 2 carset"; echo ""


cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/mods/67F2/
wine 67F2_Mod_for_Grand_Prix_Legends_v1.0.exe 2>/dev/null 1>/dev/null

echo " ";        echo "step 8 of 8"; echo " "
echo ""; echo "installing 66 Can Am carset"; echo ""


cd $WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/mods/CA66/
wine gplcanam1966_1.16.04.12.exe 2>/dev/null 1>/dev/null



echo ""; echo "In the Wine Configuration dialog, select the Graphics tab."
echo "Select Emulate a virtual desktop.  Enter your monitor resolution in the"
echo "Desktop size boxes. Then select OK"
echo "Press enter to continue to the Wine Configuration dialog"
read userInput
winecfg 2>/dev/null 1>/dev/null

fi  # close of installation if clause

# shuffle the drivers so you face different competitors each time you race the AI, rather than the fastest drivers every time
cd $WINEPREFIX/..
./randomizeDrivers.sh
echo ""; echo "Running GEM+ ..."; echo ""
wine "$WINEPREFIX/drive_c/GPLSecrets/GEM+/GEMP2.exe" 2>/dev/null 1>/dev/null

clear
printf "Grand Prix Legends Optional Scripts:\n\nReal-time telemetry for 55, 66, 67 and 67x mods:\n"$WINEPREFIX"/../twoMonitorTelemetry.sh\n\nChange GPL race lineup for 65,67 and 67x mods:\n"$WINEPREFIX"/../editRaceLineup.sh\n\n"
exit 0




