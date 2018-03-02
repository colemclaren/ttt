SWEP.Spawnable = false
SWEP.AdminSpawnable = false

function SWEP:Initialize()
end

function SWEP:TranslateActivity(act)
	local owner = self.Owner
	return IsValid(owner) && owner:TranslateActivity(act) || act
end

function SWEP:TranslateGesture(act)
	local owner = self.Owner
	return IsValid(owner) && owner:TranslateGesture(act) || act
end