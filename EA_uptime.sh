#!/bin/sh

uptime=$( uptime )
dayCount=$( uptime | awk -F "(up | days)" '{ print $2 }' | sed 's/[ day].*//' )

if [[ $uptime == *"day"* ]]; then
    echo "<result>$dayCount</result>"
    
else echo "<result>0</result>"
    
fi
    
exit 0
