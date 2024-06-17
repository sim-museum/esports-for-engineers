# Provide instructions for using the LCZero chess engine with Nibbler front end.
# Check if electron is installed, if not, provide installation instructions.
#  Check if lc0 is installed and provide instructions for its setup.

#!/bin/bash
clear

# Provide instructions for using the LCZero chess engine with Nibbler front end
echo "The first time you run the default Leela Chess Zero (lc0) front end, named nibbler,"
echo "you must specify the path to the lc0 chess engine."
export WINEPREFIX="$PWD/WP"

# Check if electron is installed, if not, provide instructions to install it
if ! electron --version &>/dev/null; then
    clear
    echo "electron not found. Install it via\n\nsudo npm install -g electron@28.0.0\n\nthen run this script again.\n\n"
    exit 0
fi

# Check if lc0 is installed and provide instructions for its setup
cd "$WINEPREFIX/../INSTALL/"
if ./lc0_cpu --help 2>/dev/null 1>/dev/null; then
    echo "from the menu select Engine/Choose Engine"
    echo 'select (path)/WED/INSTALL/lc0_cpu'
    echo "next select the weights file WED/INSTALL/tinygyal-8.pb.gz"
    echo 'once you have selected lc0_cpu once, nibbler stores its location in ~/.config/Nibbler'
    echo 'so you do not have to enter this path again.'
    echo 'Optional: If you have a modern Nvidia GPU, you can run a faster version of lc0.'
    echo 'Optional: To do this in Ubuntu 22.04 LTS, first issue the command'
    echo 'Optional: sudo apt install -y nvidia-opencl-dev'
    echo 'Optional: then in the nibbler Engine/Choose Engine menu select'
    echo 'Optional: (path/WED/INSTALL/lc0_linux_graphicsAcceleration/lc0_opencl'
    echo 'If in doubt, start with the default lc0_cpu option as described above.'
    cd "$WINEPREFIX/../INSTALL/nibbler/src"
    electron . 2>/dev/null 1>/dev/null
fi


