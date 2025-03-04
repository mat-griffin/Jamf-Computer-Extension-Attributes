#!/bin/bash

# Define the path to the version manifest file
VERSION_MANIFEST_PATH="/opt/servicenow/agent-client-collector/version-manifest.txt"

# Check if the file exists
if [[ -f "$VERSION_MANIFEST_PATH" ]]; then
    # Use grep to find the line with 'agent-client-collector', head to take the first match, and awk to extract the version number
    VERSION=$(grep 'agent-client-collector' "$VERSION_MANIFEST_PATH" | head -n 1 | awk '{print $2}')
    
    # Check if a version was found
    if [[ -n "$VERSION" ]]; then
        echo "<result>$VERSION</result>"
    else
        echo "<result>No ACC</result>"
    fi
else
    echo "<result>No ACC</result>"
fi
