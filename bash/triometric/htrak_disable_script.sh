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

# Custom app name, use to pretify the log entries rather than using the actual script name
APP_NAME="HTRAK Space Checker"

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

## START SCRIPT

syslog_write "Starting $APP_NAME"

syslog_write "Stopping $APP_NAME"

## END SCRIPT
