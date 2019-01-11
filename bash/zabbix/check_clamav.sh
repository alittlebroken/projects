#!/bin/bash
# Author: Paul Lockyer (plockyer@googlemail.com)
# Created: 2019-01-11
# Version: 1
# Description: Checks when clamav last updated itself

## SETUP
# Set whether or not we should output debug messages to the console, don't do this in production unless there is an issue
DEBUG_MODE="ON"

# Set the user that we should be running the script as
SCRIPT_USER="root"

# Set the loaction of the clamav log file to check
CLAMAV_LOG_FILE="/var/log/clamav/freshclam.log"

## FUNCTIONS
# Output debg messages to screen
function debug_write
{

  # Check debug mode is on and only output a message if it is
  if [[ "$DEBUG_MODE" == "ON" ]]
  then
    
    # Output the message to screen
    echo "DEBUG :> $1"
  fi

}

# Check if this script is being run as the designated user
function script_runas
{

  # Check we are the designated user
  if [[ "$USER" != "$SCRIPT_USER" ]]
  then
    return 1
  else
    return 0
  fi

}
## START SCRIPT

    # First check we are being run as the correct user
    if [[ script_runas == 1 ]]
    then

        echo "This script must be run as the $SCRIPT_USER user."
        exit 1

    fi

    # We have passed the user test we can now carry on with our usual scheduled programming
    # Check that the log file we wish to check exists
    if [[ -f "$CLAMAV_LOG_FILE ]]
    then
    
        
    
    else
        echo "The specified clamav log file does not exists at the location specified for this script. Please double check and try again"
        exit 2
    fi


## END SCRIPT
