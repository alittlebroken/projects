#!/bin/bash
# Author: Paul Lockyer (plockyer@googlemail.com)
# Created: 2019-02-26
# Version: 1
# Description: MySQL database backup script

## SETUP
# Set whether or not we should output debug messages to the console, don't do this in production unless there is an issue
DEBUG_MODE="OFF"

# Set the user that we should be running the script as
SCRIPT_USER="ROOT"

# Set the tag to use when writing to syslog
SYSLOG_TAG="zabbix_db_backup"

# Location to store the backups
BACKUP_LOC="/home/mysql/backups"

# Date and time backup performed
BACKUP_DATETIME=$(date "+%d%m%Y%H%M%S")

# The servername
BACKUP_SERVER=`hostname`

# The database name
BACKUP_DATABASE="zabbix"

# The name of the DB user to backup with
BACKUP_USER="zabbix"

# The password for the backup user
BACKUP_PASS="zabbix"

# The full backup filename
BACKUP_FILE="$BACKUP_LOC/$BACKUP_DATABASE-$BACKUP_SERVER-$BACKUP_DATETIME.sql"

# The command to perform the backup
BACKUP_COMMAND="mysqldump"

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


    syslog_write "Database backup started"

    # Backup the database - ONLINE
    RESULT=$(mysqldump -u"$BACKUP_USER" -p"$BACKUP_PASS" --single-transaction --all-databases > "$BACKUP_FILE")

    # Now zip up the file
    if [[ "$RESULT" -eq 0 ]]
    then

     syslog_write "compressing backup"
     ZIP_RESULT=$(gzip "$BACKUP_FILE")

     if [[ "$ZIP_RESULT" -eq 0 ]]
     then

        syslog_write "Database backup and compression OK"

     else

        syslog_write "There was an issue compressing the database backup"
        exit 1000
     fi

    else

     syslog_write "ERROR creaating database backup"
     exit 1000

    fi

    syslog_write "Database backup completed"


## END SCRIPT
