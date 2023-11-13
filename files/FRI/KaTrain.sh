#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi

export WINEPREFIX="$PWD/WP"
cd "$WINEPREFIX/../INSTALL/KaTrain"

wine KaTrain.exe 2>/dev/null 1>/dev/null
# print out credits
cat $WINEPREFIX/../DOC/KaTrainDoc.txt
printf "\n\nKaTrain tip: To change Katago engines, click the menu at top left, select General Engine Settings,\nselect download engines, and then pick one of these engines to install.\n\n"

