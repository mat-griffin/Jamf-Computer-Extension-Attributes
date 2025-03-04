#!/bin/sh

crntusr="$(/usr/bin/stat -f %Su /dev/console)"
brewchk="$(/usr/bin/sudo -i -u "$crntusr" /usr/bin/which brew)"

if [ -z "$brewchk" ]
then
	echo "<result>Not Installed</result>"
else
	echo "<result>$brewchk</result>"
fi
