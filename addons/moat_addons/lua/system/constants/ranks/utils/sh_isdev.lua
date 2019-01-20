-- we define whitelist of Devs in system/startup/init.lua
moat.isdev, moat.isdev_cache = function(lookup, can_null)
	if (moat.isdev_cache[lookup] ~= nil) then
		return moat.isdev_cache[lookup]
	end

	if (lookup == nil) then
		error("moat.isdev called with nil lookup")
		return false
	end

	if (lookup == NULL and not can_null) then
		return true
	end

	if (IsValid(lookup) and not lookup:IsPlayer() and IsValid(lookup:GetOwner()) and lookup:GetOwner():IsPlayer()) then
		lookup = lookup:GetOwner()
	end

	lookup = (IsValid(lookup) and lookup:IsPlayer()) and lookup:SteamID64() or lookup
	for k, v in ipairs(Devs) do
		if (v.SteamID == lookup or v.SteamID64 == lookup) then
			moat.isdev_cache[lookup] = true
			return true
		end
	end

	moat.isdev_cache[lookup] = false
	return false
end, {}