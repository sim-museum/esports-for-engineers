#!/bin/bash

# run this script to patch the AI if the "60fpsaiv1" 60 frames per second (fps) option is chosen on the lower right window in GEM+
export WINEPREFIX="$PWD/../WP"
cp "$WINEPREFIX/drive_c/Sierra/GPL/gpl_ai_60fps.ini" "$WINEPREFIX/drive_c/Sierra/GPL/gpl_ai.ini"

