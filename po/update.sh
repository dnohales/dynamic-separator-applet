#!/bin/bash

if [ $(basename $PWD) != "po" ]
then
	echo "You must to execute this script using po directory as working directory"
	exit 1
fi

intltool-update -p -g dynamic-separator-applet

