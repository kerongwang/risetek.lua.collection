#!/bin/bash
set -e
if [ -z "$1" ]
 then
  echo "No target host provide"
  exit 1
fi

rm -f ./lua.tgz
tar -zcf ./lua.tgz ./risetek.lua ./mqtt mqttc.lua ./daemon.lua
tftp -i $1 PUT lua.tgz
rm lua.tgz
