# bash commands to install the MON directory
# the only directory tree at the start is installFiles
cd EngineeringWeek
mkdir MON TUE WED THU FRI SAT SUN
mkdir MON/WP TUE/WP WED/WP THU/WP FRI/WP SAT/WP SUN/WP
mkdir MON/DOC
mkdir MON/INSTALL
mkdir MON/LINUX
cd MON/WP

# set the wine directory
export WINEPREFIX="$PWD"
cd ..

# cd to the installFiles directory tree

cd installFiles/MON/
cp scripts/*.sh "$WINEPREFIX/.."
cp * "$WINEPREFIX/../INSTALL"
cp doc/* "$WINEPREFIX/../doc"

# in winecfg, manually set windows version emulated to Windows XP, 
# otherwise wBridge5 save/load does not work
winecfg

# unzip the windows version of bcalc to the wine directory
unzip bcalc19080_win64.zip -d $WINEPREFIX
cd $WINEPREFIX

# unpack the windows version of bcalc
wine bcalcgui.exe 

cd ..

# now unpack the linux version, which will be the default version
# if the needed libraries are present
# on Ubuntu 20.04 this requires issuing the following command:
# sudo apt install -y wine liblua5.2-dev libqt5widgets5

# statically linking the linux binaries would allow portability
# to different Ubuntu versions and different distros
# but this remains to be done

mkdir LINUX
ls
cd ../installFiles/MON/

# windows version of bcalc works, now install linux version too
# linux version requires these librares to be loaded in linux:
# In ubuntu 20.04, the library names are: liblua5.2-dev libqt5widgets5
cp bcalc19080_linux_x86-64.tar.gz "$WINEPREFIX/../LINUX"
cd "$WINEPREFIX/../LINUX"
tar xzf bcalc19080_linux_x86-64.tar.gz 
