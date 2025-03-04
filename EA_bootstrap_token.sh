#!/bin/bash

# Checks on if the Bootstrap Token Allowed

# Validating minimum OS version for attribute (11.0 or later)
OSVersion=$(sw_vers -productVersion)
OSVersionMajor=$(echo $OSVersion | cut -d '.' -f 1)
OSVersionMinor=$(echo $OSVersion | cut -d '.' -f 2)
if [[ $OSVersionMajor -eq 11 ]]; then
echo "<result>Collected for macOS 11 or later</result>"
exit 0
fi

StatusBootstrapToken=$(/usr/libexec/mdmclient QueryDeviceInformation | grep BootstrapTokenAllowed | awk '/BootstrapTokenAllowed/{print $NF}' | tr -d ";")

echo "<result>$StatusBootstrapToken</result>"
