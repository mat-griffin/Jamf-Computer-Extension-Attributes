#!/bin/bash
#EA to check when application was last opened


Application="/Applications/Xcode.app"
if [ -e "$Application" ]; then
lastOpen=`mdls "$Application" -name kMDItemLastUsedDate | awk '{print $3,$4}'`
echo "<result>$lastOpen</result>"
else
"<result>Never</result>"
fi