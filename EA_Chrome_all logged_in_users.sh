#!/bin/bash

# This attribute returns the default user logged into Google Chrome
# Grabs the Chrome users logged in, filters to just @DOMAIN to remove any other email addresses and then removes duplicate @DOMAIN plus blank lines

# Altered by MGeorgeCV, Original Created by Ryan Ball at Alectrona https://community.jamf.com/t5/jamf-pro/extension-attribute-to-find-out-the-accounts-signed-into-google/m-p/260780/emcs_t/S2h8ZW1haWx8dG9waWNfc3Vic2NyaXB0aW9ufEwwSzJETEw4T05VSjhDfDI2MDc4MHxTVUJTQ1JJUFRJT05TfGhL#M240593
# Addition - Set Domain to grep & sed remove duplicate lines

loggedInUser=$( echo "show State:/Users/ConsoleUser" | /usr/sbin/scutil | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }' )
loggedInHome=$(/usr/bin/dscl . -read "/Users/$loggedInUser" NFSHomeDirectory 2> /dev/null | /usr/bin/awk '{print $NF}')
chromeLocalStateFile="${loggedInHome}/Library/Application Support/Google/Chrome/Local State"
osVersMajor=$(/usr/bin/sw_vers -productVersion | /usr/bin/awk -F '.' '{print $1}')

# Set Domain
Domain="@DOMAIN"
unset chromeLocalState chromeUserName plist

# Exit if nobody is logged in or ef Chrome's Local State file does not exist
[[ -z "$loggedInUser" ]] || [[ ! -e "$chromeLocalStateFile" ]] && exit 0

# Convert the Chrome Local State file to plist and extract the Default user_name
plist=$(/bin/cat "$chromeLocalStateFile" 2> /dev/null | /usr/bin/plutil -convert xml1 -o - -- -)

# Extract User Name and grep with set domain
    chromeUserName=$(echo "$plist" | /usr/bin/grep -A 1 user_name | /usr/bin/grep string | /usr/bin/sed -e 's/<[^>][^>]*>//g' | /usr/bin/awk '{print $1}' | /usr/bin/grep $Domain )
	
# sed - Delete duplicate consecutive lines from a file (emulates "uniq").
# First line in a set of duplicate lines is kept, rest are deleted.	
	GoogleLoginEmail=$(echo "$chromeUserName" | sed '$!N; /^\(.*\)\n\1$/!P; D' )

# Print the user name if it exists
if [[ -n "$GoogleLoginEmail" ]]; then
    echo "<result>$GoogleLoginEmail</result>"
fi

exit 0
