#!/bin/bash
if [ $# -ne 2 ]; then
	echo "Usage: $0 source_dir comment" 1>&2
	exit 1
fi

newname=$1.$2_`date +%Y-%m-%d.%H%M.bak`;
mv $1 $newname;
echo "Backing up $1 to $newname ...";
cp -pr $newname $1;
echo "Done."

