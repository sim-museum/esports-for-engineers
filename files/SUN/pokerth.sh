# Outline of the script:
#
# This script sets up the environment variables necessary for running PokerTH
# and then executes the PokerTH executable. It ensures that the LD_LIBRARY_PATH
# is set to the installation directory's libs folder and QT_QPA_FONTDIR is set
# to the installation directory's fonts folder. Finally, it runs the PokerTH
# executable while suppressing both stdout and stderr.

#!/bin/bash

# Define the directory path for PokerTH installation
install_dir="$PWD/INSTALL/PokerTH-1.1.2"

# Set LD_LIBRARY_PATH to the installation directory's libs folder
LD_LIBRARY_PATH="$install_dir/libs"
export LD_LIBRARY_PATH

# Set QT_QPA_FONTDIR to the installation directory's fonts folder
export QT_QPA_FONTDIR="$install_dir/data/fonts"

# Run PokerTH executable, suppressing both stdout and stderr
"$install_dir/pokerth" 2>/dev/null 1>/dev/null

