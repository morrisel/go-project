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
#
# Параметры:
#   $1 - Строка с сообщением об ошибке.
#
# Пример использования:
#   Exit_With_Error_Internal "Произошла внутренняя ошибка"
#
function Exit_With_Error_Internal()
{
	# ugo- user, group, other
	local exit_code=$?
	local user=$ENV

	case $dir in
		user)
			echo "Directory exist"
			;;
		perm)
			echo "You don't have permition"
			;;
		*)
			echo "Error: $exit_code"
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
# Функции для работы с каталогами, например, для создания, удаления или переименования каталогов.
# -----------------------------------------------------------------------------------------------
#Функция для создания каталога:
function create_dir() {
  # Получаем имя каталога
  local dir=$1

  # Проверяем, существует ли каталог
  if [ -d "$dir" ]; then
    echo "Каталог $dir уже существует"
    return 1
  fi

  # Создаем каталог
  mkdir "$dir"

  # Возвращаем код возврата
  return 0
}

# Функция для удаления каталога:
function delete_dir() {
  # Получаем имя каталога
  local dir=$1

  # Проверяем, существует ли каталог
  if [ ! -d "$dir" ]; then
    echo "Каталога $dir не существует"
    return 1
  fi

  # Удаляем каталог
  rm -rf "$dir"

  # Возвращаем код возврата
  return 0
}

# Функция для переименования каталога:
function rename_dir() {
  # Получаем имена старого и нового каталогов
  local old_dir=$1
  local new_dir=$2

  # Проверяем, существуют ли каталоги
  if [ ! -d "$old_dir" ]; then
    echo "Каталога $old_dir не существует"
    return 1
  fi
  if [ -d "$new_dir" ]; then
    echo "Каталог $new_dir уже существует"
    return 1
  fi

  # Переименовываем каталог
  mv "$old_dir" "$new_dir"

  # Возвращаем код возврата
  return 0
}

# Функции для работы с файлами, например, для чтения, записи или удаления файлов.
# -------------------------------------------------------------------------------

# Функция для чтения файла:
function read_file() {
  # Получаем имя файла
  local file=$1

  # Открываем файл для чтения
  local file_handle=$(open "$file" r)

  # Читаем файл
  while read line; do
    echo "$line"
  done < "$file_handle"

  # Закрываем файл
  close "$file_handle"
}

# Функция для записи в файл:
function write_file() {
  # Получаем имя файла
  local file=$1

  # Получаем содержимое файла
  local content=$2

  # Открываем файл для записи
  local file_handle=$(open "$file" w)

  # Записываем содержимое файла
  echo "$content" > "$file_handle"

  # Закрываем файл
  close "$file_handle"
}

# Функция для удаления файла:
function delete_file() {
  # Получаем имя файла
  local file=$1

  # Проверяем, существует ли файл
  if [ ! -f "$file" ]; then
    echo "Файла $file не существует"
    return 1
  fi

  # Удаляем файл
  rm "$file"

  # Возвращаем код возврата
  return 0
}

# Функция для проверки существования файла:
function file_exists() {
  # Получаем имя файла
  local file=$1

  # Проверяем, существует ли файл
  if [ -f "$file" ]; then
    return 0
  else
    return 1
  fi
}

# Функция для получения размера файла:
function file_size() {
  # Получаем имя файла
  local file=$1

  # Получаем размер файла
  local size=$(stat -c%s "$file")

  # Возвращаем размер файла
  return $size
}

# Функция для получения списка файлов в каталоге:
function list_files() {
  # Получаем имя каталога
  local dir=$1

  # Получаем список файлов в каталоге
  local files=$(find "$dir" -type f)

  # Выводим список файлов
  for file in $files; do
    echo "$file"
  done
}

# Функции для работы с переменными, например, для присвоения значений переменным,
# проверки значений переменных или преобразования значений переменных.
# -------------------------------------------------------------------------------

# Функция для присвоения значения переменной:
function set_variable() {
  # Получаем имя переменной
  local variable=$1

  # Получаем значение переменной
  local value=$2

  # Присваиваем значение переменной
  export $variable=$value
}
# Эта функция принимает в качестве аргументов имя переменной и значение, которое необходимо присвоить переменной. Функция использует оператор export, чтобы сделать переменную видимой для других скриптов.

# Функция для проверки значения переменной:
function check_variable() {
  # Получаем имя переменной
  local variable=$1

  # Получаем значение переменной
  local value=${!variable}

  # Проверяем значение переменной
  if [ "$value" = "значение" ]; then
    echo "Значение переменной $variable равно 'значение'"
  else
    echo "Значение переменной $variable не равно 'значение'"
  fi
}
# Эта функция принимает в качестве аргумента имя переменной. Функция получает значение переменной и проверяет, равно ли оно заданному значению. Если значение переменной равно заданному, то функция выводит сообщение об этом. Если значение переменной не равно заданному, то функция выводит сообщение об этом.

# Функция для преобразования значения переменной:
function convert_variable() {
  # Получаем имя переменной
  local variable=$1

  # Получаем значение переменной
  local value=${!variable}

  # Преобразуем значение переменной
  local converted_value=$(echo "$value" | tr "a-z" "A-Z")

  # Присваиваем преобразованное значение переменной
  export $variable=$converted_value
}
# Эта функция принимает в качестве аргумента имя переменной. Функция получает значение переменной и преобразует его в верхний регистр. Затем функция присваивает преобразованное значение переменной.
# Вы можете использовать эти функции в своих bash-скриптах для выполнения различных задач по работе с переменными.

# Вот еще несколько примеров функций, которые могут быть полезны:

# Функция для получения значения переменной:
function get_variable() {
  # Получаем имя переменной
  local variable=$1

  # Получаем значение переменной
  local value=${!variable}

  # Возвращаем значение переменной
  return $value
}

# Функция для проверки существования переменной:
function variable_exists() {
  # Получаем имя переменной
  local variable=$1

  # Проверяем существование переменной
  if [ -v "$variable" ]; then
    return 0
  else
    return 1
  fi
}

# Функция для удаления переменной:
function delete_variable() {
  # Получаем имя переменной
  local variable=$1

  # Удаляем переменную
  unset $variable
}


# Функции для выполнения команд, например, для запуска других программ или выполнения системных вызовов.
# ------------------------------------------------------------------------------------------------------
# Функция для запуска другой программы:
function run_program() {
  # Получаем имя программы
  local program=$1

  # Запускаем программу
  $program
}
# Эта функция принимает в качестве аргумента имя программы, которую необходимо запустить. Функция просто запускает программу с помощью оператора ..

# Функция для выполнения системного вызова:
function run_system_call() {
  # Получаем имя системного вызова
  local system_call=$1

  # Выполняем системный вызов
  system $system_call
}
# Эта функция принимает в качестве аргумента имя системного вызова, который необходимо выполнить. Функция просто выполняет системный вызов с помощью оператора system.

# Функция для получения вывода команды:
function get_command_output() {
  # Получаем имя команды
  local command=$1

  # Получаем вывод команды
  local output=$(command)

  # Возвращаем вывод команды
  return $output
}
#Эта функция принимает в качестве аргумента имя команды, вывод которой необходимо получить. Функция выполняет команду и возвращает ее вывод.

# Функция для проверки существования команды:
function command_exists() {
  # Получаем имя команды
  local command=$1

  # Проверяем существование команды
  if command -v "$command"; then
    return 0
  else
    return 1
  fi
}

# Функция для получения списка аргументов команды:
function get_command_args() {
  # Получаем имя команды
  local command=$1

  # Получаем список аргументов команды
  local args=$(command -l)

  # Возвращаем список аргументов команды
  return $args
}



#clear
echo

# Initializations Parameters
# ==========================

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

#echo
#echo "Creating directories for system:"
#mkdir -p $USER/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,}
#echo "Directory for system creates successfuly"
#
#echo
#tree $ENV
#
#echo
#echo "Prepare to create system directory for git-source..."
#mkdir -p $USER/build/git-sources/{$USER/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,},}
#echo "System directories for git-sources was created successfuly"
#
#echo
#tree $ENV
#

# Runnings
# --------

#while getops u:p: option;
#do
#	case $option in
#		u)
#			user=$OPTARG
#			;;
#		p)
#			pass=$OPTARG
#			;;
#	esac
#done
#echo "User: $user / Pass: $pass"
#
#
#
#
#while getops :u:p:ab option;
#do
#	case $option in
#		u)
#			user=$OPTARG
#			;;
#		p)
#			pass=$OPTARG
#			;;
#		a)
#			echo "Got the A flag"
#			;;
#		b)
#			echo "Got the B flag"
#			;;
#	esac
#done
#echo "User: $user / Pass: $pass"





if [ -z $1 ];
then
	echo "the system directory creates with: $ENV"
else
	echo "the system directory creates with: $1"
	ENV=$1
fi



echo
echo "Creating directories for system:"
#mkdir -p $USER/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,}

mkdir -p $ENV/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,}
echo "Directory for system creates successfuly"

echo
#tree $ENV
ls -l $ENV/*

echo
echo "Prepare to create system directory for git-source..."
#mkdir -p $USER/build/git-sources/{$USER/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,},}

mkdir -p $ENV/build/git-sources/{$ENV/{bin,build/{git-sources,make,scripts/{sh_lib,init_env,},sources/{ExtData,lib,},},logs,src,tmp,},}
echo "System directories for git-sources was created successfuly"

echo
#tree $ENV
ls -l */



## ex00 = create the log file  =================================================
#freespace=$(df -h / | grep -E "\/$" | awk '{print $4}')
#greentext="\033[32m"
#bold="\033[1m"
#normal="\033[0m"
#logdate=$(date +"%Y%m%d")
#logfile="$logdate"_report.log
#
#echo -e $bold"Quick system report for "$greentext"$HOSTNAME"$normal
#printf "\tStystem type:\t%s\n" $MACHTYPE
#printf "\tBash Version:\t%s\n" $BASH_VERSION
#printf "\tFree space:\t%s\n" $freespace
#printf "\tFiles in dir:\t%s\n" $(ls | wc -l)
#printf "\tGenerated on:\t%s\n" $(date +"%d-%m-%y")
#echo -e $greentext"A summary of this info has been saved to $logfile"$normal
#
#cat <<- EOF > $logfile
#	This report was automatically generated by my Bash script.
#	It contains s brief summary of some system information.
#EOF
#
#printf "SYS:\t%s\n" $MACHTYPE >> $logfile
#printf "BASH:\t%s\n" $BASH_VERSION >> $logfile






# ex01 = colors ===============================================================
# Way 1 -------------------------------------------------------------------
#FLASH_RED="\033[5;31;40m"
#RED="\033[31;40m"
#NONE="\033[0m"
#echo -e "\033[5;31;40;mERROR: \033[0m\033[31;40mSomething went wrong!\033[0m"
#echo -e "\033[5;31;40mERROR: \033[0m\033[31;40mSomething went wrong!\033[0m"
#echo -e $FLASH_RED"ERROR: "$NONE$RED"Something went wrong!"$NONE

# Way 2 -------------------------------------------------------------------
#FLASH_RED=`tput setab 0; tput setaf 1; tput blink`
#RED=`tput setab 0; tput setaf 1`
#NONE=`tput sga0`
#man tput
#echo -e "\033[5;31;40;mERROR: \033[0m\033[31;40mSomething went wrong!\033[0m"
#echo -e "\033[5;31;40mERROR: \033[0m\033[31;40mSomething went wrong!\033[0m"
#echo -e $FLASH_RED"ERROR: "$NONE$RED"Something went wrong!"$NONE

## ex02 = read from file =======================================================
#i=1
#while read f; do
#	echo "line $i: $f"
#	echo "Creating directories for system:"
#	echo "Directory for system creates successfuly"
#	echo
#	echo "Prepare to create system directory for git-source..."
#	echo "System directories for git-sources was created successfuly"
#	((i++))
#done < file.txt


# echo -e "Amount of RAM:\t\t\t\t" `free -m | grep Mem | tr -s " " | cut -d " " -f2` Mb
 
# echo "====================================================="
# echo "~> Basic information about system"
# echo "====================================================="
# echo -e "Amount of RAM:\t\t\t\t" `free -m | grep Mem | tr -s " " | cut -d " " -f2` Mb
# echo -e "How many files in current directory:\t" `ls ./ | wc -l`
# echo -e "What is the \"VERSION_CODENAME\":\t\t" `cat /etc/os-release | grep VERSION_CODENAME | cut -d"=" -f2`
# echo -e "How many packages are installed:\t" `dpkg -l | wc -l`
# echo -e "How many users are connected:\t\t" `who | tr -s " " | cut -d" " -f2`
# echo -e "What is my Group ID number:\t\t" `id | grep gid | cut -d"=" -f2 | cut -d"(" -f1`
# echo -e "How many users are there in the system:\t" `cat /etc/passwd | wc -l`
# echo -e "What is the DNS we currently use:\t" `cat /etc/resolv.conf | grep nameserver | cut -d" " -f2`
# echo -e "For how long the system is up:\t\t" `uptime | tr -s " " | grep up | cut -d" " -f4 | cut -d"," -f1`
# echo -e "How many PCI devices are connected:\t" `lspci | grep PCI | wc -l`
# echo -e "How many USB devices are connected:\t" `lsusb | grep -i usb | wc -l`
# 
# 
# 
# 
# 
# 
# OUTSIDE_DIR=`echo ~-`
# THIS_DIR=$PWD
# CURRENT_DIR=`pwd`
# DIR_NAME=`basename "$CURRENT_DIR"`
# ENV=$USERNAME
# 
# 
# #clear
# 
# echo "outside directory: $OUTSIDE_DIR"
# echo "this directory:    $THIS_DIR"
# echo "current directory: $DIR_NAME"
# 
# cp -v * $DIR_NAME/tmp &> log.txt
# ls > /dev/null
# 
# echo `$`
# 
# ls -l sffdfasdf 1>success.txt 2>error.txt
# #ls -l 
# 
# echo "$(ps -p $$ -o args=)"
# echo "$-$$"
# echo "$0"
# 
# 
# declare -i d=1234
# declare -r e=34182
# declare -l l_str="LOLcats"
# declare -u u_str="LOLcats"
# 
# 
# 
# echo " $d"			# d - is an integer
# echo " $e"			# e - is read only
# echo " $l_str = LOLcats"	# l_str - is a lowercase
# echo " $u_str = LOLcats"	# u_str - is an uppercase
# echo "----------------------------------------------------"
# 
# echo "Returns user home directory:                            $HOME"
# echo "Returns current directory:                              $PWD"
# echo "Returns machine type:                                   $MACHTYPE"
# echo "Returns system name:                                    $HOSTNAME"
# echo "Returns user name:                                      $USERNAME"
# echo "Returns vertion of Bash:                                $BASH_VERSION"
# echo "Returns the number of seconds the Bash session has run: $SECONDS"
# 
# #echo `bash $0`
# #echo `bash my_script.sh`
# 

echo
echo

