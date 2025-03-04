#!/bin/zsh

netskope_plist='/Library/Application Support/Netskope/STAgent/Netskope Client.app/Contents/Info.plist'

if [ -f "${netskope_plist}" ]
then
	netskope_version=$(defaults read "${netskope_plist}" CFBundleShortVersionString)
	echo "<result>${netskope_version}</result>"
else
	echo "<result>Not Installed</result>"
fi
