#!/bin/sh
arch=$(/usr/bin/arch)
if [ "$arch" == "arm64" ]; then # is rosetta 2 installed? 
    arch -x86_64 /usr/bin/true 2> /dev/null
    if [ $? -eq 1 ];
        then result="No"
    else result="Yes"
    fi
else result="Not Apple Silicon Mac"
fi
echo "<result>$result</result>"
