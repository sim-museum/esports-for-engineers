#!/bin/bash
# reset the monitors to max resolution after a specified delay
# which must be an integer number of minutes
#
# this recovers from an error condition in
# which one of the THU games locks the
# displays
# 
# if this happens, another thing to 
# try is pressing <CTRL><ALT> F1 
# which brings up the login screen in Ubuntu

if [ $# -ne 1 ]; then
	echo " "; echo "Incorrect input."; echo " "
	echo "This shell script requires one argument, which must be an integer."
	echo "The argument is the number of minutes to wait before"
	echo "resetting the display monitor (or monitors) to max resolution."
	echo " "
	echo "Run this script if you anticipate that a sim may lock up the display(s)."
	echo " "
	exit 1
fi

delaySeconds=$(( $1*60))
#echo "multiplication of $1 and 60 yields $delaySeconds"
sleep $delaySeconds
xrandr -q | grep connected | grep -v disconnected | cut -d ' ' -f 1 | ./.delayedMonitorReset_helper.sh
echo " "; echo "delayedMonitorReset: resetting monitors after $1 minute(s)."; echo " "

