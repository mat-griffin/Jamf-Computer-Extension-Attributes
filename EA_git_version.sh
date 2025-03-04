#!/bin/sh

# Default result is blank
RESULT=""

# Get machine type
UNAME_MACHINE="$(uname -m)"

# Set the prefix based on the machine type
if [[ "$UNAME_MACHINE" == "arm64" ]]; then
    # M1/arm64 machines
    HOMEBREW_PREFIX="/opt/homebrew"
else
    # Intel machines
    HOMEBREW_PREFIX="/usr/local"
fi

# Check if GIT ins installed
if [[ -e $HOMEBREW_PREFIX/bin/git ]]; then
  # If it exists, gather the version.
  GIT_VERSION=$($HOMEBREW_PREFIX/bin/git --version | awk '{ print $3 }')
  # If GIT_VERSION is not empty, set it as the new RESULT
  if [[ -n "$GIT_VERSION" ]]; then
    RESULT=$GIT_VERSION
  fi
fi

echo "<result>$RESULT</result>"

