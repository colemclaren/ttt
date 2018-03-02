-- Generated from: glib/lua/glib/timers.lua
-- Original:       https://github.com/notcake/glib/blob/master/lua/glib/timers.lua
-- Timestamp:      2016-02-22 19:22:23
local delayedCalls = {}
CAC.SlowDelayedCalls = {}

function CAC.CallDelayed (callback)
	if not callback then return end
	if type (callback) ~= "function" then
		CAC.Error ("CAC.CallDelayed : callback must be a function!")
		return
	end
	
	delayedCalls [#delayedCalls + 1] = callback
end

function CAC.PolledWait (interval, timeout, predicate, callback)
	if not callback then return end
	if not predicate then return end
	
	if predicate () then
		callback ()
		return
	end
	
	if timeout < 0 then return end
	
	timer.Simple (interval,
		function ()
			CAC.PolledWait (interval, timeout - interval, predicate, callback)
		end
	)
end

hook.Add ("Think", "CAC.DelayedCalls",
	function ()
		local lastCalled = nil
		local startTime = SysTime ()
		while SysTime () - startTime < 0.005 and #delayedCalls > 0 do
			lastCalled = delayedCalls [1]
			xpcall (delayedCalls [1], CAC.Error)
			table.remove (delayedCalls, 1)
		end
		
		if SysTime () - startTime > 0.2 and lastCalled then
			MsgN ("CAC.DelayedCalls : " .. tostring (lastCalled) .. " took " .. CAC.FormatDuration (SysTime () - startTime) .. ".")
			CAC.SlowDelayedCalls [#CAC.SlowDelayedCalls + 1] = lastCalled
		end
	end
)