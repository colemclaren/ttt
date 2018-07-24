MSE.Commands        = MSE.Commands or {}
MSE.Commands.Stored = MSE.Commands.Stored or {}

local cmds    = {}
local cm_mt   = {}
cm_mt.__index = cm_mt

debug.getregistry().cm = cm_mt

function MSE.Commands.Register(cmd, info)
	local t = {
		Name = cmd,
		Arguments = {}
	}
	setmetatable(t, cm_mt)
	cmds[cmd] = t

	return t:_Construct()
end

function MSE.Commands.IsRegistered(cmd)
	return (cmds[cmd] ~= nil)
end

function cm_mt:SetCommand(str)
	self.StartCommand = str
	return self:_Construct()
end

function cm_mt:WhitelistRanks(str)
	self.WhitelistedRanks = str:Replace(" ", ""):Split(",")

	for i = 1, #self.WhitelistedRanks do
		self.WhitelistedRanks[self.WhitelistedRanks[i]] = true
	end

	return self:_Construct()
end

function cm_mt:RankBlacklist()
	self.BlacklistRanks = true
	return self:_Construct()
end

function cm_mt:SetDescription(str)
	self.Desc = str
	return self:_Construct()
end

function cm_mt:SetMinPlayers(str)
	self.MinPlayers = tonumber(str)
	return self:_Construct()
end

function cm_mt:WhitelistMaps(str)
	self.WhitelistedMaps = str:Replace(" ", ""):Split(",")

	for i = 1, #self.WhitelistedMaps do
		self.WhitelistedMaps[self.WhitelistedMaps[i]] = true
	end

	return self:_Construct()
end

function cm_mt:MapBlacklist()
	self.BlacklistMaps = true
	return self:_Construct()
end

function cm_mt:CommandArguments(info)
	for i = 1, #info do
		self.Arguments[i] = function(pl) return info[i](pl) end
	end
	
	return self:_Construct()
end

function cm_mt:_Construct()
	MSE.Commands.Stored[self.Name] = self

	return self
end


MSE.IncludeSH(MSE.Config.Path .. "_configs/commands.lua")