
#!/bin/bash

# This script runs a linux binary, with fallback to an .exe version running under wine
# bcalc web site: bcalc.w8.pl/

# Set the Wine prefix directory
export WINEPREFIX="$PWD/WP"

# Change directory to the application's directory
cd "$WINEPREFIX/../LINUX"

# Run the application
./bcalcgui 2>/dev/null 1>/dev/null || wine $WINEPREFIX/bcalcgui.exe 2>/dev/null 1>/dev/null 

# Clear the terminal
clear

# Display exit message
cat "$WINEPREFIX/../DOC/REFERENCE/exitMessageBcalc.txt"

# Add some space for better readability
echo ""
echo ""

# Exit with success status
exit 0

