#!/bin/bash


GEODATA=$( curl -s http://ip-api.com/json/ )

read -r -d '' citylookup <<EOF
function run() {
	var ipinfo = JSON.parse(\`$GEODATA\`);
	return ipinfo.city;
}
EOF

read -r -d '' countrylookup <<EOF
function run() {
	var ipinfo = JSON.parse(\`$GEODATA\`);
	return ipinfo.country;
}
EOF


CITY=$( osascript -l 'JavaScript' <<< "${citylookup}" )
COUNTRY=$( osascript -l 'JavaScript' <<< "${countrylookup}" )


echo "<result>${CITY}, ${COUNTRY}</result>"
