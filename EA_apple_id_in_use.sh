#!/bin/sh
## Gets the AppleID logged in
loggedInUser=$(stat -f%Su /dev/console)
icloudaccount=$( defaults read /Users/$loggedInUser/Library/Preferences/MobileMeAccounts.plist Accounts | grep AccountID | cut -d '"' -f 2)
if [ -z "$icloudaccount" ] 
then
    echo "<result>No Account Signed In</result>"
else
    echo "<result>$icloudaccount</result>"
fi
