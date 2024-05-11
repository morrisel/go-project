#!/bin/bash

# =============================================================================================== #
# > The script was developed with strong POSIX concept                                            #
# =============================================================================================== #
# SUPERVISOR:    Morris                         PROGRAMMER:    Morris                             #
# ----------------------------------------------------------------------------------------------- #
#                                                                                                 #
# FILE:                 scr_create_environment_directories.sh                                     #
#                                                                                                 #
# DESCRIPTION:          This script creates the working directories for system                    #
#                                                                                                 #
# ARGUMENTS:                                                                                      #
#        params#        description:                                                              #
#        $1                     environment                                                       #
#                                                                                                 #
# INPUT FORMAT:                                                                                   #
#                                                                                                 #
# OUTPUT FORMAT:                                                                                  #
#                                                                                                 #
# IMPLEMENTATION:                                                                                 #
#                       scr_create_environment_directories                                        #
#                                                                                                 #
#                                                                                                 #
# DATE:                 NAME:           MODIFICATION DESCRIPTION                                  #
#     14-12-2023            Morris          Created                                               #
#                                                                                                 #
# =============================================================================================== #

# Function Declarations
# =====================

# DESCRIPTION:
# 	a description
#
# ARGUMENTS:
# 	params#			Description
# 	$1				[environment name]
#
# IMPLEMENTATION:
# 	Exit_With_Error_Internal [status error]
#
Exit_With_Error_Internal()
{
	case $1 in
		20) # init script not found
			echo "ERROR: Env init script $2 not found"
			exit $1
			;;

		21) # general error
			echo "ERROR: $1"
	        	echo "Details:"
			echo "Environment $ENV already exists. Exiting the script."
			exit $1
			;;

		*) # unknown error
			echo "ERROR: Unknown error ($1)"
			;;
	esac
}

#clear
echo

# Initializations Parameters
# ==========================

# Base variables path
# -------------------
ENV="$USER"
BASE_PATH="`echo ~`"
CURR_RELATIVE_PATH="~${PWD:${#BASE_PATH}}"
FULL_PATH="$BASE_PATH/${CURR_RELATIVE_PATH:1}"
CURR_DIR="`basename $FULL_PATH`"

echo " . . . . . . . . . . . . . . . . . . . "
echo "[ENVIRONMENT: #]         ~>: $ENV"
echo "[BASE_PATH: #]           ~>: $BASE_PATH"
echo "[CURR_RELATIVE_PATH: #]  ~>: $CURR_RELATIVE_PATH"
echo "[FULL_PATH: #]           ~>: $FULL_PATH"
echo "[CURRENT_DIRECTORY: #]   ~>: $CURR_DIR"
echo " . . . . . . . . . . . . . . . . . . . "

# Internal usage variables
# ------------------------
echo
echo "==============================================================================="
echo "~> This script creates the environment working directories for the system"
echo "==============================================================================="
echo

# Check if a custom environment is provided
if [ -z "$1" ] || [ $1 = $ENV ]; then
    echo "Trying to create with the default $ENV environment."
else
    if [ "$1" != "$ENV" ]; then
        echo "Trying to create with a custom $1 environment."
    fi
    ENV="$1"
fi

echo
echo "$CURR_RELATIVE_PATH/"
#echo "$CURR_RELATIVE_PATH/$ENV"


ENV_LEN=${#ENV}
for dir in `ls -1`;
do
	if [ -d "$dir" ];
	then
		CURR_LEN=${#dir}

		if [ "$CURR_LEN" -eq "$ENV_LEN" ] && [ $dir = $ENV ];
		then
			echo ">>> $CURR_RELATIVE_PATH/$ENV"
			Exit_With_Error_Internal 21
		fi
	fi
done


# Check if a custom environment is provided
if [ -z "$1" ]; then
	echo "The system directory is created with the default $ENV environment."
else
	echo "The system directory is created with a custom $1 environment."
fi
echo "$CURR_RELATIVE_PATH/$ENV"

sleep 1
# Running -----------------------------------------------------------------------------------------
eval "mkdir -p $CURR_RELATIVE_PATH/$ENV/{bin,build/{make,scripts,sources,git-source,},tmp,logs,}"

echo "New directory environment $ENV was created:"
tree $ENV

echo
echo
