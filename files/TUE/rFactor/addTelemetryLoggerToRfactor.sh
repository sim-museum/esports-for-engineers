#!/bin/bash

#$PWD/INSTALL/checkWineVersion.sh 2>/dev/null 1>/dev/null
#if [ $? -ne 0 ]; then
#        exit 1
#fi

export WINEPREFIX="$PWD/WP"
if [ ! -d "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/Plugins/rFactor Data Acquisition Plugin" ]
then
       echo ""; echo "Installing telemetry logger.  During installation, deselect check for updates."
       echo "Otherwise, accept defaults."
       echo "To start logging time series telemetry data to a csv file,"
       echo "type <CTRL> m when in the rFactor 3D view."
       echo "Each time you cross the start/finish line, type <CTRL> m twice to create a new csv file for each lap."
       echo "To view telemetry data, exit rFactor and examine the csv files in the directory"
       echo "$WINEPREFIX/drive_c/Program Files (x86)/rFactor/UserData/LOG/MoTeC"
       echo ""
       wine "$WINEPREFIX/../INSTALL/rFactorDAQPluginSetup_1.3.2.exe" 2>/dev/null 1>/dev/null
       # switch log file format to .csv (the default is MoTec)
       cp "$WINEPREFIX/../INSTALL/DataAcquisitionPlugin.ini" "$WINEPREFIX/drive_c/Program Files (x86)/rFactor"
else
      echo " "; echo "The rFactor telemetry logger is already installed."; echo ""
fi
exit 0

