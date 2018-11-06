// Send required files to client
AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")


// Include needed files
include("shared.lua")


// Called when the entity initializes
function ENT:Initialize()
	self:SetModel("models/player/Kleiner.mdl")
	self.health = 100
end 


// Called when we take damge
function ENT:OnTakeDamage(dmg)
	local pl = self:GetOwner()
	local attacker = dmg:GetAttacker()
	local inflictor = dmg:GetInflictor()
	// Health
	
	if pl && pl:IsValid() && pl:Alive() && pl:IsPlayer() && attacker:IsPlayer() && dmg:GetDamage() > 0 then

		if not self.LastHitp then self.LastHitp = {} end
        if (self.LastHitp[attacker] or 0) > CurTime() then return end
        self.LastHitp[attacker] = CurTime() + 0.1
		self.health = self.health - dmg:GetDamage()
		pl:SetHealth(self.health)

		SHR:SendHitEffects(attacker, dmg:GetDamage(), dmg:GetDamagePosition())

		if self.health <= 0 then
			pl:Kill()

			if inflictor && inflictor == attacker && inflictor:IsPlayer() then
				inflictor = inflictor:GetActiveWeapon()
				if !inflictor || inflictor == NULL then inflictor = attacker end
			end

			attacker.PHScore = attacker.PHScore + 1
			net.Start("PH_Kill")
			net.WriteEntity(attacker)
			net.WriteString(pl:Nick())
			net.Broadcast()
			attacker:SetHealth(attacker:Health() + 10)
			timer.Simple(0,function() self:Remove() end)

		end
	end
end 