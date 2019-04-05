#!/bin/bash
# Script to encapsulate all the steps we wish to perform when adding a new user account to a production linux box.
# This script is to be used instead of the standard useradd command, because we bundle in and automate a lot of
# other work that is otherwise manual.
#
# The script takes these options:
#   -u  The single-word username to add
#   -d  A user description/real name, surrounded by double quotes
#   -g  Additional groups to add the user to (comma separated, no spaces)
#   -k  SSH public key to add to the new user. This must be of the quoted full form:
#       "ssh-rsa KEY-ENCODED-STRING [optional comments]"
#   -c  Path to config file containing the 4 options above in CONFIG_SEPARATOR format.
#       This option cannot be used in conjunction with the other options. Doing so will
#       ignore the other options.
#
# Beyond adding the new user, we:
#   - add them to the specified groups
#   - generate SSH keys for the new user
#   - create an empty authorized_keys file for them
#       - optional public key will be added if given to this script as an argument
#   - set a one-time-password for the user
#
# If using the -c config file option, here is the format of the config file:
#
#   username|"quoted description"|group1[,group2...]|"quoted SSH key"
#
# E.G:
#   neal|"Triometric Senior Software Developer"|dev,triometric|"ssh-rsa KEYSTRING neal@vostok"
#   jon|"DI Manager"|di,triometric|"ssh-rsa KEYSTRING jon@jade"
#
# The pipe separator character can be configured in this script by the CONFIG_SEPARATOR variable

set -u

# A simple count of how many arguments were given - good for telling the number
# of words in a string for instance
function howmany()
{
    echo $#;
}

# Show this to the user on any error
function print_usage()
{
    echo
    echo "./user-add.sh -u username -d \"Quoted description\" [-g group1,group2...] [-k \"ssh-rsa KEY comments\"] [-s shell_path]"
    echo "./user-add.sh -c config.csv"
    echo
    echo "If using the config option, lines in the file should be of the format:"
    echo "  username|\"full name/description\"|group1[,group2]|\"ssh-rsa KEY comments\"|shell type"
    echo
    echo "  NOTE: Quotes are required around the description and key tokens only."
}

# The actual bulk of the work - creating a user etc...
# Takes the following params:
#   $1 = username
#   $2 = user description (quoted to allow multi words)
#   $3 = user groups (comma separated)
#   $4 = public ssh key to allow logins as that user (quoted to allow multi words)
#   $5 = type of shell for the user to have (bash/lshell)
function create_user
{
    # Lightly validate args - look for empty strings
    i=1
    for arg in $@
    do
        # Ignore argument 5 as it can be blank / use default bash
        if [[ -z $arg ]] && [[$i -ne 5]]
        then
            echo "Empty value found for param $i"
            exit 1
        fi
        ((i++))
    done
    # Setup friendly names for the args, and default empty strings if they are missing
    new_user=${1:-""}
    user_desc=${2:-""}
    user_groups=${3:-""}
    public_key=${4:-""}
    shell_type=${5:-""}

    # Ensure we've been given a username to add
    if [[ -z $new_user ]]
    then
        echo "Please give a username with the -u flag."
        print_usage
        exit 1
    fi

    # Ensure we've been given a user description to add
    if [[ -z $user_desc ]]
    then
        echo "Please give a description/real name with the -d flag."
        print_usage
        exit 1
    fi
    # Try and ensure the description was quoted, so multiple words came in as one arg
    if [[ $(howmany $user_desc) -lt 2 ]]
    then
        echo "Cannot detect more than one word in the given user description."
        echo "Please ensure the entire string is quoted so it comes in as one argument of the form:"
        echo "  \"John Smith - software developer at Triometric\""
        print_usage
        exit 1
    fi
    # If a key was given, try and ensure it was quoted, so multiple words came in as one arg
    if [[ -n $public_key ]] && [[ $(howmany $public_key) -lt 2 ]]
    then
        echo "Cannot detect more than one word in the given public SSH key.".
        echo "If giving a key, please ensure the entire string is quoted so it comes in as one argument of the form:"
        echo "  \"ssh-rsa KEYSTRING [optional comments]\""
        print_usage
        exit 1
    fi

    # Try and add the user, adding them to the specified groups too
    echo "Creating user $new_user"
    useradd $new_user
    ret=$?
    # Complain and exit if it didn't work
    if [[ "$ret" -ne "0" ]]
    then
        echo "Error adding $new_user, so exiting"
        print_usage
        exit 1
    fi
    if [[ -n $user_groups ]]
    then
        echo "Adding $new_user to $user_groups"
        usermod -aG $user_groups $new_user
        ret=$?
        # Complain and exit if it didn't work
        if [[ "$ret" -ne "0" ]]
        then
            echo "Error adding $new_user to group(s) $user_groups, so exiting"
            print_usage
            exit 1
        fi
    fi

    # Set their full description
    # Delete any leading quote (^") and any trailing quote ("$)
    unquoted_description=$(echo $user_desc | sed 's/^"//g' | sed 's/"$//g')
    usermod -c "$unquoted_description" $new_user;

    # Generate their keys
    su $new_user --command="if [ ! -e \$HOME/.ssh/id_rsa ]; then ssh-keygen -q -b 2048 -t rsa -N ''  -f \$HOME/.ssh/id_rsa; fi"
    su $new_user --command="touch \$HOME/.ssh/authorized_keys"
    su $new_user --command="chmod 0600 \$HOME/.ssh/authorized_keys"
    # Find the new user's home area via tilde expansion and eval
    new_user_home=$(eval echo "~$new_user")
    # Delete any leading quote (^") and any trailing quote ("$)
    unquoted_key=$(echo $public_key | sed 's/^"//g' | sed 's/"$//g')
    echo $unquoted_key >>  $new_user_home/.ssh/authorized_keys

    # Give the user a secure initial password - look for the pwmake command, and failing that, the pwgen command
    initial_passwd=""
    if hash pwmake 2>/dev/null
    then
        # From the man page: 64 bits should be adequate for applications where the attacker does not have direct access to the password hash file
        initial_passwd=$(pwmake 64)
    elif hash pwgen 2>/dev/null
    then
        echo "pwmake command not found, please consider installing libpwquality.el6.x86_64.rpm. Using pwgen instead."
        initial_passwd=$(pwgen)
    # No suitable command was found to generate initial random passwords so leave it to the caller
    else
        echo "Cannot find a tool to set a secure initial password (pwmake or pwgen), please consider installing libpwquality.el6.x86_64.rpm"
        echo "User will have no password - please set one manually"
        echo "You can then force them to reset their password on first login via:"
        echo "    passwd $new_user"
        echo "    chage -d 0 $new_user"
    fi

    # Set the password (if we could make one), and force the user to reset it on first login
    if [[ -n $initial_passwd ]]
    then
        echo "Setting $new_user's initial password to $initial_passwd - they will be prompted to change it on first login"
        echo $initial_passwd | passwd $new_user --stdin
        # Force the user to change their password upon first login
        chage -d 0 $new_user
    fi
    echo

    if [[ -n $shell_type ]]
    then
      echo "Setting $new_user's shell to use $shell_type"
      usermod -s $shell_type $new_user
    fi

   echo -e "\n\n"
}

# Store any given command line args here, to pass to functions later
arg_user=""
arg_desc=""
arg_groups=""
arg_key=""
arg_config=""
arg_shell=""
# Loop through the given flags and ensure we have what's needed.
# Leading ':' says to parse flags in silent mode - suppress the built in error messages from getopts
# u: looks for a -u flag with mandatory argument
# d: looks for a -d flag with mandatory argument
# g: looks for a -g flag with mandatory argument
# k: looks for a -k flag with mandatory argument
# c: looks for a -c flag with mandatory argument
# s: looks for a -s flag with mandatory argument
while getopts ":u:d:g:k:c:s:" flag
do
    case $flag in
        # -u flag to specify a username
        u)
            arg_user=$OPTARG
            ;;
        # -d flag to specify a user description
        d)
            arg_desc=$OPTARG
            ;;
        # -g flag to specify user additional groups
        g)
            arg_groups=$OPTARG
            ;;
        # -k flag to specify a public key to log into the new user with
        k)
            arg_key=$OPTARG
            ;;
        # -c to specify a config file to read user data from, rather than all the other flags
        c)
            arg_config=$OPTARG
            ;;
        #-s to specify the type of shell the user should be using
        s)
            arg_shell=$OPTARG
            ;;
        # handle unknown flags
        \?)
            echo "ERROR: Invalid flag -$OPTARG"
            print_usage
            exit 1
            ;;
        # handle flags that require a value but weren't given one
        :)
            echo "ERROR: -$OPTARG requires a value."
            print_usage
            exit 1
            ;;
    esac
done

# If we were given a config file to read instead of an individual user's details via flags...
if [[ -n $arg_config ]]
then
    # Make sure there even is a file
    if [[ ! -f $arg_config ]]
    then
        echo "ERROR: Cannot find config file $arg_config"
        print_usage
        exit 1
    fi

    # This is the char that we use to tokenize/split each line in the config file
    CONFIG_SEPARATOR='|'
    # This is how many tokens we are looking for on each line
    NUM_TOKENS=5
    while read config_line
    do
        # Build up an array of the tokens
        declare -a tokens
        for i in `seq 1 $NUM_TOKENS`
        do
            token=$(echo $config_line | cut -d $CONFIG_SEPARATOR -f $i)
            tokens[$i]="$token"
        done
        echo "Processing user ${tokens[1]}"

        # Quote all params so they are passed in 'as-is'. We mainly wish
        # to preserve multi-word arguments going in as single params.
        # Without quotes, "Hello there" goes in as two arguments, rather than one.
        create_user "${tokens[1]}" "${tokens[2]}" "${tokens[3]}" "${tokens[4]}" "${tokens[5]}"
    done < $arg_config
else
    # Quote all params so they are passed in 'as-is'. We mainly wish
    # to preserve multi-word arguments going in as single params.
    # Without quotes, "Hello there" goes in as two arguments, rather than one.
    create_user "$arg_user" "$arg_desc" "$arg_groups" "$arg_key" "$arg_shell"
fi
