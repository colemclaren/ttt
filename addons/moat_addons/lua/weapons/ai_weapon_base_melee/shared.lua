if(SERVER) then
	AddCSLuaFile("cl_init.lua")
	AddCSLuaFile("shared.lua")
end

SWEP.Base = "ai_weapon_base"
SWEP.Secondary.Automatic = true

SWEP.Primary.Delay = 0.6
SWEP.Primary.DelayPower = 1.325
SWEP.Primary.DelayPowerForward = 1.325
SWEP.Force = Vector(0,0,0)
SWEP.ForcePower = Vector(0,0,0)
SWEP.PowerAttack = true
SWEP.PowerAttackSlow = true
SWEP.Taunt = true
SWEP.Range = 75

local function CanHit(owner,ent)
	return ent != owner && (ent:IsNPC() || ent:IsPlayer() || ent:IsPhysicsEntity())
end

function SWEP:OnHit(ent,bPower) end

function SWEP:FindMeleeTarget(dist)
	local pos = self.Owner:GetPos() +self.Owner:OBBCenter()
	local ang = self.Owner:GetAimAngles()
	local tbEnts = ents.FindInSphere(pos,dist)
	local entClosest
	local dotClosest = 0.325
	local posClosest
	local dir = ang:Forward()
	for _,ent in ipairs(tbEnts) do
		if(ent:IsNPC() || ent:IsPlayer()) then
			local posEnt = ent:GetPos() +ent:OBBCenter()
			local dirEnt = (posEnt -pos):GetNormal()
			local dotProd = dir:DotProduct(dirEnt)
			if(dotProd > dotClosest) then
				dotClosest = dotProd
				entClosest = ent
				posClosest = posEnt
			end
		end
	end
	if(IsValid(entClosest)) then
		local tr = util.TraceLine({
			start = pos,
			endpos = posClosest,
			filter = {self.Owner,self},
			mask = MASK_SOLID
		})
		if(!tr.Entity:IsNPC() && !tr.Entity:IsPlayer()) then return end
		return tr.Entity,tr
	end
end

function SWEP:DealMeleeDamage(dist,dmg,force)
	local ent,tr = self:FindMeleeTarget(dist)
	if(!ent) then return {} end
	local ang = self.Owner:GetAimAngles()
	self:OnHit(ent,self.powerStrike)
	local dmgType = self.Primary.DamageType || DMG_SLASH
	local dir = ang:Forward()
	local dmgInfo = DamageInfo()
	dmgInfo:SetDamage(dmg)
	dmgInfo:SetAttacker(self.Owner)
	dmgInfo:SetInflictor(self)
	dmgInfo:SetDamageType(dmgType)
	dmgInfo:SetDamagePosition(tr.HitPos)
	if(force) then
		force = dir *force.x +ang:Right() *force.y +Vector(0,0,force.z)
		dmgInfo:SetDamageForce(force)
	end
	ent:TakeDamageInfo(dmgInfo)
	return {ent = ent,mat = tr.MatType}
end

function SWEP:DoPrimaryAttack(pos,dir)
end

function SWEP:OnStrike() end

local hitSounds = {
	[MAT_VENT] = "HitOther",
	[MAT_SLOSH] = "HitIce",
	[MAT_FOLIAGE] = "HitWood",
	[MAT_METAL] = "HitMetal",
	[MAT_CONCRETE] = "HitOther",
	[MAT_WARPSHIELD] = "HitOther",
	[MAT_SAND] = "HitDirt",
	[MAT_WOOD] = "HitWood",
	[MAT_TILE] = "HitOther",
	[MAT_GRATE] = "HitOther",
	[MAT_ANTLION] = "HitFlesh",
	[MAT_BLOODYFLESH] = "HitFlesh",
	[MAT_CLIP] = "HitOther",
	[MAT_ALIENFLESH] = "HitFlesh",
	[MAT_FLESH] = "HitFlesh",
	[MAT_EGGSHELL] = "HitFlesh",
	[MAT_GLASS] = "HitOther",
	[MAT_DIRT] = "HitDirt",
	[MAT_PLASTIC] = "HitOther",
	[MAT_COMPUTER] = "HitOther"
}
function SWEP:HitSound(mat,ent)
	if(mat == 0) then return end
	if(IsValid(ent) && (ent:IsNPC() || ent:IsPlayer())) then mat = MAT_FLESH end
	local snd = hitSounds[mat] || "HitOther"
	self:PlaySound(snd)
end

function SWEP:Strike(power)
	local itemID = self.itemID
	local data = self.m_itemData[itemID]
	local dmg = data.dmg
	if(power) then dmg = dmg *3 end
	local force
	if(power) then force = self.ForcePower
	else force = self.Force end
	local dist = 75
	local data = self:DealMeleeDamage(dist,dmg,force)
	self:OnStrike()
	if(SERVER) then
		if(data.mat && data.mat != 0) then self:HitSound(data.mat,data.ent)
		else self:PlaySound("Swing") end
	end
	return data
end