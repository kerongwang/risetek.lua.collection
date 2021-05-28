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

cp ./publish-daemon.lua $LUA_TGZ_TEMP/daemon.lua
cp ../uuid.lua $LUA_TGZ_TEMP
cp ./nats.lua $LUA_TGZ_TEMP
cp ./publish.lua $LUA_TGZ_TEMP
cp ./subscribe.lua $LUA_TGZ_TEMP
cp ./SessionStatus.pb $LUA_TGZ_TEMP
cp ./Query.pb $LUA_TGZ_TEMP
cp ../serpent.lua $LUA_TGZ_TEMP

tar czC $LUA_TGZ_TEMP . --transform='s,^\./,,' >| lua.tgz

tftp -i $1 PUT lua.tgz
rm -rf $LUA_TGZ_TEMP
rm lua.tgz
