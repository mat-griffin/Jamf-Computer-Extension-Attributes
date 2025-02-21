#!/bin/zsh

#Get the WiFi port ID
WiFi=$(/usr/sbin/networksetup -listallhardwareports | /usr/bin/awk '/Wi-Fi|AirPort/{getline; print $NF}')

#Get the SSID
SSID=$(/usr/sbin/ipconfig getsummary "$WiFi" | /usr/bin/awk -F ' SSID : ' '/ SSID : / {print $2}')

echo "<result>$SSID</result>"