#!/bin/bash

echo ""
echo "If an installation is not working correctly,"
echo "it can be helpful to delete the installation"
echo "and re-install."
replyString=input("Press Enter to uninstall or <CTRL> C to cancel.")
rm -rf WP
mkdir WP
