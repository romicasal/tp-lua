-----------------------------------------------------------------------------------------
--
-- pipes_and_filters.lua
--
-----------------------------------------------------------------------------------------

function sleep(s)
  local ntime = os.clock() + s
  repeat until os.clock() > ntime
end

function receive (co)
  local status, value = coroutine.resume(co)
  return value
end

function send (x)
  coroutine.yield(x)
end

function producer ()
  return coroutine.create(function ()
  	local values = {1,2,3,4,5,6,7,8,9}
  	while true do
    	for v in ipairs(values) do
      	sleep(0.5)
      	send(v)
        end
    end
  end)
end

function filter (prod)
  return coroutine.create(function ()
    local line = 1
    while true do
      local x = receive(prod)
      if x % 2 == 0 then
        x = string.format("%5d %s", line, x)
        send(x)
        line = line + 1
      end
    end
  end)
end

function consumer (filt)
  for i=1, 20 do
    local x = receive(filt)
    io.write(x, "\n") 
  end
end

p = producer()
f = filter(p)
c = consumer(f)

print(coroutine.status(p))
print(coroutine.status(f))


