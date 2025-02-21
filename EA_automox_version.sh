#!/bin/bash

# Run the command and capture the output
output=$(amagent -v)

# Use awk to extract just the version number
version=$(echo "$output" | awk -F'"' '/version=/{print $2}')

# Output the result in the required XML format for Jamf
echo "<result>$version</result>"