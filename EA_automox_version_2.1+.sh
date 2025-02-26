#!/bin/bash
# Gets Automox Version number
# Automox changed the syntax from -v to version on newer agents
# Script checks old first then if old fails

# Try the old command first
output=$(amagent -v 2>/dev/null)

# If the old command fails, try the new command
if [ $? -ne 0 ]; then
    output=$(amagent version 2>/dev/null)
fi

# Check if the output is in the old format
if [[ "$output" == *version=* ]]; then
    # Use awk to extract just the version number from the old format
    version=$(echo "$output" | awk -F'"' '/version=/{print $2}')
else
    # Assume the output is just the version number in the new format
    version="$output"
fi

# Output the result in the required XML format for Jamf
echo "<result>$version</result>"
