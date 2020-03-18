mlogs.net = mlogs.net or {}
mlogs.net.active = mlogs.net.active or false

hook("mlogs.init", function(s)
	s.net.active = true
end)

function mlogs.net:Load(id)
	if (SERVER) then
		util.AddNetworkString("mlogs.net." .. id)
	end
end

function mlogs:Receive(id, cb, cd)
	net.Receive("mlogs.net." .. id, function(_, p)
		assert(self.net.active, "mlogs cant receive " .. id)

		if (cd) then
			assert(p["mlogs.cd." .. id] == nil or p["mlogs.cd." .. id] <= CurTime(), "mlogs cant receive " .. id .. " from " .. p:Nick())
			p["mlogs.cd." .. id] = CurTime() + cd
		end

		cb(p)
	end)
end

function mlogs:Send(id, pl, cb)
	assert(self.net.active, "mlogs cant send " .. id)

	net.Start("mlogs.net." .. id)
	if (cb) then cb() end
	return (SERVER) and net.Send(pl) or net.SendToServer()
end

function mlogs:Broadcast(id, cb)
	assert(self.net.active, "mlogs cant broadcast " .. id)

	net.Start("mlogs.net." .. id)
	if (cb) then cb() end
	net.Broadcast()
end

local interval = engine.TickInterval()
local max_per_interval = 30000 * interval
function mlogs.BreakableMessage(data, i)
	i = i or 1
	local datas = data.datas

	if (not datas[i]) then return data.callback() end
	if (not data.checkfn(datas[i])) then i = i + 1 return mlogs.BreakableMessage(data, i) end

	data.startfn(i)
		while (datas[i]) do
			if (not checkfn(datas[i])) then i = i + 1 continue end
			net.WriteBool(true)
			data.writefn(i, datas[i])
			i = i + 1
			if (net.BytesWritten() >= max_per_interval) then
				break
			end
		end
		net.WriteBool(false)
	data.endfn()

	if (datas[i]) then
		timer.Simple(0, function()
			return mlogs.BreakableMessage(data, i)
		end)
	else
		return data.callback()
	end
end

if (SERVER) then
	include "_netids.lua"
end