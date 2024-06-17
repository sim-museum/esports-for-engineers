export WINEPREFIX=$PWD/WP
clear
printf "If all theaters are installed, but the list of theaters\n in the BMS Theater tab is incorrect, press a key to continue.\nOtherwise, press CONTROL C\n\n"


read replyString

cp "$WINEPREFIX/../INSTALL/theater.lst" "$WINEPREFIX/drive_c/Falcon BMS 4.35/Data/TerrData/TheaterDefinition"
