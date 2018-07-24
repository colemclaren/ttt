MSE.Ranks        = MSE.Ranks or {}
MSE.Ranks.Stored = MSE.Ranks.Stored or {}

local ranks    = {}
local ranks_mt   = {}
ranks_mt.__index = ranks_mt

debug.getregistry().ranks = ranks_mt

function MSE.Ranks.Register(rank)
	local t = {
		Name = rank,
	}
	setmetatable(t, ranks_mt)
	ranks[rank] = t

	return t:_Construct()
end

function MSE.Ranks.IsRegistered(rank)
	return (ranks[rank] ~= nil)
end

function ranks_mt:AmountUntilCooldown(str)
	self.MaxAmount = tonumber(str)
	return self:_Construct()
end

function ranks_mt:Cooldown(str)
	self.Cooldown = tonumber(str) * 60
	return self:_Construct()
end

function ranks_mt:Pretty(str)
	self.Pretty = str
	return self:_Construct()
end

function ranks_mt:_Construct()
	MSE.Ranks.Stored[self.Name] = self

	return self
end


MSE.IncludeSV(MSE.Config.Path .. "_configs/ranks.lua")