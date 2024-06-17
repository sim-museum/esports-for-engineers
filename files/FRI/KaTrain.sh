# Script Outline:
#
# 1. Export WINEPREFIX
# 2. Change directory to KaTrain installation directory
# 3. Run KaTrain using Wine
# 4. Print out credits and usage tip

#!/bin/bash

# Define variables for readability
INSTALL_DIR="$PWD/INSTALL"
WINEPREFIX_DIR="$PWD/WP"
KATRAIN_DIR="$WINEPREFIX_DIR/../INSTALL/KaTrain"
DOC_DIR="$WINEPREFIX_DIR/../DOC"

# Export WINEPREFIX
export WINEPREFIX="$WINEPREFIX_DIR"

# Change directory to KaTrain installation directory
cd "$KATRAIN_DIR" || exit 1

# Run KaTrain using Wine
wine KaTrain.exe 2>/dev/null 1>/dev/null

# Print out credits
cat "$DOC_DIR/KaTrainDoc.txt"
printf "\n\nKaTrain tip: To change Katago engines, click the menu at top left, select General Engine Settings,\nselect download engines, and then pick one of these engines to install.\n\n"

