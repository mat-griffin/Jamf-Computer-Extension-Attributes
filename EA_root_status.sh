#!/bin/sh

if [[ $(dscl . -read /Users/root Password) = *'Password: ********'* ]]; then
echo "<result>Enabled</result>"

else
echo "<result>Disabled</result>"
fi
exit
