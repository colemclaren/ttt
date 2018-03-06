
util.PrecacheSound "weapons/bow/skyrim_bow_hitflesh.mp3"
util.PrecacheSound "weapons/bow/skyrim_bow_hitwall.mp3"
    
ENT.Type 			= "anim"
ENT.PrintName		= "Knife"
ENT.Author			= "Worshipper"
ENT.Contact			= "Josephcadieux@hotmail.com"
ENT.Purpose			= ""
ENT.Instructions		= ""
ENT.Hit = "weapons/bow/skyrim_bow_hitflesh.mp3"
ENT.HitWall = "weapons/bow/skyrim_bow_hitwall.mp3"

function ENT:SetupDataTables()
    self:NetworkVar("Entity", 0, "Firer")
    self:NetworkVar("Vector", 0, "Velocity2")
    self:NetworkVar("Bool", 0, "Hit")
end

function ENT:Initialize()
    hook.Add("PlayerTick", self, self.PlayerTick)
    self:SetMoveType(MOVETYPE_NONE)
    self:SetModel "models/morrowind/steel/arrow/steelarrow.mdl"

    self:DrawShadow(false)
    if (CLIENT) then
        self:SetPredictable(true)
    end
end

function ENT:PlayerTick(p)
    if (p ~= self:GetFirer()) then
        return
    end

    local T = FrameTime()
    local Vi = self:GetVelocity2()
    local A = physenv.GetGravity() * 0.3
    local Vf = Vi + A * T
    local d = Vf * T + self:GetPos()
    self:SetVelocity2(Vf)
    self:SetPos(d)
    self:SetAngles(self:GetVelocity2():Angle() - Angle(180, 0, 0))

    self:NextThink(CurTime())

    local LastCheck = self.LastCheck or self:GetPos()
    self.LastCheck = self:GetPos()

    if (IsValid(self:GetFirer())) then
        self:GetFirer():LagCompensation(true)
    end
    local tr = util.TraceLine {
        start = LastCheck,
        endpos = self:GetPos(),
        filter = { self, self:GetFirer() }
    }
    if (IsValid(self:GetFirer())) then
        self:GetFirer():LagCompensation(false)
    end

    if (tr.Hit) then
        self:SetPos(tr.Hit and tr.HitPos or d)
    end
    local ent = tr.Entity

    if (IsValid(ent)) then
        if (not (ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll")) then 
            util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
            self:EmitSound(self.Hit)
        end

        local damage = self.Damage
        if tr.HitGroup == HITGROUP_HEAD then
            damage = damage * 2
        end

        if (SREVER and not IsValid(self:GetOwner())) then
            self:Remove()
            return
        end

        if (SERVER) then
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(self:GetOwner())
            dmginfo:SetInflictor(self.Weapon)
            dmginfo:SetDamageType(DMG_BULLET)
            dmginfo:SetDamage(damage)

            hook.Call("ScalePlayerDamage", nil, ent, tr.HitGroup, dmginfo)

            ent:TakeDamageInfo(dmginfo)
        end

        if (ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll") then 
            local effectdata = EffectData()
            effectdata:SetStart(tr.HitPos)
            effectdata:SetOrigin(tr.HitPos)
            effectdata:SetScale(1)
            util.Effect("BloodImpact", effectdata)

            self:EmitSound(self.Hit)
        end
        if (ent:IsPlayer() or ent:IsNPC()) and ent:Health() > 0 or ent:GetMoveType() == MOVETYPE_VPHYSICS then
            self:SetMoveType(MOVETYPE_NONE)
            self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)
            self:SetPos(self:GetPos())
            self:SetParent(ent)
            self:SetOwner(Ent)
            hook.Remove("PlayerTick", self)
            self:SetHit(true)
        end
    elseif (tr.Hit) then
        util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
        self:EmitSound(self.HitWall)
        if self:GetVelocity2():Length() > 400 then
            self:SetPos(tr.HitPos + self:GetForward() * -25)
            self:SetMoveType(MOVETYPE_NONE)
            hook.Remove("PlayerTick", self)
            self:SetHit(true)
        end
    end

end