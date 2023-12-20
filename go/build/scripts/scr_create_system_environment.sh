#!/bin/bash

# =============================================================================================== #
# > The script was developed with strong POSIX concept                                            #
# =============================================================================================== #
# SUPERVISOR:    Morris  			PROGRAMMER:    Morris 	                          #
# ----------------------------------------------------------------------------------------------- #
#                                                                                                 #
# FILE:			scr_create_environment_directories.sh                                     #
#                                                                                                 #
# DESCRIPTION:		This script creates the working directories for system                    #
#                                                                                                 #
# ARGUMENTS:                                                                                      #
#        params#        description:                                                              #
#        $1                     environment                                                       #
#                                                                                                 #
# INPUT FORMAT:											  #
#                                                                                                 #
# OUTPUT FORMAT:										  #
#												  #
# IMPLEMENTATION:										  #
# 			scr_create_environment_directories                                        #
#                                                                                                 #
#												  #
# DATE:			NAME:		MODIFICATION DESCRIPTION		                  #
#     14-12-2023            Morris          Created                                               #
#												  #
# =============================================================================================== #

# Function Declarations
# =====================

# Exit_With_Error_Internal: Выводит сообщение об ошибке и завершает выполнение скрипта с кодом ошибки 1.
# Exit_With_Error_Internal: Output message on the screen with exit status 1.
#
# Параметры:
# Параметры:
#   $1 - Строка с сообщением об ошибке.
#   $1 - Строка с сообщением об ошибке.
#
# Пример использования:
# Пример использования:
#   Exit_With_Error_Internal "Произошла внутренняя ошибка"
#   Exit_With_Error_Internal "Произошла внутренняя ошибка"
#
function Exit_With_Error_Internal()
{
	# ugo- user, group, other
	local exit_code=$?
	local user=$ENV

	case $dir in
		user)
			echo "ERROR: Env init script $2 not found"
			exit $1
			;;
		perm)
			echo "ERROR: $2"
	        	echo "Details:"
        	    	echo -e "$3"
			;;
		*)
			echo "ERROR: Unknown error ($1)"
			;;
	esac


	if [ $exit_code -ne 0 ];
	then
		echo "Error: $exit_code"
	fi

	#local error_message="$1"
	#echo "Ошибка: $error_message" >&2  # Выводим сообщение об ошибке в stderr
	#exit 1  # Завершаем выполнение скрипта с кодом ошибки 1
}


#clear
echo

# Initializations Parameters
# ==========================
EXIT_CODE_20=20

# Base variables path
# -------------------
ENV="$USERNAME"
BASE_PATH="`echo ~`"
CURR_RELATIVE_PATH="~${PWD:${#BASE_PATH}}"
FULL_PATH="$BASE_PATH/${CURR_RELATIVE_PATH:1}"
MY_CURR_DIR="`basename $FULL_PATH`"

echo " . . . . . . . . . . . . . . . . . . . "
echo "[ENVIRONMENT: #]         ~>: $ENV"
echo "[BASE_PATH: #]           ~>: $BASE_PATH"
echo "[CURR_RELATIVE_PATH: #]  ~>: $CURR_RELATIVE_PATH"
echo "[FULL_PATH: #]           ~>: $FULL_PATH"
echo "[CURRENT_DIRECTORY: #]   ~>: $MY_CURR_DIR"
echo " . . . . . . . . . . . . . . . . . . . "


# Internal usage variables
# ------------------------

echo
echo "==============================================================================="
echo "~> This script creates the environment working directories for the system"
echo "==============================================================================="


if [ -z $1 ];
then
	echo "The system directory creates with default: $ENV evironment."
else
	echo "The system directory creates with custom $1 environment."
	ENV=$1
fi



echo
echo
echo
echo "Creating directories for system:"
#mkdir -p $USER/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,}

#mkdir -p $ENV/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,}
echo "Directory for system creates successfuly"

echo
#tree $ENV
ls -l $ENV/*

echo
echo "Prepare to create system directory for git-source..."
#mkdir -p $USER/build/git-sources/{$USER/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,},}

#mkdir -p $ENV/build/git-sources/{$ENV/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,},}
echo "System directories for git-sources was created successfuly"

echo
#tree $ENV
ls -l */


echo
echo

