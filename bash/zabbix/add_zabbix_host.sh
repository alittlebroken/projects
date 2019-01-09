#!/bin/bash
# Author: Paul Lockyer (plockyer@googlemail.com)
# Created: 2019-01-09
# Script Name: add_zabbix_host.sh
# Version: 1
# Description: Add a new host to zabbis from the command line

## SETUP
# Set whether or not we should output debug messages to the console, don't do this in production unless there is an issue
DEBUG_MODE="ON"

# Set the user that we should be running the script as
SCRIPT_USER="ROOT"

# What address is the zabbix server on?
ZABBIX_SERVER_ADDRESS="127.0.0.1"

# What is the url we are going to post the API queries to
ZABBIX_API_URL="http:\\$ZABBIX_SERVER_ADDRESS\api_jsonrpc.php"

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
    return false
  else
    return true
  fi

}
## START SCRIPT

    # Ensure we are run as the specified user
    script_runas
    
    
## END SCRIPT
