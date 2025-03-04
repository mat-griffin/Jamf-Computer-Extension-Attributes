#!/bin/zsh

if [[ -f "/Library/Application Support/JAMF/Receipts/WiFi_Trigger.pkg" ]]; then
  echo "<result>Yes</result>"
else
  echo "<result>No</result>"
fi
