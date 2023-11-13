#!/bin/bash

echo ""
echo "If an installation is not working correctly,"
echo "it can be helpful to delete the installation"
echo "and re-install."
echo "Press Enter to uninstall or <CTRL> C to cancel."
read replyString
rm -rf WP
mkdir WP
