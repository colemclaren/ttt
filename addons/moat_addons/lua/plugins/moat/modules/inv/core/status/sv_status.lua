
util.AddNetworkString("moat.status.init")
--util.AddNetworkString("moat.status.adjust")
--util.AddNetworkString("moat.status.end")
util.AddNetworkString("moat.status.reset")

status = {}
status.StatusList = {}

function status.Create(name)
	assert(isstring(name), "Invalid name for status object")

	local _status = {}
	_status.Name = name

	setmetatable(_status, STATUS_BASE)

	status.StatusList[name] = _status

	return _status
end

function status.Inflict(name, data)
	if (not status.StatusList[name]) then error("no such status "..name) end

	status.StatusList[name]:Invoke(data)
end

--function status.

function status.Reset()
	--[[for _, status in pairs(status.StatusList) do
		--status:Reset()
	end]]

	--[[for _, pl in pairs(player.GetAll()) do
		pl.ActiveEffects = {}
	end]]
end

hook.Add("TTTEndRound", "moat.status.round.end", status.Reset)
hook.Add("TTTPrepareRound", "moat.status.round.begin", status.Reset)


local pl = FindMetaTable("Player")
function pl:ClearEffects()
	if (not self.ActiveEffects) then return end

	for id, state in pairs(self.ActiveEffects) do
		state.DoRemove = true
	end

	net.Start("moat.status.reset")
	net.Send(self)
end