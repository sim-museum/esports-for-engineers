#!/bin/bash

# run this script to adjust the AI back to its 36 fps default behavior
# you need to do this when switching from 60 fps to back to the defaul 36 fps frame rate

export WINEPREFIX="$PWD/../WP"
cp "$WINEPREFIX/drive_c/Sierra/GPL/bak/gpl_ai.ini" "$WINEPREFIX/drive_c/Sierra/GPL"

