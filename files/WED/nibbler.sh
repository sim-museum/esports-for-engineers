# Provide instructions for using the LCZero chess engine with Nibbler front end.
# Check if electron is installed, if not, provide installation instructions.
#  Check if lc0 is installed and provide instructions for its setup.

#!/bin/bash
clear

# Provide instructions for using the LCZero chess engine with Nibbler front end
echo "The first time you run the default Leela Chess Zero (lc0) front end, named nibbler,"
echo "you must specify the path to the lc0 chess engine."
export WINEPREFIX="$PWD/WP"
export WINEARCH=win32
wine winecfg -v winxp  2>/dev/null 1>/dev/null

# Check if lc0 is installed and provide instructions for its setup
cd "$WINEPREFIX/../INSTALL/"
if ./lc0_cpu --help 2>/dev/null 1>/dev/null; then
    echo "from the menu select Engine/Choose Engine"
    echo 'select (path)/WED/INSTALL/lc0_cpu'
    echo "next select the weights file WED/INSTALL/tinygyal-8.pb.gz"
    echo 'once you have selected lc0_cpu once, nibbler stores its location in ~/.config/Nibbler'
    echo 'so you do not have to enter this path again.'
    echo 'Optional: If you have a modern Nvidia GPU, you can run a faster version of lc0.'
    echo 'Optional: To do this in Ubuntu 24.04 LTS, first issue the command'
    echo 'Optional: sudo apt install -y nvidia-opencl-dev'
    echo 'Optional: then in the nibbler Engine/Choose Engine menu select'
    echo 'Optional: (path/WED/INSTALL/lc0_linux_graphicsAcceleration/lc0_opencl'
    echo 'If in doubt, start with the default lc0_cpu option as described above.'
    cd "$WINEPREFIX/../INSTALL/nibbler-2.4.6-linux"

    # due to updated security policies in Ubuntu 24.04, needed for electron-based applications
    sudo chown root chrome-sandbox
    sudo chmod 4755 chrome-sandbox
    ./nibbler --no-sandbox 
fi

