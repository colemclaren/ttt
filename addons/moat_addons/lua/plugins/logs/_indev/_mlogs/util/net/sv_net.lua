function mlogs.net:Load(id)
	util.AddNetworkString("mlogs.net." .. id)
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
	net.Send(pl)
end

function mlogs:Broadcast(id, cb)
	assert(self.net.active, "mlogs cant broadcast " .. id)

	net.Start("mlogs.net." .. id)
	if (cb) then cb() end
	net.Broadcast()
end

-- credit meepen https://steamcommunity.com/profiles/76561198050165746
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

include "sv_ids.lua"