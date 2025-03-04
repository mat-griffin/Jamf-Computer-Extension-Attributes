#!/bin/sh

# EA - Get Safari CFBundleVersion

result="Not Installed"
PListToCheck="/Applications/Safari.app/Contents/Info.plist"

if [ -f "$PListToCheck" ] ; then
	result=$( /usr/bin/defaults read "$PListToCheck" CFBundleVersion )
fi

echo "<result>$result</result>"
