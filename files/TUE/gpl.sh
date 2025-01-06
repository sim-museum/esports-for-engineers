# Script Outline:
# 1. Sets up Wine prefix.
# 2. Checks if GPL executable exists, if not, prompts for installation.
# 3. Installs GEM+ and related components.
# 4. Installs additional tracks and carsets.
# 5. Performs additional configurations and cleanup.
# 6. Runs GEM+.
# 7. Displays optional scripts for Grand Prix Legends.
# 8. Exits the script.
#!/bin/bash

# Set WINEPREFIX to the current working directory with /WP appended
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Check if the GPL executable does not exist in the specified directory
if [ ! -f "$WINEPREFIX/drive_c/Sierra/GPL/gpl.exe" ]; then
    clear # Clear the terminal

    # Check if the setup executable exists in the isoDir directory
    if [ -f "$WINEPREFIX/../isoDir/SETUP.EXE" ]; then
        echo ""; echo "Installing using mounted GPL iso ..."; echo ""
        echo ""; echo "Step 1 of 2: install GPL version 1.08"; 
        echo "If asked whether to install wine-mono package, select Cancel."
        echo "When asked for path to GPL, select isoDir."
        echo "If prompted about a missing readme file, select Ignore."
        echo "If prompted with a file exists error dialog box, (which may be behind another dialog box), select OK."
        echo "Later in the install, when prompted to choose two names for chat, choose any names you want."
        echo ""
        # Install GPL using wine
        wine INSTALL/gplinstall_beta_1.08.exe 2>/dev/null 1>/dev/null
    else
        # Install the free demo version of GPL or full version if iso is downloaded
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

        # Install GPL demo using wine
        wine "$WINEPREFIX/../INSTALL/gpl_2004_demo.exe" 2>/dev/null 1>/dev/null

        # Check if GPL executable exists after installation
        if [ ! -f "$WINEPREFIX/drive_c/Sierra/GPL/gpl.exe" ]; then
            echo "ERROR: used default installation path instead of typing in the correct path,"
            echo "C:\Sierra\GPL"
            echo "You will need to start again.  Run ./gpl.sh, and this time paste in "
            echo "C:\Sierra\GPL for the GPL 2004 Demo installation path."
            echo ""
            # Clean up and exit
            rm -rf WP
            mkdir WP
            exit 0
        fi

        # Install GPL rasterizer
        wine "$WINEPREFIX/../INSTALL/gplrast_v2.5.exe" 2>/dev/null 1>/dev/null

        # Replace rd3d7v2.dll with roglv2.dll in app.ini
#        sed -i 's/rd3d7v2.dll/roglv2.dll/' "$WINEPREFIX/drive_c/Sierra/GPL/App.ini"

        # Install GPL 1967 patch
        wine "$WINEPREFIX/../INSTALL/GPL_67_PATCH/1967_PATCH_v1.3_Setup.exe" 2>/dev/null 1>/dev/null
    fi

    # Step 2: Install GEM+ car, track switcher/multiplayer/setup manager
    
    # Remove existing players directory and recreate it
    # A driver must be created before running GEM+

    echo ""; echo "Step 2 of 2: install GEM+ car, track switcher/multiplayer/setup manager"; echo ""
    rm -rf "$WINEPREFIX/drive_c/Sierra/GPL/players"
    mkdir "$WINEPREFIX/drive_c/Sierra/GPL/players"
    
    # Copy player-related files to GPL directory
    cp -r "$WINEPREFIX/../INSTALL/"*__Driver "$WINEPREFIX/drive_c/Sierra/GPL/players"
    cp "$WINEPREFIX/../INSTALL/app.ini" "$WINEPREFIX/drive_c/Sierra/GPL/"
    
    # Install GEMPackage
    wine INSTALL/GEMPackage_2.5.0.32.exe 2>/dev/null 1>/dev/null

    cp "$WINEPREFIX/../INSTALL/GEM.ini" "$WINEPREFIX/drive_c/Program Files/GPLSecrets/GEM+/"

    # also the GEM+ configuration directory under users/Public/Documents doesn't install correctly
    # rm -rf "$WINEPREFIX/drive_c/users/Public/Documents/GEM+"
    # cp -R "$WINEPREFIX/../INSTALL/GEM+" "$WINEPREFIX/drive_c/users/Public/Documents"
    
    # Backup GEM.ini, copy new GEM.ini, and modify iGOR.ini
    # must remove ini file so GEM initializes correctly

    sed -i 's/gplrank.info/igor.gplrank.de/' "$WINEPREFIX/drive_c/Program Files/GPLSecrets/iGOR/iGOR.ini"
    
    # Remove existing GPL Setup Manager directory, version 1.16, then copy new one, version 2.7
    rm -rf "$WINEPREFIX/drive_c/Program Files/GPLSecrets/GPL Setup Manager"
    cp -R "$WINEPREFIX/../INSTALL/GPL Setup Manager" "$WINEPREFIX/drive_c/Program Files/GPLSecrets"
    
    # Copy additional files for Pribluda and GEM+
    # installing pribluda needed if using GPL free demo, redundant if using GPL iso
    cp "$WINEPREFIX/../INSTALL/pribluda/"*.* "$WINEPREFIX/drive_c/Sierra/GPL"
    # make options, such as pribluda telemetry and head movement, available in GEM+
    cp "$WINEPREFIX/../INSTALL/GEM_options/"*.* "$WINEPREFIX/drive_c/Program Files/GPLSecrets/GEM+/Options"
    
    # Step 1 of 8: Install Challenge Rank tracks
    echo " "; echo "step 1 of 8"; echo " "
    echo ""; echo "Installing Challenge Rank tracks ..."; echo ""
    rsync -a "$WINEPREFIX/../INSTALL/Challenge Rank/" "$WINEPREFIX/drive_c/Sierra/GPL/tracks"
    
    # Step 2 of 8: Install Historical Rank tracks
    echo " "; echo "step 2 of 8"; echo " "
    echo "Installing Historical Rank tracks ..."; echo ""
    rsync -a "$WINEPREFIX/../INSTALL/Historic Rank/" "$WINEPREFIX/drive_c/Sierra/GPL/tracks"
    
    # Copy 67*.ini files to seasons directory
    cp $WINEPREFIX/../INSTALL/67*.ini "$WINEPREFIX/drive_c/Sierra/GPL/seasons"
    
    # Copy GPL 1967 F1 Extra Mod files
    rsync -a "$WINEPREFIX/../INSTALL/carsets/GPL 1967 F1 Extra Mod - Online Edition (2018)/GPL/" "$WINEPREFIX/drive_c/Sierra/GPL/"
    
    # If mods directory exists, move its contents to Mods directory
    # if GPL/mods is present, iGor fails with the message "could not open gplmods.ini"
    # apparently iGor looks in mods, if it exists, before looking in Mods
    if [ -d "$WINEPREFIX/drive_c/Sierra/GPL/mods" ]; then
        rsync -a "$WINEPREFIX/drive_c/Sierra/GPL/mods/" "$WINEPREFIX/drive_c/Sierra/GPL/Mods/" 2>/dev/null 1>/dev/null
        rm -rf "$WINEPREFIX/drive_c/Sierra/GPL/mods/"
    fi
    
    # Copy SVG_EDIT and GPLMotecAdd directories
    cp -r "$WINEPREFIX/../INSTALL/SVG_EDIT" "$WINEPREFIX/drive_c"
    cp -r "$WINEPREFIX/../INSTALL/GPLMotecAdd" "$WINEPREFIX/drive_c"
    
    # Step 3 of 8: Adding additional tracks
    echo " "; echo "step 3 of 8"; echo " "
    # Define directory paths
    additionalTracksDir="$WINEPREFIX/../INSTALL/additionalTracks"
    gplTracksDir="$WINEPREFIX/drive_c/Sierra/GPL/tracks"
    gplCarsetsDir="$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks"
    
    # Install additional tracks
    wine "$additionalTracksDir/GPL_Montjuic_Park_1969_v1.0.02.exe" 2>/dev/null 1>/dev/null
    rm -rf "$gplTracksDir/thruxton"
    wine "$additionalTracksDir/gpltrackinstall_thruxton_v1.0.exe" 2>/dev/null 1>/dev/null
    rsync -a "$additionalTracksDir/Thruxton_DB_extra_files/gpl/" "$gplTracksDir/"
    rsync -a "$additionalTracksDir/Thruxton_PS_mpost_update/gpl/" "$gplTracksDir/"
    cp "$additionalTracksDir/Thruxton_High_Res_textures/"*.* "$gplTracksDir/thruxton"
    wine "$additionalTracksDir/GPL_goodwd65_v1.0.exe" 2>/dev/null 1>/dev/null
    wine "$additionalTracksDir/spa67.exe" 2>/dev/null 1>/dev/null
    cd "$gplCarsetsDir/other/IsleMan"
    wine TrackInstall.exe 2>/dev/null 1>/dev/null
    wine "$additionalTracksDir/gpltrackinstall_Beal60s_v1.12.exe" 2>/dev/null 1>/dev/null
    wine "$additionalTracksDir/GPL_Wilmot_v1.0.exe" 2>/dev/null 1>/dev/null
    wine "$additionalTracksDir/GPL_Skidfun_v1.0.exe" 2>/dev/null 1>/dev/null
    rsync -a "$additionalTracksDir/skidfun_No-lava_cones-for-women/skidfun/" "$gplTracksDir/skidfun/"
    echo ""; echo "adding additional tracks needed by carsets"
    wine "$additionalTracksDir/GPL65ModTracks_0.5.exe" 2>/dev/null 1>/dev/null
    rsync -a "$WINEPREFIX/../INSTALL/tracks/" "$WINEPREFIX/drive_c/Sierra/GPL/tracks/"
    echo " "; echo "step 4 of 8"; echo " "
    echo ""; echo "installing 55, 65, 66, 67 sports cars, 69 carsets"; echo ""
    wine "$WINEPREFIX/../INSTALL/carsets/GPL55F1_1.0.3.exe" 2>/dev/null 1>/dev/null
    rsync -a "$WINEPREFIX/../INSTALL/carsets/55Mod_Update_Patch/" "$WINEPREFIX/drive_c/Sierra/GPL/"
    
    # Install additional carsets and mods
    
    # Install GPL 1965 alternative carset
    wine "$WINEPREFIX/../INSTALL/carsets/GPL65F1_Alternative__2.0.2.exe" 2>/dev/null 1>/dev/null
    
    # Install GPL 1966 carset
    wine "$WINEPREFIX/../INSTALL/carsets/gpl1966_1.0.exe" 2>/dev/null 1>/dev/null
    
    # Remove existing GPL66 mod directory and install 1966 Mod Patch
    rm -rf "$WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/GPL66"
    wine "$WINEPREFIX/../INSTALL/carsets/1966_Mod_PATCH_v2.0/1966mod_PATCH_v2.0_Setup.exe" 2>/dev/null 1>/dev/null
    
    # Install GPL Sound Carset Extra
    wine "$WINEPREFIX/../INSTALL/carsets/GPLSC_EXTRA_1.1.exe" 2>/dev/null 1>/dev/null
    
    # Install 1969 Extra carset
    wine "$WINEPREFIX/../INSTALL/carsets/69mod X'tra for Grand Prix Legends.exe" 2>/dev/null 1>/dev/null
    
    # Copy mods directory to Mods directory
    rsync -a "$WINEPREFIX/drive_c/Sierra/GPL/mods/" "$WINEPREFIX/drive_c/Sierra/GPL/Mods/" 2>/dev/null 1>/dev/null
    
    # Copy original driver ini files to GPL directory
    cp -r "$WINEPREFIX/../INSTALL/originalDriverIniFiles" "$WINEPREFIX/drive_c/Sierra/GPL"
    
    # Step 5 of 8: Install Replay Analyzer utility
    echo " "; echo "step 5 of 8"; echo " "
    echo ""; echo "Install Replay Analyzer utility"; echo ""
    wine "$WINEPREFIX/../INSTALL/replayAnalyzerInstall.exe" 2>/dev/null 1>/dev/null
    
    # Copy replay files to GPL replay directory
    rsync -a "$WINEPREFIX/../INSTALL/replay/" "$WINEPREFIX/drive_c/Sierra/GPL/replay/"
    
    # Backup and switch gpl_ai.ini files for frame rate switching
    mkdir "$WINEPREFIX/drive_c/Sierra/GPL/bak"
    cp "$WINEPREFIX/drive_c/Sierra/GPL/gpl_ai.ini" "$WINEPREFIX/drive_c/Sierra/GPL/bak"
    cp $WINEPREFIX/../INSTALL/frameRateSwitching/gpl_ai*.ini "$WINEPREFIX/drive_c/Sierra/GPL"
    
    # Remove existing options directories for frame rate switching
    # GPL demo sometimes creates options directories, sometimes with the demo
    # there are no [O,o]ptions directories.  Delete whatever
    # [O,o]ptions directories there are and standardize on Options
    COMMON_PATH="$WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+/"

    rm -rf "$COMMON_PATH"gpl55/options
    rm -rf "$COMMON_PATH"gpl65/options
    rm -rf "$COMMON_PATH"gpl66/options
    rm -rf "$COMMON_PATH"gpl67/options
    rm -rf "$COMMON_PATH"gpl67x/options
    rm -rf "$COMMON_PATH"gplSC/options
    rm -rf "$COMMON_PATH"69-extra/options

    rm -rf "$COMMON_PATH"gpl55/Options
    rm -rf "$COMMON_PATH"gpl65/Options
    rm -rf "$COMMON_PATH"gpl66/Options
    rm -rf "$COMMON_PATH"gpl67/Options
    rm -rf "$COMMON_PATH"gpl67x/Options
    rm -rf "$COMMON_PATH"gplSC/Options
    rm -rf "$COMMON_PATH"69-extra/Options

    # Use the variable in mkdir commands
    mkdir "${COMMON_PATH}gpl55/Options"
    mkdir "${COMMON_PATH}gpl65/Options"
    mkdir "${COMMON_PATH}gpl66/Options"
    mkdir "${COMMON_PATH}gpl67/Options"
    mkdir "${COMMON_PATH}gpl67x/Options"
    mkdir "${COMMON_PATH}gplSC/Options"
    mkdir "${COMMON_PATH}69-extra/Options"
   
    # Copy frame rate switching XML files to options directories
    FRAME_RATE_SWITCHING="$WINEPREFIX/../INSTALL/frameRateSwitching"
    GPL_MODS="$WINEPREFIX/drive_c/Sierra/GPL/Mods/GEM+"
    
    # Use the variables in the cp commands
    cp "$FRAME_RATE_SWITCHING/60fpsv2newmod.xml" "$GPL_MODS/gpl55/Options"
    cp "$FRAME_RATE_SWITCHING/60fpsv2newmod.xml" "$GPL_MODS/gpl65/Options"
    cp "$FRAME_RATE_SWITCHING/60fpsv2newmod.xml" "$GPL_MODS/gpl66/Options"
    cp "$FRAME_RATE_SWITCHING/60fpsv2newmod.xml" "$GPL_MODS/gpl67/Options"
    cp "$FRAME_RATE_SWITCHING/60fpsaiv1.xml" "$GPL_MODS/gpl67x/Options"
    cp "$FRAME_RATE_SWITCHING/60fpsaiv1.xml" "$GPL_MODS/gplSC/Options"
    cp "$FRAME_RATE_SWITCHING/60fpsaiv1.xml" "$GPL_MODS/69-extra/Options"
    cp $FRAME_RATE_SWITCHING/*.ini $WINEPREFIX/drive_c/Sierra/GPL
   
    # Copy additional track pictures
    GEMpics_dir="$WINEPREFIX/../INSTALL/addGEMpics"
    GPL_tracks_dir="$WINEPREFIX/drive_c/Sierra/GPL/tracks"
    
    # Copy each file using the variables
    cp "$GEMpics_dir/aintree.jpg" "$GPL_tracks_dir/aintree"
    cp "$GEMpics_dir/bugatti.jpg" "$GPL_tracks_dir/bugatti"
    cp "$GEMpics_dir/montlh66.jpg" "$GPL_tracks_dir/montlh66"
    cp "$GEMpics_dir/monza10k.jpg" "$GPL_tracks_dir/monza10k"
    cp "$GEMpics_dir/norisrng.jpg" "$GPL_tracks_dir/norisrng"
    cp "$GEMpics_dir/zelt67.jpg" "$GPL_tracks_dir/zelt67"
    cp "$GEMpics_dir/iofman.jpg" "$GPL_tracks_dir/IofMan"
    cp "$GEMpics_dir/Beal60s.jpg" "$GPL_tracks_dir/Beal60s"
    cp "$GEMpics_dir/Wilmot.jpg" "$GPL_tracks_dir/Wilmot"
    cp "$GEMpics_dir/skidfun.jpg" "$GPL_tracks_dir/skidfun"
 
    # Step 6 of 8: Install tracks needed by 66 Can Am carset
    echo " "; echo "step 6 of 8"; echo " "
    echo ""; echo "installing tracks needed by 66 Can Am carset."; echo ""
    echo ""; echo "installing St. Jovite"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/gpl_stjovite"
    wine trackInstall.exe 2>/dev/null 1>/dev/null
    
    echo ""; echo "installing BHampton"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/GPL_Bhampton_v1.01"
    wine GPL_Bhampton_v1.01.exe 2>/dev/null 1>/dev/null
    
    echo ""; echo "installing Riverside 66"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/GPL_Riverside_66_6v1.0"
    wine GPL_Riverside_66_6v1.0.exe 2>/dev/null 1>/dev/null
    
    echo ""; echo "installing Nassau"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/GPL_Nassau_v1.0"
    wine GPL_Nassau_v1.0.exe 2>/dev/null 1>/dev/null
    
    echo ""; echo "installing Stardust"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod/Stardust v1.0"
    wine "Stardust v1.0.exe" 2>/dev/null 1>/dev/null
    
    # Sync additional track files
    common_path="$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/tracks/66CAmod"
    tracks_path="$WINEPREFIX/drive_c/Sierra/GPL/tracks"
    
    rsync -a "$common_path/TrackINI_fix/" "$tracks_path/nassau/" 2>/dev/null 1>/dev/null
    rsync -a "$common_path/StJovite_mini_texture_addon/" "$tracks_path/stjovite" 2>/dev/null 1>/dev/null
    rsync -a "$common_path/CanAm gfx x Stardust/stardust/" "$tracks_path/stardust" 2>/dev/null 1>/dev/null
     
        # Copy additional track pictures
        cp "$WINEPREFIX/../INSTALL/addGEMpics/stjovite.jpg" "$WINEPREFIX/drive_c/Sierra/GPL/tracks/stjovite"
        
    # Step 7 of 8: Install 67 Formula 2 carset
    echo " "; echo "step 7 of 8"; echo " "
    echo ""; echo "installing 67 Formula 2 carset"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/mods/67F2/"
    wine 67F2_Mod_for_Grand_Prix_Legends_v1.0.exe 2>/dev/null 1>/dev/null
    
    # Step 8 of 8: Install 66 Can Am carset
    echo " "; echo "step 8 of 8"; echo " "
    echo ""; echo "installing 66 Can Am carset"; echo ""
    cd "$WINEPREFIX/../INSTALL/gpl_additionalCarsets_67F2_CA66/mods/CA66/"
    wine gplcanam1966_1.16.04.12.exe 2>/dev/null 1>/dev/null
    
    # Configuration instructions for Wine
    echo ""; echo "In the Wine Configuration dialog, select the Graphics tab."
    echo "Select Emulate a virtual desktop.  Enter your monitor resolution in the"
    echo "Desktop size boxes. Then select OK"
    echo "Press enter to continue to the Wine Configuration dialog"
    read userInput
    winecfg 2>/dev/null 1>/dev/null

# Close the installation clause
fi  

# Navigate to parent directory and run randomizeDrivers.sh
cd "$WINEPREFIX/.."
./randomizeDrivers.sh

# Run GEM+
echo ""; echo "Running GEM+ ..."; echo ""
echo "for Ubuntu 24.04 set the rasterizer on the inital GEM+ screen to OpenGL (not OpenGL v2)" 
echo "" 
wine "$WINEPREFIX/drive_c/Program Files/GPLSecrets/GEM+/GEMP2.exe" 2>/dev/null 1>/dev/null

# Print optional scripts information
clear
printf "Grand Prix Legends Optional Scripts:\n\nReal-time telemetry for 55, 66, 67 and 67x mods:\n"$WINEPREFIX"/../twoMonitorTelemetry.sh\n\nReduce number of laps in a race:\n"$WINEPREFIX"/../setRaceLaps.py\n\nReduce speed of AI cars:\n"$WINEPREFIX"/../slowDownGplAiCars.py\n\nUbuntu 24.04 configuration recommendations:\nOn the initial GEM+ screen, set rasterizer to Direct 3D\nFor smoother animation, select 60 fps - see\n$WINEPREFIX/../match_AI_to_frame_rate\n\n"

# Exit
exit 0

