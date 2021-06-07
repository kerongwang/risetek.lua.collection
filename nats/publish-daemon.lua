local params = {host = 'iotnats.yun74.com', port = 4222,}
local nats = require 'nats'
local iot = require "iot"
local topic = "query."..iot.id()
local data = {id = iot.id(),}

local pb = require "pb"
-- assert(pb.loadfile "/luapath/Query.pb")
assert(require "protoc":loadfile "/luapath/Query.proto")
function callback(message, reply)
 print ("call back message:", message, "\r\n")
 print ("call back reply:", reply, "\r\n")
end

while true do
 -- Wrap with pcall for tcp connect throws exception.
 pcall(function()
  local client = nats.connect(params)
  client:connect()
  while true do
   data.timestamp  = iot.timestamp()
   bytes = assert(pb.encode("com.risetek.yun74.shared.Query", data))
   print(pb.tohex(bytes), "\r\n")
   client:request(topic, bytes, callback)
   thread.delay(5000)
  end
 end)

 thread.delay(5000)
end
