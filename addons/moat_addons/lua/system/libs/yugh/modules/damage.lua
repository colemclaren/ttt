local PLAYER       = FindMetaTable "Player"
local DAMAGE       = FindMetaTable "CTakeDamageInfo"
local Inflictor    = DAMAGE.GetInflictor

function DAMAGE:GetInflictor()
	local inf = Inflictor(self)
	if (IsValid(inf) and getmetatable(inf) == PLAYER) then
		inf = inf:GetActiveWeapon()
	end

	return inf
end