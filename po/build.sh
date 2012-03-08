#!/bin/bash

if [ $(basename $PWD) != "po" ]
then
	echo "You must to execute this script using po directory as working directory"
	exit 1
fi

for F in $(find -regex ".*\.po" -printf "%f ")
do
	LANG=$(echo $F | cut -d "." -f 1)
	echo "Compiling $LANG"
	
	LANGDIR="../locale/$LANG/LC_MESSAGES"
	mkdir -p "$LANGDIR" 
	msgfmt -o "$LANGDIR/dynamic-separator-applet.mo" $F
done

