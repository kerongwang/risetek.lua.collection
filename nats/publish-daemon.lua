local params = {host = 'iot.yun74.com', port = 4222,}
local nats = require 'nats'
local client = nats.connect(params)
local iot = require "iot"
local pb = require "pb"
assert(pb.loadfile "/luapath/Query.pb")
local topic = "query."..iot.id()
local data = {id = iot.id(),}

client:connect()
while true do
 data.timestamp  = iot.timestamp()
 bytes = assert(pb.encode("com.risetek.yun74.shared.Query", data))
 print(pb.tohex(bytes), "\r\n")
 client:publish(topic, pb.tohex(bytes))
 thread.delay(5000)
end
