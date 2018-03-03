ENT.Type 			= "anim"
ENT.PrintName		= "Knife"
ENT.Author			= "Worshipper"
ENT.Contact			= "Josephcadieux@hotmail.com"
ENT.Purpose			= ""
ENT.Instructions		= ""

function ENT:SetupDataTables()
	self:NetworkVar("Entity", 0, "Firer")
end

function ENT:PlayerTick(p)
    if (p ~= self:GetFirer()) then
        return
    end
    
    local T = FrameTime()
    local Vi = self.Velocity
    local A = Vector(0, 0, physenv.GetGravity())
    local Vf = Vi + A * T
    local d = Vf * T + self:GetPos()
    self.Velocity = Vf

    if (IsValid(self:GetFirer())) then
        self:GetFirer():LagCompensation(true)
    end
    local tr = util.TraceLine {
        start = self:GetPos(),
        endpos = d,
        filter = { self, self:GetFirer() }
    }

    if (IsValid(self:GetFirer())) then
        self:GetFirer():LagCompensation(false)
    end

    self:SetPos(tr.Hit and tr.HitPos or d)
    self.C_Pos = self:GetPos()

    local Ent = tr.HitEntity

    if (IsValid(Ent)) then
        if not(Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then 
            util.Decal("ManhackCut", data.HitPos + data.HitNormal, data.HitPos - data.HitNormal)
            self:EmitSound(self.Hit)
            self.HitEnemy = true
        end

        local damage = self.Damage

        if trace.Entity == Ent and trace.HitGroup == HITGROUP_HEAD then
            damage = damage * 2
        end

        if (not IsValid(self:GetOwner())) then
            self:Remove()
            return
        end

        local dmginfo = DamageInfo()
        dmginfo:SetAttacker(self:GetOwner())
        dmginfo:SetInflictor(self.Weapon)
        dmginfo:SetDamageType(DMG_BULLET)
        dmginfo:SetDamage(damage)

        hook.Call("ScalePlayerDamage", nil, Ent, trace.HitGroup, dmginfo)

        Ent:TakeDamageInfo(dmginfo)

        if (Ent:IsPlayer() or Ent:IsNPC() or Ent:GetClass() == "prop_ragdoll") then 
            local effectdata = EffectData()
            effectdata:SetStart(data.HitPos)
            effectdata:SetOrigin(data.HitPos)
            effectdata:SetScale(1)
            util.Effect("BloodImpact", effectdata)

            self:EmitSound(self.Hit)
        end
        if (Ent:IsPlayer() or Ent:IsNPC()) and (Ent:Health() > 0) or Ent:GetMoveType() == MOVETYPE_VPHYSICS then //and (!Ent == self:GetOwner()) then
            self.Entity:SetMoveType(MOVETYPE_NONE)
            self.Entity:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
            self:SetPos(self:GetPos() + self:GetForward() * -25)
            self:SetParent(Ent)
            self:SetOwner(Ent)
            self.SpawnTime = CurTime()
            self.Disabled = true
        end

        self:Remove()
    elseif (tr.Hit) then
        util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
        self:EmitSound(self.HitWall)
        if Vi:Length() > 400 then
            self:SetPos(tr.HitPos + self:GetForward() * -2)
            self:SetMoveType(MOVETYPE_NONE)
            self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
        end
        self.Disabled = true
        self.SpawnTime = CurTime()
    end

end


/*---------------------------------------------------------
   Name: ENT:Initialize()
---------------------------------------------------------*/
function ENT:Initialize()
    hook.Add("PlayerTick", self, self.PlayerTick)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetModel("models/morrowind/steel/arrow/steelarrow.mdl")

    self.SpawnTime = CurTime()
    self.HitEnemy = false
    self.Disabled = false

    self:DrawShadow(false)
    self:SetGravity(.01)

    util.PrecacheSound("weapons/bow/skyrim_bow_hitflesh.mp3")
    util.PrecacheSound("weapons/bow/skyrim_bow_hitwall.mp3")

    self.Hit = "weapons/bow/skyrim_bow_hitflesh.mp3"

    self.HitWall = "weapons/bow/skyrim_bow_hitwall.mp3"
end