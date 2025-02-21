#!/bin/sh

arch=$(/usr/bin/arch)

if [ "$arch" == "arm64" ]; then

capacity=$(system_profiler SPPowerDataType | grep "Maximum Capacity:" | sed 's/.*Maximum Capacity: //')
echo "<result>$(system_profiler SPPowerDataType | grep "Condition:" | sed 's/.*Condition: //') with $capacity capacity</result>"

elif [ "$arch" == "i386" ]; then

echo "<result>$(system_profiler SPPowerDataType | grep "Condition:" | sed 's/.*Condition: //')</result>"

else
echo "<result>Unknown Architecture</result>"
fi