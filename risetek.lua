local io = require("io")
local http = require("socket.http")
local ltn12 = require("ltn12")
local fileh = io.open("/luap/test.lua", "w")
socket.http.TIMEOUT = 5
io.write("\r\nstart risetek\r\n")
-- local body, statusCode, headers, statusText = http.request{url = 'http://firmware.risetek.com/lua/', sink = ltn12.sink.file(io.stdout)}
local body, statusCode, headers, statusText = http.request{url = 'http://firmware.risetek.com/lua/test.lua', sink = ltn12.sink.file(fileh)}

mutex = mutex.new()
cond  = cond.new(mutex)

function test()
	io.write("testing...\r\n")
	local f, error = loadfile("/luap/test.lua")
	if nil == error then
	 f()
	else
	 io.write("file load error\r\n")
	end
	mutex:lock()
	cond:signal()
	mutex:unlock()
end

print('statusCode ', statusCode, "\r\n")
print('statusText ', statusText, "\r\n")
print('headers\r\n')

if statusCode == 200 then

 for index,value in pairs(headers) do
    print(" ",index, value, "\r\n")
 end
-- print('body\r\n',body)

 for i = 1, 10, 1 do
  tn=thread.new(15, test, {})
  io.write("start risetek2\r\n")
  mutex:lock()
  tn:resume()
  thread:yield()
  io.write("start risetek3\r\n")
  cond:wait()
  mutex:unlock()
 end
-- waiting for test thread destoryed. 
 thread.delay(50)
end

