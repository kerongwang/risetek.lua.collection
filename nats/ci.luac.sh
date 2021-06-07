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

luac -s -o $LUA_TGZ_TEMP/daemon.lua ./publish-daemon.lua
luac -s -o $LUA_TGZ_TEMP/uuid.lua ../uuid.lua
luac -s -o $LUA_TGZ_TEMP/nats.lua ./nats.lua
luac -s -o $LUA_TGZ_TEMP/protoc.lua ../protoc.lua
luac -s -o $LUA_TGZ_TEMP/publish.lua ./publish.lua
luac -s -o $LUA_TGZ_TEMP/serpent.lua ../serpent.lua
cp ./Query.proto $LUA_TGZ_TEMP

tar czC $LUA_TGZ_TEMP . --transform='s,^\./,,' >| lua.tgz

tftp -i $1 PUT lua.tgz
rm -rf $LUA_TGZ_TEMP
rm lua.tgz
