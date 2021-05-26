local function subscribe_callback(payload)
    local msg = assert(pb.decode("com.risetek.yun74.shared.SessionBrief", payload))
    print(require "serpent".block(msg))
end

function test()
 local nats = require 'nats'

 local params = {
    host = 'mq.yun74.com',
    port = 4222,
 }

 local pb = require "pb"
 assert(pb.loadfile "/luapath/SessionStatus.pb")


 local client = nats.connect(params)


-- client:enable_trace()
 client:connect()
 local subscribe_id = client:subscribe('yun74.drop.query.real', subscribe_callback)
 while true do
  client:wait(2)
-- client:unsubscribe(subscribe_id)
 end
end

tn=thread.new(15, test, {})
tn:resume()
-- thread:yield()

while true do
 print 'hello, this is test\r\n'
 thread.delay(10000)
end