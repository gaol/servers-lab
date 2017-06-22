#!/bin/bash

# Start LDAP
echo -e "Load LDAP environment"
if [ -e "/etc/sysconfig/slapd" ]; then
    . /etc/sysconfig/slapd
fi
echo -e "Start OpenLDAP Server:"
/usr/sbin/slapd -u {{ ldap_user }} -h "ldap:/// ldaps:/// ldapi:///"

pidFile="/run/openldap/slapd.pid"
if [ -e $pidFile ]; then
  pid=$(cat /run/openldap/slapd.pid)
  if [ "X$(ps --no-headers -q $pid)" != "X" ]; then
    echo -e "OpenLDAP server is started successfully!"
  else
    echo -e "OpenLDAP Server failed to start!"
    exit 1
  fi
else
  echo -e "OpenLDAP Server failed to start!"
  exit 1
fi
