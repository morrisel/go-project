#!/bin/bash

if [ $# -eq 0 ]; then
  echo "Usage: $0 <directory>"
  exit 1
fi

root_directory=$1

# Функция для создания log-файла в текущей директории
create_log_file() {
  local current_dir=$1
#  local log_file="${current_dir}.log"
    local log_file="${current_dir}/${current_dir##*/}.log"


  if [ ! -e "$log_file" ]; then
    touch "$log_file"
    echo "Created $log_file"
  fi
}

# Рекурсивная функция для обработки директорий
process_directory() {
  local current_dir=$1

  # Создаем log-файл для текущей директории
  create_log_file "$current_dir"

  # Обрабатываем все поддиректории
  for subdir in "$current_dir"/*; do
    if [ -d "$subdir" ]; then
      process_directory "$subdir"
    fi
  done
}

# Запускаем обработку
process_directory "$root_directory"

