#!/bin/bash

/usr/bin/mysqladmin -S/var/lib/mysql/mysql.sock -u{{ mysql_root_username }} -p{{ mysql_root_password }} shutdown

pidFile="{{ mysql_pid_file }}"
if [ -e $pidFile ]; then
  pid=$(cat $pidFile)
  if [ "X$(ps --no-headers -q $pid)" != "X" ]; then
    echo -e "Failed to stop MySQL Server"
    exit 1
  fi
fi
echo -e "MySQL Server is stopped!"
