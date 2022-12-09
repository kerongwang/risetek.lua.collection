-- load lua.tgz to local file system.
local http = require("socket.http")
local iot = require("iot")
local file = assert(io.open("/lua.tgz","wb"))
local url = "http://iotlua.yun74.com/lua/0/lua.tgz"
socket.http.TIMEOUT=5
local r, c, h, s = http.request {url = url, sink = ltn12.sink.file(file) }
if c ~= 200 then print((s or c).."\r\n"); return false; end
os.exit()
return true;
