AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

util.AddNetworkString("TTT_ProxMineWarning")

function ENT:Think()
	if self.Warmup > 0 then
		self.Warmup = self.Warmup - 1
	else
		local Players = player.GetAll()
		local playersnear = 0

		for i = 1, table.Count(Players) do
			local ply = Players[i]

			if (not ply:Alive() or ply:IsTraitor()) then
				continue
			end

			local victimpos = ply:GetPos()
			local targetpos = self:GetPos()
			local distance = victimpos:Distance(targetpos)

			if (distance < self.ActivationRadius) then
				playersnear = playersnear + 1

				if (self.Armed) then
					self:Explode()
				end
			end
		end

		if (playersnear == 0 and not self.Armed) then
			self.Armed = true

			if SERVER then
				sound.Play(self.BeepSound, self:GetPos(), 75, 100)
			end
		end
	end
end

function ENT:Use(ply)
end


function ENT:Explode()
	if (self.Dying) then return end
    self.Dying = true
	self:Remove()
	
    local effect = EffectData()
    local pos = self:GetPos()
    effect:SetStart(pos)
    effect:SetOrigin(pos)
    util.Effect("Explosion", effect, true, true)
	util.EquipmentDestroyed(self:GetPos())

    local dmgowner = self:GetPlacer()
    self:SphereDamage(dmgowner, pos, self.DamageRadius)
end

-- traditional equipment destruction effects
function ENT:OnTakeDamage(dmginfo)
    self:TakePhysicsDamage(dmginfo)
    self:SetHealth(self:Health() - dmginfo:GetDamage())

    if (self:Health() < 0) then
        self:Explode()
    end
end


function ENT:SphereDamage(dmgowner, center, radius)
    -- It seems intuitive to use FindInSphere here, but that will find all ents
    -- in the radius, whereas there exist only ~16 players. Hence it is more
    -- efficient to cycle through all those players and do a Lua-side distance
    -- check. (This is no longer true lol)
    local r = radius ^ 2

    for _, ent in pairs(ents.FindInSphere(self:GetPos(), radius)) do
		if (ent:IsPlayer() and not ent:Alive()) then continue end

        -- deadly up to a certain range, then a quick falloff within 100 units
        local distance = ent:GetPos():Distance(self:GetPos()) 
        local dmg = 350 * math.min(1, 1.5 - distance / radius)


        -- test from hitpos to other entity to scale damage through walls
        local tr = util.TraceLine {
            start = self:GetPos(),
            endpos = ent:GetPos(),
            mask = MASK_SHOT,
            filter = {self, ent},
            collisiongroup = COLLISION_GROUP_WEAPON
        }

        if (tr.Hit and ent:IsPlayer()) then
            local tr2 = util.TraceLine{start = ent:GetPos(), endpos = self:GetPos(), mask = MASK_SHOT, filter = {self, ent}, collisiongroup = COLLISION_GROUP_WEAPON}
            local cont1, cont2 = util.GetSurfaceData(tr.SurfaceProps), util.GetSurfaceData(tr2.SurfaceProps)
            local walldist = tr2.HitPos:Distance(tr.HitPos)
            local mult = 1 - (walldist * (cont1.hardnessFactor + ((tr2.Hit and cont2) and cont2.hardnessFactor or 0))) / radius
            dmg = dmg * mult
        end

        local dmginfo = DamageInfo()
        dmginfo:SetDamage(dmg)
        dmginfo:SetAttacker(dmgowner)
        dmginfo:SetInflictor(self)
        dmginfo:SetDamageType(DMG_BLAST)
        dmginfo:SetDamageForce(center - ent:GetPos())
        dmginfo:SetDamagePosition(ent:GetPos())
        ent:TakeDamageInfo(dmginfo)
    end
end

function ENT:SendWarn(armed)
	local owner = self:GetPlacer()
	if (!armed or (IsValid(owner) and owner:IsTraitor())) then
		net.Start("TTT_ProxMineWarning")
			net.WriteUInt(self:EntIndex(), 16)
			net.WriteBool(armed)
			net.WriteVector(self:GetPos())
		net.Send(GetTraitorFilter(true))
	end
end

function ENT:OnRemove()
	self:SendWarn(false)
end
