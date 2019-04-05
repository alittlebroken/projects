#!/bin/bash

# Triometric Security - ACL setup
# Creates the sudo groups and copies the files to the correct locations

# Check we are running under the correct user
if [ $USER != "root" ]
then
	echo "This script must be run as the root user"
	exit 1
fi

## Method to check and create the required group
function add_group
{

        groupadd $1 

	# Check the add group command was ok
	if [ $? -eq 0 ]
	then
		echo "Group $1 created succesfully"
	fi
}

## Method to copy the config file across
function copy_config_file
{

	## Check if file does not already exists
	if [ -f "/etc/sudoers.d/"$1 ]
	then

		echo "$1 already exists. No copy has been made"
	else

		# Copy the file across
		cp $1 /etc/sudoers.d/$1
		
		# Check the copy worked oK
		if [ $? -eq 0 ]
		then
			echo "$1 copied succesffuly"
		else
			echo "There was an issue copying file $1"
		fi

	fi

}

## START

echo "Starting setup of Triometric Security ACLs"
echo " "

# Create the groups
echo "Creating Trio Security groups"
echo " "

# Application support group
add_group "trio_app_support"

# Network support group
add_group "trio_network_support"

# User admin group
add_group "trio_user_admin"

# Administration group
add_group "trio_admin"

# Triometric ReadOnly group
add_group "trio_read_only"

# Copy the files across
echo " "
echo "Copying sudo config files"
echo " "

# Application support
copy_config_file "triometric_app_support_team"

# Network Support
copy_config_file "triometric_network_support_team"

# System Administration
copy_config_file "triometric_admin_support_team"

# User Administration
copy_config_file "triometric_user_admin_team"

## END
echo " "
echo "Setup of Triometric Security ACLs is now complete"
echo " "
