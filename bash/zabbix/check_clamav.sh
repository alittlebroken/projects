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
    
    # Get the clamav version info
    clamav_ver_info=$(clamscan -V | cut -d'/' -f3)
    
    # Extract out the date and time values we need
    dt_year=$(echo $clamav_ver_info | cut -d' ' -f5)
    dt_month=$(echo $clamav_ver_info | cut -d' ' -f2)
    
        # We can't use the named month have to convert to digits first
        case $dt_month in
            "Jan")
                dt_month="01"
                ;;
            "Feb")
               dt_month="02"
               ;;
            "Mar")
               dt_month="03"
               ;;
            "Apr")
               dt_month="04"
               ;;
            "May")
               dt_month="05"
               ;;
            "Jun")
               dt_month="06"
               ;;
            "Jul")
               dt_month="07"
               ;;
            "Aug")
               dt_month="08"
               ;;
            "Sep")
               dt_month="09"
               ;;
            "Oct")
               dt_month="10"
               ;;
            "Nov")
               dt_month="11"
               ;;
             "Dec")
               dt_month="12"
               ;;
        esac
    
    dt_day=$(echo $clamav_ver_info | cut -d' ' -f3)

    # Build the date we need
    dt_full="$dt_year-$dt_month-$dt_day"
    
    # Debug Information
    debug_write "ClamAV Version Info: $clamav_ver_info"
    debug_write "ClamAV year: $dt_year"
    debug_write "ClamAV Month: $dt_month"
    debug_write "ClamAV Day: $dt_day"
    debug_write "Full date to compare with: $dt_full"

    clam_av_epoch=$(date -d $dt_full +%s)
    date_now_epoch=$(date -d "now" +%s)

    debug_write "ClamAV date since epoch: $clam_av_epoch"
    debug_write "Date Now since epoch: $date_now_epoch"

    # work out the difference between now and when clamav was last updated
    # divide by 86400 to get the differnece in days
    date_diff=$(( (date_now_epoch-clam_av_epoch)/86400 ))

    debug_write "Date difference in days: $date_diff"

    # Check to see if the value is greater than 7 ( FAIL ) or between3 and 7 (WARN ) otherwise we pass the check
    if [[ "$date_diff" -gt "7" ]]
    then
        echo "|$(date -d now)|FAIL|"
    elif [[ "$date_diff" -gt "3" && "$date_diff" -lt "7" ]]
    then
       echo "|$(date -d now)|WARN|"
    else
       echo "|$(date -d now)|PASS|"
    fi

## END SCRIPT
