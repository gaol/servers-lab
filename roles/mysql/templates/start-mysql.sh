#!/bin/bash

cd {{ mysql_base_dir }} && /usr/bin/mysqld_safe --basedir={{ mysql_base_dir }} --datadir={{ mysql_data_dir }} --user={{ mysql_user }} --nowatch --pid-file={{ mysql_pid_file }}

sleep 5
pidFile="{{ mysql_pid_file }}"
if [ -e $pidFile ]; then
  pid=$(cat $pidFile)
  if [ "X$(ps --no-headers -q $pid)" != "X" ]; then
    if [ ! -e "/var/lib/mysql/mysql.sock" ]; then
      echo -e "/var/lib/mysql/mysql.sock does not exist!"
      kill $pid
      exit 1
    fi
    echo -e "MySQL Xerver is started successfully!"
  else
    echo -e "MySQL Server failed to start!"
    exit 1
  fi
else
  echo -e "MySQL Server failed to start!"
  exit 1
fi

