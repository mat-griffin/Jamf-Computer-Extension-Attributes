#!/bin/zsh

# Get the current macOS version
current_version=$(sw_vers -productVersion)

# Function to compare version numbers
version_greater_equal() {
    [ "$(printf '%s\n' "$@" | sort -V | head -n 1)" != "$1" ]
}

# Check if the current version is less than 15.2
if version_greater_equal "15.3" "$current_version"; then
    # Extract the version number for macOS Sequoia from the softwareupdate output
    available_update=$(softwareupdate -l | grep "Title: macOS Sequoia" | grep -o "Version: [0-9]*\.[0-9]*" | awk '{print $2}')

    if [ -n "$available_update" ]; then
        echo "<result>Update Available: $available_update</result>"
    else
        echo "<result>Update Not Found</result>"
    fi
else
    echo "<result>Not applicable: Mac is on newer or required OS</result>"
fi
