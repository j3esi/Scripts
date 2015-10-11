#!/bin/bash

### Version 1.0
### Created by Erik Berglund

###
### DESCRIPTION
###

# This script is designed to be run from an installer package as a preinstall or a postinstall script.
# It will get the value of the current users's variable TMPDIR that is not passed as in the env to the script. 

###
### MAIN SCRIPT
###

# List all processe for ${USER}, grep for Installer and set installerPID to last match.
installerPID=$( ps -u${USER} -c -o user,pid,command | sed -nE 's/^'"${USER}"'.* ([0-9]+) Installer$/\1/p' | tail -1 )
if [[ -n ${installerPID} ]]; then
	
	# Print environment variables for process with pid ${installerPID} and catch the value of variable TMPDIR.
	# This could easily be expanded or changed to get any other environment variable.
	path_tmpDir=$( /bin/ps -p ${installerPID} -wwwE | /usr/bin/sed -nE 's/.*TMPDIR=(.*\/) .*=.*/\1/p' )
	printf "%s\n" "TMPDIR=${path_tmpDir}"
else
	printf "%s\n" "[ERROR] Unable to get Installer PID!"
	exit 1
fi

exit 0