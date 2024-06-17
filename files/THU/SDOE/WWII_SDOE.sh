export WINEPREFIX=$PWD/WP

if [ -f "$WINEPREFIX/drive_c/Program Files/Fighter Squadron/Sdemons.exe" ]
then
	cd "$WINEPREFIX//drive_c/Program Files/Fighter Squadron"
	wine Sdemons.exe 2>/dev/null 1>/dev/null
	exit 0
fi

printf "\n\nWWII Fighter Squadron not installed.  Run "$WINEPREFIX"/../install_SDOE.sh first.\n."

