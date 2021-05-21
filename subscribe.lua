package.path = '../src/?.lua;src/?.lua;' .. package.path
pcall(require, 'luarocks.require')

local nats = require 'nats'

local params = {
    host = 'mq.yun74.com',
    port = 4222,
}

local pb = require "pb"
assert(pb.loadfile "SessionStatus.pb")


local client = nats.connect(params)

local function subscribe_callback(payload)
    local msg = assert(pb.decode("com.risetek.yun74.shared.SessionBrief", payload))
    print(require "serpent".block(msg))
--    print('Received data: ' .. payload)
end

-- client:enable_trace()
client:connect()
local subscribe_id = client:subscribe('yun74.drop.query.real', subscribe_callback)
client:wait(2)
client:unsubscribe(subscribe_id)
