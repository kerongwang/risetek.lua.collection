-- package.path = '../src/?.lua;src/?.lua;' .. package.path
-- pcall(require, 'luarocks.require')

local nats = require 'nats'

local params = {
    host = 'iotnats.yun74.com',
    port = 4222,
}

local pb = require "pb"
assert(require "protoc":loadfile "/luapath/Query.proto")

local client = nats.connect(params)

local function subscribe_callback(payload)
    local msg = assert(pb.decode("com.risetek.yun74.shared.Query", payload))
    print(require "serpent".block(msg))
--    print('Received data: ' .. payload)
end

-- client:enable_trace()
client:connect()
local subscribe_id = client:subscribe('query.*', subscribe_callback)
client:wait(2)
client:unsubscribe(subscribe_id)
