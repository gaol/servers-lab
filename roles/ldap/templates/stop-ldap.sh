#!/bin/bash

echo -e "Stop OpenLDAP Server:"
pidFile="/run/openldap/slapd.pid"
if [ -e $pidFile ]; then
  pid=$(cat /run/openldap/slapd.pid)
  if [ "X$(ps --no-headers -q $pid)" != "X" ]; then
    kill -s TERM $(cat /run/openldap/slapd.pid)
  fi
fi

