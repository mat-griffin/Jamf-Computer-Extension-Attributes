#!/bin/zsh

# EA - ActiveSSID
# Returns the currently active SSID
# activeSSID=$(/usr/sbin/networksetup -getairportnetwork en0 | sed 's/Current Wi-Fi Network: //g')
#echo "<result>$activeSSID</result>"

# Updated for macOS 15
#Get the WiFi ID
WiFi=$(/usr/sbin/networksetup -listallhardwareports | /usr/bin/awk '/Wi-Fi|AirPort/{getline; print $NF}')

#Get the SSID
SSID=$(/usr/sbin/ipconfig getsummary "$WiFi" | /usr/bin/awk -F ' SSID : ' '/ SSID : / {print $2}')

echo "<result>$SSID</result>"
