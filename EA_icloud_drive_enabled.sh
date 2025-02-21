#!/bin/bash

iCloudDrivePath="/Library/Mobile Documents/com~apple~CloudDocs"

grabConsoleUserAndHome()
{
currentUser=$(stat -f %Su "/dev/console")
homeFolder=$(dscl . read "/Users/$currentUser" NFSHomeDirectory | cut -d: -f 2 | sed 's/^ *//'| tr -d '\n')
  case "$homeFolder" in  
     *\ * )
           homeFolder=$(printf %q "$homeFolder")
          ;;
       *)
           ;;
esac
}

grabConsoleUserAndHome

if [[ "$currentUser" == "root" ]]
    then
        exit
fi

if [[ -e "$homeFolder""$iCloudDrivePath" ]]
    then
        echo "<result>True</result>"
    else
        echo "<result>False</result>"
fi

exit 0