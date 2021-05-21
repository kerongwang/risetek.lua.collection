package.path = '../src/?.lua;src/?.lua;' .. package.path
pcall(require, 'luarocks.require')

local nats = require 'nats'

local params = {
    host = 'mq.yun74.com',
    port = 4222,
}

local client = nats.connect(params)

local function subscribe_callback(payload)
    print('Received data: ' .. payload)
end

-- client:enable_trace()
client:connect()
local subscribe_id = client:subscribe('yun74.drop.query.real', subscribe_callback)
client:wait(2)
client:unsubscribe(subscribe_id)
