#!/bin/sh


loggedInUser=$(/usr/bin/stat -f%Su "/dev/console")
# Determine Homebrew directory based on platform architecture,
# use to define Homebrew binary paths.
architectureCheck=$(/usr/bin/arch)
if [ "$architectureCheck" = "arm64" ]; then
  brewPrefix="/opt/homebrew/bin"
else
  brewPrefix="/usr/local/bin"
fi
brewPath="$brewPrefix/brew"


# Check for presence of target binary and get version.
if [ -e "$brewPath" ]; then
  brewCheck=$(sudo -u "$loggedInUser" "$brewPath" --version 2>&1)
else
  brewCheck=""
fi

# Test line Example
# brewCheck2="Homebrew 4.0.17-38-gb3f7c6f /homebrew-core (git revision 54334f2bc18; last commit 2023-03-16) /homebrew-cask (git revision 406e482bad; last commit 2023-03-16)"

# sed out the spaces and Homebrew
brewCheckVersion=$(echo "${brewCheck}" | sed 's/^[^0-9]* \([^ ]*\).*$/\1/')
#brewCheckVersion=$(echo "${brewCheck}" | sed -e "s/ //g;s/"Homebrew"//g" | tr '[:upper:]' '[:lower:]')



# Report result.
echo "<result>$brewCheckVersion</result>"


exit 0
