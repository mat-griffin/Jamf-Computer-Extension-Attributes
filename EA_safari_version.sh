#!/bin/sh

if [ -d /Applications/Safari.app ] ; then
    RESULT=$( sudo defaults read /Applications/Safari.app/Contents/Info CFBundleShortVersionString)
    echo "<result>$RESULT</result>"
else
    echo "<result>Not Installed</result>"
fi
