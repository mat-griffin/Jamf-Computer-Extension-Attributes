#!/bin/sh

# Description: Get's the health of the internal battery

if [[ $( system_profiler SPHardwareDataType | grep "Model Name:"  ) == *"Book"* ]]; then
    RESULT=$( system_profiler SPPowerDataType | grep "Condition" | sed 's/^.*: //' )
else
    RESULT="Not Installed"
fi

echo "<result>$RESULT</result>"
exit 0
