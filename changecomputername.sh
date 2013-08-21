#!/bin/bash
# Script: Setup ComputerNamev2.sh
# Description: Makes computer name Mac"SerialNumber"
# Created By KJ Aponte
# twitter: @kenergy


# Command Variables
#########################################################################################
# Serial Number
sNumber=`(ioreg -l | awk '/IOPlatformSerialNumber/ { split($0, line, "\""); printf("%s\n", line[4]); }')`

# Log-File path and name
LogFile="/private/var/log/ComputerNameChange.log"

# Start Time
sTime=`date "+%Y-%m-%d %H:%M:%S%n"`

# End Time
eTime=`date "+%Y-%m-%d %H:%M:%S%n"`

# ShortCut Variables
#########################################################################################
SCUTIL='/usr/sbin/scutil'
TOUCH='/usr/bin/touch'

# Script Initialization
#########################################################################################
# Create Finalizing-Script Log-File
		 ${TOUCH} "${LogFile}"
		 echo "Start Script on: ${sTime}" >> "${LogFile}"

# Changes Computer name to MAC'SerialNumber'
#########################################################################################
	${SCUTIL} --set ComputerName "MAC${sNumber}"
	echo "Computer Name set to: MAC${sNumber}" >> "${LogFile}"
	${SCUTIL} --set LocalHostName "MAC${sNumber}"
	echo "Local Host Name set to: MAC${sNumber}" >> "${LogFile}"

# Script Finalization
#########################################################################################
		 echo "End Script on: ${eTime}" >> "${LogFile}"

exit 0
