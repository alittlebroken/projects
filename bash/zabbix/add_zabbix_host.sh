#!/bin/bash
# Author: Paul Lockyer (plockyer@googlemail.com)
# Created: 2019-01-09
# Script Name: add_zabbix_host.sh
# Version: 1
# Description: Add a new host to zabbix from the command line

## SETUP
# Set whether or not we should output debug messages to the console, don't do this in production unless there is an issue
DEBUG_MODE="ON"

# Set the user that we should be running the script as
SCRIPT_USER="paul"

# What address is the zabbix server on?
ZABBIX_SERVER_ADDRESS="zabbix/zabbix"

# What is the url we are going to post the API queries to
ZABBIX_API_URL='http://'"$ZABBIX_SERVER_ADDRESS"'/api_jsonrpc.php'

# Set the content type
ZABBIX_API_CONTENT_TYPE="Content-Type: application/json"

# Set the user and password for the user that will be connecting to
# the Zabbix api
# Don't use an existing named user for this
ZABBIX_API_UID=""
ZABBIX_API_PWD=""

# Set the id the requests will be identified as
ZABBIX_API_ID="1001"

# Set the VAR that will contain the authed user
ZABBIX_API_AUTH=""

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

# This function authorizes you against the Zabbix server
function auth_zabbix_server {

    debug_write "Initiating auth against Zabbix API server using JSON"
    
    debug_write "Constructing JSON request"
    
    JSON_REQUEST='{"jsonrpc":"2.0","method":"user.login","params":{"user":"'"$ZABBIX_API_UID"'","password":"'"$ZABBIX_API_PWD"'"},"id":'"$ZABBIX_API_ID"',"auth":null}'
    
    debug_write "JSON REQUEST: $JSON_REQUEST"
    
    debug_write "Sending request to Zabbix server"
    
    debug_write "Content Type: $ZABBIX_API_CONTENT_TYPE"
    
    debug_write "Server: $ZABBIX_API_URL"
    
    RESULT=$(curl -s -d "$JSON_REQUEST" -H "$ZABBIX_API_CONTENT_TYPE" -X POST "$ZABBIX_API_URL")

    debug_write "Result from Zabbix JSON Request: $RESULT"

    # Now retrieve the auth token from the result
    # We do have the silly double quotes at each end of the result
    ZABBIX_API_AUTH=$(echo $RESULT | cut -d',' -f2 | cut -d':' -f2)
}

## START SCRIPT

    # Ensure we are run as the specified user
    if [[ "$USER" == "$SCRIPT_USER" ]]
    then
    
      # Step 1: Authenticate against the zabbix json server
      auth_zabbix_server
      
      debug_write "Authentication token: $ZABBIX_API_AUTH"
    
    else
        echo "You must run this script as the user $SCRIPT_USER only"
    fi
    
## END SCRIPT
