#!/bin/bash

file_path="arm_embedded_systems"

# Флаг для проверки первой строки
first_line=true
arm=""

count=0

month=""
day=""
year=""

# Считываем каждую строку из файла
while IFS= read -r line || IFS= read -r line2
do
	# Проверяем, является ли строка первой
	if $first_line; then
		first_line=false
		continue
	fi

	# Проверяем, является ли строка пустой
	if [ -z "$line" ]; then
		continue
	fi

	tmp=""
	curr_line="`echo "$line" | grep -E -o "(Lesson|Training|Project)"`"
	if [ -n "$curr_line" ]; then
		((count++))

		tmp="$(echo ${curr_line,})"_"`printf "%02d" $count`"
		
		arm="arm_`printf "%02d" $count`_$tmp"
	fi
		
	month="`echo $line | cut -d' ' -f1`"
	day="`echo $line | cut -d' ' -f2 | cut -d',' -f1`"
	year="`echo $line | cut -d' ' -f3 | cut -d',' -f1`"

	date=""
	curr_line2="`echo "$line" | grep -E -o "(Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)"`"
	if [ -n "$curr_line2" ]; then
		date=${month,}"_"`printf "%02d" $day`"_"$year
		
		dir=`echo $arm"_"$date`
		mkdir -p $dir/{About,Classwork,Homework,}
		echo $dir
	fi

done < "$file_path"
