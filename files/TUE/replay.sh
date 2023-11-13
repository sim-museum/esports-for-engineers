#!/bin/bash

$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
if [ $? -ne 0 ]; then
        exit 1
fi


export WINEPREFIX=$PWD/WP

if [ -d $WINEPREFIX/drive_c/Sierra ]
then
  cd "$WINEPREFIX/drive_c/Program Files (x86)/GPL Replay Analyser"
  wine GPLReplayAnalyser.exe 2>/dev/null 1>/dev/null
  exit 0
else
   echo ""; echo "GPL Replay Analyzer not installed."
   echo "To install it, from launcher.py choose TUE, then Historical Grand Prix Sim Racing"
   echo "Or cd to the TUE directory and run the script ./gpl.sh"; echo ""
   exit 0
fi
