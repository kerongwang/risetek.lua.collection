-- load lua.tgz to local file system.
local http = require("socket.http")
local iot = require("iot")
local file = assert(io.open("/luapath/daemon.lua","wb"))
local save = assert(ltn12.sink.file(file))
local url = "http://iotlua.yun74.com/bootstrap/lua/0/"..iot.model().."/"..iot.version().."/"
print ("get: "..url.."\r\n")
local r, c, h, s = http.request {url = url, sink = save }
if c ~= 200 then print((s or c).."\r\n"); return false; end
return true;
