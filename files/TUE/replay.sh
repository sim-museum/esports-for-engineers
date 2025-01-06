#!/bin/bash

# Set the Wine prefix to the current directory's 'WP' folder
export WINEPREFIX="$PWD/WP"

# Check if the Sierra directory exists in the Wine prefix
if [ -d "$WINEPREFIX/drive_c/Sierra" ]; then
  # Navigate to the GPL Replay Analyser directory and run the executable
  cd "$WINEPREFIX/drive_c/Program Files/GPL Replay Analyser" || exit 1
  wine GPLReplayAnalyser.exe 2>/dev/null 1>/dev/null
  exit 0
else
   # Display a message if GPL Replay Analyzer is not installed
   echo ""
   echo "GPL Replay Analyzer not installed."
   echo "To install it, from launcher.py choose TUE, then Historical Grand Prix Sim Racing"
   echo "Or cd to the TUE directory and run the script ./gpl.sh"
   echo ""
   exit 0
fi

# End of script

