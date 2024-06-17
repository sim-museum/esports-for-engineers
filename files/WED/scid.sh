#!/bin/bash

# This script is used to run Scid with optional setup instructions for lc0 chess engine.

# Notify the user about setting up the lc0 chess engine.
echo "The first time you run Scid you should specify the path to the lc0 chess engine."
echo "From the menu select Tools/Analysis Engine.../New and specify the name and path for the lc0 executable."
echo "The Linux version of lc0 is INSTALL/lc0_cpu."
echo "The Windows version of lc0 is INSTALL/lc0_win/lc0.exe."
echo ""

# Set up WINEPREFIX for Wine environment and navigate to the INSTALL directory.
export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/../INSTALL"

# Clear the terminal and attempt to run Scid.
clear
scid 2>/dev/null 1>/dev/null || wine "$WINEPREFIX/drive_c/Scid-4.7.0/bin/scid.exe" 2>/dev/null 1>/dev/null

# Clear the terminal after Scid execution.
clear

# Inform the user about optional scripts for Scid.
echo -e "Scid optional scripts:\n\nRandomly choose opening book move (to practice different positions):\ngrandmasterOpeningMove.sh\n\n"

# End of script.


