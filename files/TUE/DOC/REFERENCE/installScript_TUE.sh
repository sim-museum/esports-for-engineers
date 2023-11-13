# script for installing Grand Prix Legends Demo
# manually clicking through installers is a big part of this process
# a GUI harness would be needed to automate it

cd EngineeringWeek/
cd TUE/
cd installFiles/
# start TUE install
# starting directory EngineeringWeek/installFiles/TUE
# installing GPL Demo by following 
# EngineeringWeek/TUE/DOC/GPL_Easy_Installation_Guide_ENG_v2.1.pdf
cd ../../TUE/WP
export WINEPREFIX="$PWD"
cd ../../installFiles/TUE/
cd gpl-demo/
# install gpl 2004 free demo
# Important note - choose C:\Sierra|GPL as the install location!!!
# do not accept the default location Program Files(x86)\GPL DEMO 2004
# this will save you time during the install
# because most add ons use C:\Sierra\GPL as the default location.
wine gpl_2004_demo.exe 
# No need to install Wine Mono or Wine Gecko
# if, when copying gpl-demo installs, some text in GPL becomes garbled, 
# reinstalling the rasterizer updates via wine gplrast_v2.5.exe solves the problem

# here we run wine gplrast_v2.5.exe for the first time
wine gplrast_v2.5.exe 

# and one final GPL demo patch ...
cd GPL_67_PATCH/
wine 1967_PATCH_v1.3_Setup.exe 
cd ..
# now install the GEM+ launcher
wine GEMPackage_2.5.0.32.exe 
cd $WINEPREFIX
cd drive_c/
cd Sierra/GPL/
# per Install pdf instructions to make exports directory
mkdir exports
echo $WINEPREFIX
wine gpl.exe 
wine ../../GPLSecrets/GEM+/GEMP2.exe 
# delete TUE/WP/drive_c/users/Public/Documents/GEM+/GEM.ini before running GEMP+ for the first time!!!
# otherwise GEM will hang per the documentation in gem.pdf
wine ../../GPLSecrets/GEM+/GEMP2.exe 
export WINEPREFIX="$PWD"
wine gpl.exe 
winecfg
wine gpl.exe 
wine --version
# the 2020 demo was not used because it is incompatible with GEM+, but to run it one would use the command: wine gpl2020demo.exe 
export WINEPREFIX="$PWD"
cd ..
# run the 3 programs that install the GPL 2004 demo
wine ../installFiles/TUE/gpl-demo/gpl_2004_demo.exe 
wine ../installFiles/TUE/gpl-demo/gpl_2004_demo.exe 
# to speed up installation, enter "C:\Sierra\GPL" as the installation directory for GPL demo
# this makes it easier to install car mods and tracks later, because
# the default GPL location for these other installers is C:\Sierra\GPL
# the TUE installs do not need wine Mono or wine Gecko
wine ../installFiles/TUE/gpl-demo/gplrast_v2.5.exe 
wine ../installFiles/TUE/gpl-demo/GPL_67_PATCH/1967_PATCH_v1.3_Setup.exe 
# now start gpl.exe and create your first driver name, i.e. "linux driver67"
wine WP/drive_c/Sierra/GPL/gpl.exe 
# set the name in the "Player Info" screen
# also calibrate your joystick and buttons, and select OpenGLV2 as your rasterizer
# when prompted.  Set the screen resolution to your desktop screen resolution
# the "Player Info" screen is often slow to respond here, but this will improve
# later
wine WP/drive_c/Sierra/GPL/gpl.exe 
# if the screen is unresponsive, hit <ALT> F6 if using Ubuntu linux to give the GPL window keyboard focus
# now you are ready to install the GEM+ launcher, (see GPL Easy Installation Guide pdf)
wine ../installFiles/TUE/gpl-demo/GEMPackage_2.5.0.32.exe 
# be sure to set the GPL path to C:\Sierra\GPL
# before starting GEM+, you must create the C:\Sierra\GPL\exports directory and
# delete EngineeringWeek/TUE/WP/drive_c/users/Public/Documents/GEM+/GEM.ini
# if you have purchased GPL, you can use the iso file rather than the demo as follows:
mkdir iso
# sudo mount -o loop ../installFiles/TUE/notUsed/Grand\ Prix\ Legends-FR.iso iso
# wine ../installFiles/TUE/notUsed/gplinstall_beta_1.08.exe 
winecfg
# if you want to add tracks at this point, follow the instructions in
# ../installFiles/TUE/Doc/GPL\ 2020\ Demo\ Instructions.pdf 
# now run GEM+ for the first time
wine WP/drive_c/GPLSecrets/GEM+/GEMP2.exe 
cd WP
export WINEPREFIX="$PWD"
cd ..
wine WP/drive_c/GPLSecrets/GEM+/GEMP2.exe 
# following the instructions in ../installFiles/TUE/Doc/GPL_Easy_Installation_Guide_ENG_v2.1.pdf 
# install the tracks for each mod, then install the mod itself, then proceed to the next mod
history > ../installFiles/TUE/scripts/
history > ../installFiles/TUE/scripts/historyBeforeModInstall.txt
# there are a lot of mods and tracks, so this takes a while
#
# starting with the tracks for the 55 mod
cp -R ../installFiles/TUE/addOns/tracks/55mod/1955_Spa67_Conversion_complete_gl_v1.0/spa67/ WP/drive_c/Sierra/GPL/tracks/
# now edit season67.ini to add the spa67 track, as described in ../installFiles/TUE/Doc/GPL\ 2020\ Demo\ Instructions.pdf
vim WP/drive_c/Sierra/GPL/seasons/67season.ini 
wine WP/drive_c/GPLSecrets/GEM+/GEMP2.exe 
# now add the 2nd 55mod track, aintree.  This time there is a full installer so you don't need to edit 67season.ini
wine ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/aintree_full_v2.exe 
echo $WINEPREFIX
wine ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/aintree_full_v2.exe 
# oops - aintree_full_v2.exe is just the unpacker, not the installer
wine ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/TrackInstall.exe 
echo $WINEPREFIX
wine ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/TrackInstall.exe 
wine ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/aintree_full_v2.exe 
wine ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/TrackInstall.exe 
cd ../installFiles/TUE/addOns/tracks/55mod/aintree_full_v2/
wine TrackInstall.exe 
cd ..
cd GPL_Buenos\ Aires\ 1955\ n.\ 2_v1.00/
wine GPL_Buenos\ Aires\ 1955\ n.\ 2_v1.00.exe 
cd ..
cd monza10k_v1full/
wine TrackInstall.exe 
cd ..
cd ../..
# now install the 55 mod
cd mods/
cd 55
wine GPL55F1_1.0.3.exe 
cd 55Mod_Update_
cd 55Mod_Update_Patch/
vim ReadMe\ -\ 55Mod\ Update\ Patch.txt 

# IMPORTANT
# to merge cars into GPL/cars, use the linux command rsync -a new/ old/

rsync -a cars/ $WINEPREFIX/drive_c/Sierra/GPL/cars/
cd ..
cd 55Mod_Update_Ferrari625_dash_FIX/
rsync -a cars/ $WINEPREFIX/drive_c/Sierra/GPL/cars/
cd ..
cd mirrorPositionFix/
rsync -a cars/ $WINEPREFIX/drive_c/Sierra/GPL/cars/
cd ~/200530/EngineeringWeek/installFiles/TUE/addOns
cd tracks/
# now get tracks for 65 mod
cd 65mod/
vim readme.txt 
wine GPL65ModTracks_0.5.exe 
# done with 65 tracks
cd ..
cd mods/
cd 65
wine GPL65F1_Alternative__2.0.2.exe 
# done with 65 mod (skipping skin updates which take up a lot of space and don't effect physics)
cd ..
cd tracks/
# Can Am 66 mod is next
ls ../mods
cd 66CAmod/
cd GPL_Bhampton_v1.01/
wine GPL_Bhampton_v1.01.exe 
cd ..
cd GPL_Nassau_v1.0/
wine GPL_Nassau_v1.0.exe 
cd GPL_Riverside_66_6v1.0/
wine GPL_Riverside_66_6v1.0.exe 
cd ..
cd gpl_stjovite/
wine trackInstall.exe 
cd ..
cd Laguna67_v1.1/
wine TrackInstall.exe 
cd ..
cd Stardust\ v1.0/
wine Stardust\ v1.0.exe 
cd ..
cd StJovite_mini_texture_addon/
cd ..
rsync -a StJovite_mini_texture_addon/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/stjovite/
cd ..
cd 66CAmod/
ls
ls TrackINI_fix/
ls
cd CA66_brm_A67dash/
ls
cd ..
cd CanAm\ gfx\ addons\ x\ laguna67/
ls
ls laguna67/
rsync -a laguna67/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/laguna67/
cd ..
ls
ls CA66_brm_A67dash/
ls
cd ..
ls
cd ..
cd mods/
ls
cd CA66/
ls
# now install Can Am 66 mod
wine gplcanam1966_1.16.04.12.exe 
# sell your soul to GPL?
# don't know where to put skin patch CA66_brm_A67dash, so don't use it
ls
cd ..
ls
# next, 66 mod tracks
cd ../tracks/
ls
cd 66mod/
ls
wine GPL_ltrackinstall_brands67v1.0_HR.exe
cd GPL_ltrackinstall_brands67v1.0_HR.exe/
ls
wine GPL_ltrackinstall_brands67v1.0_HR.exe 
cd ..
ls
cd oulton/
ls
wine TrackInstall.exe 
cd ..
ls
cd reims_gpl/
ls
wine TrackInstall.exe 
cd ..
ls
cd syracuse/
ls
wine TrackInstall.exe 
cd ../..
ls
cd ..
ls
# now install 66 mod
ls
cd mods/
ls
cd 66
ls
cd 1966_Mod_PATCH_v2.0/
ls
vim 66_Patch_v2.0_README.txt 
wine 1966mod_PATCH_v2.0_Setup.exe 
cd ..
ls
cd driv66/
ls
diff driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/driv66.ini
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/brands67
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/monza10k
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/mexico
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/zandvort
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/watglen
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/spa67
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/nurburg
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/spa
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/reims
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/monaco
cp driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/tracks/monza
cd ..
ls
cd ..
ls
# the 1967 F2 mod is next
cd ../tracks/
ls
cd 67F2mod/
ls
# again, skipping 1966 mod skin update to save space
ls
cd Jarama_bs/
ls
cd ..
ls
cd jarama_v10/
ls
wine TrackInstall.exe 
cd ..
ls
cd Jarama_bs/
ls
cd ..
rsync -a Jarama_bs/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/jarama
ls
cd ../..
cd mods
ls
cd 67F2/
ls
wine 67F2_Mod_for_Grand_Prix_Legends_v1.0.exe 
# again, skipping minor skin fixes
ls
cd ..
ls
# sports cars next
cd ../tracks/
ls
cd 67SCmod/
ls
cd bsarthe/
ls
wine TrackInstall.exe 
cd ..
ls
cd GPL_dayto24h_v1.0.exe/
ls
wine GPL_dayto24h_v1.0.exe 
cd ../GPL_mnz1000kv1.0.exe/
ls
wine GPL_mnz1000kv1.0.exe 
cd ..
ls
cd GPL_sebr67_v1.00.exe/
ls
wine GPL_sebr67_v1.00.exe 
cd ..
ls
# add the very long Targa track
wine GPL_Targa_Standard_v1.exe 
cd montlh66v1/
ls
wine trackInstall.exe 
cd ..
ls
cd norisrngv1.00/
ls
wine norisrngv1.00.exe 
cd ..
ls
cd zeltweg1967_GPL/
ls
wine zeltweg1967.exe 
cd ../..
ls
ls 67SCmod/
# done with 67 sports car tracks
cd ..
cd mods/
ls
cd 67SC/
ls
wine GPLSC_EXTRA_1.1.exe 
cd ..
ls
cd ..
ls
# next is the 67x mod
# refer to GPL_Easy_Installation_Guide_ENG_v2.1.pdf to follow along with the installation steps
ls tracks/
# the 67x mod does not add any new tracks
cd mods/
ls
cd 67x
ls
cd 67x
ls
ls GPL
vim README_GPL\ 1967\ F1\ Extra\ Mod\ -\ Online\ Edition\ \(2018\).txt 
ls
time rsync -a GPL/ $WINEPREFIX/drive_c/Sierra/GPL/
# it took 7 sec to copy 1.i Gig(!)
# 1.8 Gig
ls
cd ..
sl
ls
cd 67X
ls
cd 67x
ls
cd 1967x_setups/
ls
rsync -a setups/ $WINEPREFIX/drive_c/Sierra/GPL/setups/
# some copied files are readonly, so remove this constraint
# use chmod -R 777 from the base of the whole directory tree
ls
cd ..
ls
cd ..
ls
# next is 68 
cd ../tracks/
ls
# no new tracks for 68
cd ../mods/
ls
cd 68/
ls
cd 68\ mod/
ls
time rsync -a GPL/ $WINEPREFIX/drive_c/Sierra/GPL/
# it took 15 seconds to copy 2.7 Gibs
ls
cd ..
ls
cd GEM+\ pics/
ls
ls 68\ Mod\ Gem\ Plus\ Pics/
rsync -a 68\ Mod\ Gem\ Plus\ Pics/ $WINEPREFIX/drive_c/GPLSecrets/GEM+/Pictures/
cd ..
ls
# in GPL directory ran rsync -a mods/ Mods/
# then rm mods
# linux is case sensitive, Windows apparently not
# then rm -rf mods
ls
# didn't know where to put brabham skins, so skipped these cosmetic files
cd ..
ls
cd 69x
ls
# 69X mod is next
cd ..
ls
cd tracks/
ls
cd 69X/
ls
cd 69-Xtra_missing_track_files/
ls
ls gpl/
rsync -a gpl/ $WINEPREFIX/drive_c/Sierra/GPL/
cd ..
cd ../..
cd mods/69X/
ls
cd 69mod_Xtra_for_Grand_Prix_Legends/
ls
rsync -a GPL/ $WINEPREFIX/drive_c/Sierra/GPL/
# need to keep large mod files compressed to save space
ls
cd ..
ls
cd ..
ls
# only one left, the 71 Can Am mod
# first the tracks ...
cd ../tracks/
ls
cd 71CAmod/
ls
cd Donnybrooke_71_v1.0/
ls
wine Donnybrooke_71_v1.0.exe 
cd ..
ls
cd Edmonton/
ls
wine TrackInstall.exe 
cd ..
ls
cd midOCA71/
ls
wine midOCA71.exe 
vim ReadMe.txt 
vim Mirror\ Zone.txt 
ls
cd ..
ls
cd Road_America__1995__Wisconsin_Gran_Prix__GPL_/
ls
cd 'Road America  1995  Wisconsin Gran Prix (GPL)'
ls
wine TrackInstall.exe 
cls
ls
cd ..
ls
cd Road\ America\ graphics\ update/
ls
pwd
cd ..
ls
rsync -a 'Road America graphics update'/ $WINEPREFIX/drive_c/Sierra/GPL/tracks/elkhart/
cd ../..
ls
ls other
cd ..
ls
cd mods/
ls
cd CA71/
ls
wine CA71_1.0.exe 
ls
cd CA71_HistAdd_v1.0/
ls
okular ReadMe_CA71_Historical\ Add-on_v1.0.pdf 
ls
cd ..
ls
# not installing Can Am 71 historical add-ons, too big (1.6 Gig)
ls
cd ..
ls
cd ..
ls
cd tracks/
ls
cd other/
ls
# adding a few of the more popular extra tracks so the driver
# can participate in more online races

cd panorama/
ls
wine TrackInstall.exe 
cd ..
ls
cd 'GPLEA Solitude v1.0' 
ls
cd GPLEA\ Solitude\ v1.0/
ls
wine TrackInstall.exe 
ls
cd ..
ls
cd ..
ls
cd IsleMan/
ls
wine TrackInstall.exe 
ls
cd ..
ls
# now add the driver names in gpl driver info
# and adjust GEM+ config settings
# as described in GPL_Easy_Installation_Guide_ENG_v2.1.pdf
cd ..///
cd ..
ls
cd ..
ls
cd scripts/
ls
history > historyAfterModInstall.txt
cd ..
ls
cd addOns/
ls
cd mods/
ls
# names are, e.g., linux driver55, linux driver65, etc.
time tar czf ch_TUE_200531_00_13.tar.gz TUE
find . -print | grep driv66
pwd
find . -print | grep 7z
cp -R EngineeringWeek/ ../200531
time cp -R EngineeringWeek/ ../200531
cd WP
export WINEPREFIX="$PWD"
cd drive_c/
ls
cd Sierra/GPL/
ls
wine gpl.exe 
cd ../..
ls
cd GPLSecrets/
ls
cd GEM+/
ls
wine GEMP2.exe 
cd ../../installFiles/TUE/addOns/newGoodwood/
ls
wine GPL_goodwd65_v1.0.exe 
cd ..
ls
cd mods/
ls
cd ..
cd tracks/
ls
cd 66mod/
ls
cd ../..
ls
cd md
cd mods/
ls
cd 66/
l
ls
chmod +x gpl1966_1.0.exe 
ls
# installed the add-on v2 patch without installing the V1 patch first.  Trying again...
echo $WINEPREFIX
ls
wine gpl1966_1.0.exe 
cd 1966_Mod_PATCH_v2.0/
ls
vim 66_Patch_v2.0_README.txt 
ls
wine 1966mod_PATCH_v2.0_Setup.exe 
ls
cd ..
ls
cd driv66/
ls
diff driv66.ini $WINEPREFIX/../drive_c/Sierra/GPL/driv66.ini
diff driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/driv66.ini
kompare driv66.ini $WINEPREFIX/drive_c/Sierra/GPL/driv66.ini
cd ../..
cd ..
ls
echo $WINEPREFIX
# install replay analyzer
ls
cd replay\ analyzer/
ls
wine install.exe 
cd ..
ls
cd ..
ls
# install setup manager
mkdir setupManager
mv 'GPL Setup Manager v2.7.0.zip' setupManager/
cd setupManager/
ls
unzip GPL\ Setup\ Manager\ v2.7.0.zip 
ls
cd GPL\ Setup\ Manager\ v2.7.0/
ls
ls 'GPL Setup Manager v2.7.0 Release Package'/
cd ../..
ls
cd setupManager/
ls
cd GPL\ Setup\ Manager\ v2.7.0/
ls
clear
ls
cd 'GPL Setup Manager v2.7.0 Release Package'
ls
cd ..
ls
rsync -a 'GPL Setup Manager v2.7.0 Release Package'/ "$WINEPREFIX/drive_c/GPLSecrets/GPL Setup Manager/"
# now add the driver names in gpl driver info
# and adjust GEM+ config settings
# as described in GPL_Easy_Installation_Guide_ENG_v2.1.pdf
# names are, e.g., linux driver55, linux driver65, etc.
cd GPLSecrets/
cd GEM+/
wine GEMP

