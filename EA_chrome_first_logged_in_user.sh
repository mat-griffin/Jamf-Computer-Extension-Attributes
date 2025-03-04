#!/bin/zsh
# Altered by MGeorgeCV, Original Created by Ryan Ball at Alectrona https://community.jamf.com/t5/jamf-pro/extension-attribute-to-find-out-the-accounts-signed-into-google/m-p/260780/emcs_t/S2h8ZW1haWx8dG9waWNfc3Vic2NyaXB0aW9ufEwwSzJETEw4T05VSjhDfDI2MDc4MHxTVUJTQ1JJUFRJT05TfGhL#M240593

# Returns the default user logged into Google Chrome
# Grabs the Chrome users logged in, filters to just @DOMAIN to remove any other email addresses
# Shows all address using @DOMAIN logged into
# Submits the first only as the Extension Attribute

loggedInUser=$( echo "show State:/Users/ConsoleUser" | /usr/sbin/scutil | /usr/bin/awk '/Name :/ && ! /loginwindow/ { print $3 }' )
loggedInHome=$(/usr/bin/dscl . -read "/Users/$loggedInUser" NFSHomeDirectory 2> /dev/null | /usr/bin/awk '{print $NF}')
chromeLocalStateFile="${loggedInHome}/Library/Application Support/Google/Chrome/Local State"
#osVersMajor=$(/usr/bin/sw_vers -productVersion | /usr/bin/awk -F '.' '{print $1}')

# Set Domain
Domain="@DOMAIN"
unset chromeLocalState chromeUserName plist

# Exit if nobody is logged in or ef Chrome's Local State file does not exist
[[ -z "$loggedInUser" ]] || [[ ! -e "$chromeLocalStateFile" ]] && exit 0

# Convert the Chrome Local State file to plist and extract the Default user_name
plist=$(/bin/cat "$chromeLocalStateFile" 2> /dev/null | /usr/bin/plutil -convert xml1 -o - -- -)

# Extract User Name and grep with set domain
chromeUserName=$(echo "$plist" | /usr/bin/grep -A 1 user_name | /usr/bin/grep string | /usr/bin/sed -e 's/<[^>][^>]*>//g' | /usr/bin/awk '{print $1}' | /usr/bin/grep $Domain )

# All Chrome IDs logged in	
MultiGoogleLoginEmail=$(echo "$chromeUserName" | sed '$!N; /^\(.*\)\n\1$/!P; D' )
echo "-----------------------------"
echo "All Chrome logged in IDs using @DOMAIN"
echo "$MultiGoogleLoginEmail"
echo "-----------------------------"
# The first Chrome ID logged in	
GoogleLoginEmail=$(echo "$chromeUserName" | sed -n '1p')
echo "The first Chrome logged in ID using @DOMAIN:"
echo "$GoogleLoginEmail"
echo "-----------------------------"

# For the Jamf EA we want the first Chrome ID signed in
# If this is to be used as script rather than EA this part can be commented out
if [[ -n "$GoogleLoginEmail" ]]; then
echo "The Chrome logged in ID submitted if this is Jamf EA version:"
echo "<result>$GoogleLoginEmail</result>"
echo "-----------------------------"
fi

# If this is to be used as EA only this part can be commented out
# Get the Unique Identifier based on the email address
# Take the email and remove anything after the "@" symbol
#username=$(echo $GoogleLoginEmail | cut -d'@' -f1)
# Echo the result
#echo "The Username derived from the first Chrome logged in ID:"
#echo $username
#echo "-----------------------------"

#Add to Jamf if Script. Not Required if EA
#/usr/local/jamf/bin/jamf recon

exit 0
