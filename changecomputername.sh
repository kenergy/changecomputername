#!/bin/bash
# Script: Setup ComputerNamev4.0.sh
# Description: Backs ups up current ComputerName, LocalHostName, HostName, then modify's
# ComputerName, LocalHostName, HostName to MAC+Serial#
# Created By KJ Aponte

# 3.0 added Hostname 
# 3.1 added output of orignal SCUTIL to /private/var/log/scutilbackup.log
# 3.2 added Case statement of type of computer
# 4.0 did CPU testing and switched from ioreg to system_profiler
## Reference: http://www.jaharmi.com/2008/03/15/to_get_mac_serial_numbers_scripts_is_ioreg_or_system_profiler_faster


# ShortCut Variables
#########################################################################################
SCUTIL='/usr/sbin/scutil'
TOUCH='/usr/bin/touch'
Model=`/usr/sbin/sysctl -n hw.model | awk '{print substr($0,0,7)}'`
sNumber=`/usr/sbin/system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'`

# Log Files
#########################################################################################
LogFile="/private/var/log/JAMF-ComputerNameChange.log"
scutilBackup="/private/var/log/scutilBackup.log"

# Start  & End Timers
#########################################################################################
sTime=`date "+%Y-%m-%d %H:%M:%S%n"`
eTime=`date "+%Y-%m-%d %H:%M:%S%n"`

# Initialize Backup of SCUTIL
#########################################################################################
# Create Backup of ComputerName, LocalHostName, HostName
		 ${TOUCH} "${scutilBackup}"
		 echo "Start Backup on: ${sTime}" >> "${scutilBackup}"

# Prints original ComputerName, LocalHostName, HostName
#########################################################################################
	${SCUTIL} --get ComputerName >> "${scutilBackup}"
	${SCUTIL} --get LocalHostName >> "${scutilBackup}"
	${SCUTIL} --get HostName >> "${scutilBackup}"

# Initialize Modification of SCUTIL
#########################################################################################
# Create Finalizing-Script Log-File
		 ${TOUCH} "${LogFile}"
		 echo "Start Script on: ${sTime}" >> "${LogFile}"

# Changes Computer name to L'SerialNumber' or D'SerialNumber'
#########################################################################################
# Determine if computer model is a Laptop or Desktop and correct naming prefix

case $Model in
	
	iMac )
	${SCUTIL} --set ComputerName "D${sNumber}"
	echo "Computer Name set to: D${sNumber}" >> "${LogFile}"
	${SCUTIL} --set LocalHostName "D${sNumber}"
	echo "Local Host Name set to: D${sNumber}" >> "${LogFile}"
	${SCUTIL} --set HostName "D${sNumber}"
	echo "HostName set to: D${sNumber}" >> "${LogFile}"
	;;
	Mac )
	${SCUTIL} --set ComputerName "D${sNumber}"
	echo "Computer Name set to: D${sNumber}" >> "${LogFile}"
	${SCUTIL} --set LocalHostName "D${sNumber}"
	echo "Local Host Name set to: D${sNumber}" >> "${LogFile}"
	${SCUTIL} --set HostName "D${sNumber}"
	echo "HostName set to: D${sNumber}" >> "${LogFile}"
	;;
	MacBook )
	${SCUTIL} --set ComputerName "L${sNumber}"
	echo "Computer Name set to: L${sNumber}" >> "${LogFile}"
	${SCUTIL} --set LocalHostName "L${sNumber}"
	echo "Local Host Name set to: L${sNumber}" >> "${LogFile}"
	${SCUTIL} --set HostName "L${sNumber}"
	echo "HostName set to: L${sNumber}" >> "${LogFile}"
	;;
	MacPro )
	${SCUTIL} --set ComputerName "L${sNumber}"
	echo "Computer Name set to: L${sNumber}" >> "${LogFile}"
	${SCUTIL} --set LocalHostName "L${sNumber}"
	echo "Local Host Name set to: L${sNumber}" >> "${LogFile}"
	${SCUTIL} --set HostName "L${sNumber}"
	echo "HostName set to: L${sNumber}" >> "${LogFile}"
	;;

esac



# Script Finalization
#########################################################################################
		 echo "End Script on: ${eTime}" >> "${LogFile}"

exit 0
