#!/bin/bash
set -e
if [ -z "$1" ]
 then
  echo "No target host provide"
  exit 1
fi

LUA_TGZ_TEMP=./build_temp_lua_tgz

rm -f ./lua.tgz
mkdir -p $LUA_TGZ_TEMP

cp ./risetek.lua $LUA_TGZ_TEMP
cp -r ./mqtt $LUA_TGZ_TEMP
cp mqttc.lua $LUA_TGZ_TEMP
cp ./nats/daemon.lua $LUA_TGZ_TEMP
cp ./uuid.lua $LUA_TGZ_TEMP
cp ./nats/nats.lua $LUA_TGZ_TEMP
cp ./nats/publish.lua $LUA_TGZ_TEMP
cp ./nats/subscribe.lua $LUA_TGZ_TEMP
cp ./nats/SessionStatus.pb $LUA_TGZ_TEMP
cp ./serpent.lua $LUA_TGZ_TEMP

tar czC $LUA_TGZ_TEMP . --transform='s,^\./,,' >| lua.tgz

tftp -i $1 PUT lua.tgz
rm -rf $LUA_TGZ_TEMP
rm lua.tgz
