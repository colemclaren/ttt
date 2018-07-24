if (SERVER) then
	AddCSLuaFile "sh_enums.lua"
end
include "sh_enums.lua"

mlogs.hooks = mlogs.hooks or {}
function mlogs:hook(id, cb)
	self.hooks[id] = self.hooks[id] and self.hooks[id] + 1 or 1
	hook.Add(id, "mlogs." .. id .. "." .. self.hooks[id], cb)
	return self.hooks[id]
end

function mlogs:dehook(id, num)
	hook.Remove(id, "mlogs." .. id .. "." .. num)
end