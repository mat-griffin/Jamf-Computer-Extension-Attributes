#!/usr/bin/env bash
export PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin

# Checks on if the bootstrap token is supported and escrowed by MDM

# Validating minimum OS version for attribute (10.15.0 or later)

OSVersion=$(sw_vers -productVersion)
OSVersionMajor=$(echo $OSVersion | cut -d '.' -f 1)
OSVersionMinor=$(echo $OSVersion | cut -d '.' -f 2)

if [[ $OSVersionMajor -eq 10 ]] && [[ $OSVersionMinor -lt 15 ]]; then
    echo "<result>Not Supported</result>"
    exit 0
fi
set -x
StatusBootstrapToken=$(sudo profiles status -type bootstraptoken 2>/dev/null)
if [[ -n "$StatusBootstrapToken" ]]; then

    Supported=$(echo "$StatusBootstrapToken" | awk '/supported/{print $NF}')
    Escrowed=$(echo "$StatusBootstrapToken" | awk '/escrowed/{print $NF}')

    if [[ "${Supported}" == "YES" ]] && [[ "$Escrowed" == "YES" ]]; then
        Result="Escrowed"
    elif [[ "${Supported}" == "YES" ]] && [[ "$Escrowed" == "NO" ]]; then
        Result="Not Escrowed"
    elif [[ "${Supported}" == "NO" ]] && [[ -z "${Escrowed}" ]]; then
		Result="Broken"
    fi
fi

echo "<result>$Result</result>"
