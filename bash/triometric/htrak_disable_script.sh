#!/bin/bash
# Author: Paul Lockyer (plockyer@googlemail.com)
# Created: 2018-12-22
# Version: 1
# Description: Stops the htrak process if the filespace gets below a set threshold, calls MK's htrak config
#              swapper script to stop htrak monitoring the data sent to us.
#              This script MUST be in the same folder as the htrak config swapper script to work

## SETUP
# Set whether or not we should output debug messages to the console, don't do this in production unless there is an issue
DEBUG_MODE="ON"

# Set the user that we should be running the script as
SCRIPT_USER="ROOT"

# Set the tag to use when writing to syslog
SYSLOG_TAG="tag_name"

# Set the threshold limit for space, if we are below this then htrak must be stopped
# By default set to 1, as in GB
SPACE_THRESHOLD=1

# Set the fielsystem we wish to monitor
FS_TO_CHECK="/home"

# Stores the result of checking the filesystem space
# By Default set it to PASS
FS_CHECK_RESULT="PASS"

# Custom app name, use to pretify the log entries rather than using the actual script name
APP_NAME="HTRAK Space Checker"

# These set the names for the full config and the config to not capture traffic for htrak
HTRAK_STOP_CONFIG="htrak.conf.no_monitors"
HTRAK_START_CONFIG="htrak.conf.original"

# What is the name of the config file that HTRAK actually uses
HTRAK_CURR_CONFIG="/opt/htrak/conf/htrak.conf"

# List the full path to the HTRAK config switcher script
HTRAK_CONFIG_SWITCHER="/opt/htrak/bin/htrak_config_changer.sh"

## FUNCTIONS
# Outputs messages to syslog
function syslog_write
{
    # Put message in syslog, DUH
    logger "$1" -t $SYSLOG_TAG
}

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
    return false
  else
    return true
  fi

}

# Check to see if the filesystem has passed a threshold
# Param $1 is filesystem size
# Param $2 is fail threshold
function check_threshold {

    # Check if the current used space exceeds any thresholds
    if [[ $1 -lt  $2 ]]
    then
        # Current space is below threshold set, lets set it as a failure
        FS_CHECK_RESULT="FAIL"
    fi
    
}

## START SCRIPT

syslog_write "Starting $APP_NAME"

    # Get the specified filesystems available space
    CURR_SPACE=$(df -Ph $FS_TO_CHECK | tail -n 1 | tr -s '[:space:]' | cut -d' ' -f4)
    
    # Remove the last character from the current space car as we do not need it
    CURR_SPACE=${CURR_SPACE%?}

    # Check the filesystem space
    check_threshold $CURR_SPACE $SPACE_THRESHOLD

    # Check the result and determine if we need to take further action
    if [[ $FS_CHECK_RESULT == "PASS" ]]
    then
        syslog_write "HTRAK has enough space to run. Nothing more to do"
        
        # Quick check to see if we have the "stop" config in place, if we do
        # then we need to swap it back to the original now we have space
        if grep -q "MonitoredServer 0.0.0.0 32 80" "$HTRAK_CURR_CONFIG"; then
            syslog_write "Switching HTRAK back to using it's full config"
            
            # Source the script to switch the htrak config over
            source "$HTRAK_CONFIG_SWITCHER  HTRAK_START_CONFIG"
        fi
        
    else
        syslog_write "Stopping HTRAK as we have exceeded the threshold of $SPACE_THRESHOLD GB"
        
        # Source the script to switch the htrak config over
        source "$HTRAK_CONFIG_SWITCHER  HTRAK_STOP_CONFIG"
    fi

syslog_write "Stopping $APP_NAME"

## END SCRIPT
