#!/bin/sh
getremoteloginstatus=$(/usr/sbin/systemsetup -getremotelogin)
echo "<result>$getremoteloginstatus</result>"
exit 0
