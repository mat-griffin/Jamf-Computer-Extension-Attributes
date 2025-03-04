#!/bin/zsh

loggedInUser=$(stat -f %Su /dev/console)
loggedInUserIsAdmin="No"
if id -Gn $loggedInUser | grep -q -w admin; then
    loggedInUserIsAdmin="Yes"
fi
echo "<result>$loggedInUserIsAdmin</result>"
