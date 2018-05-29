
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
    self:NetworkVar("Float", 0, "DeleteTime")
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

function ENT:Think()
    if (not SERVER or not self:GetHit()) then
        return
    end

    local parent = self:GetParent()
    if (IsValid(parent) and parent:IsPlayer() and not parent:Alive() or
        (not IsValid(parent) or not parent:IsPlayer()) and self:GetDeleteTime() < CurTime()) then

        self:Remove()
    end
end

function ENT:PlayerTick(p)
    if (p ~= self:GetFirer()) then
        return
    end

    local pos = self:GetPos()
    local T = FrameTime()
    local Vi = self:GetVelocity2()
    local A = physenv.GetGravity() * 0.6
    local Vf = Vi + A * T
    local d = Vf * T + self:GetPos()
    self:SetVelocity2(Vf)
    self:SetPos(d)
    self:SetAngles(self:GetVelocity2():Angle() - Angle(180, 0, 0))

    if (IsValid(self:GetFirer())) then
        self:GetFirer():LagCompensation(true)
    end
    local tr = util.TraceLine {
        start = pos,
        endpos = d,
        filter = { self, self:GetFirer() }
    }
    if (IsValid(self:GetFirer())) then
        self:GetFirer():LagCompensation(false)
    end

    if (tr.Hit) then
        self:SetDeleteTime(CurTime() + 5)
        self:SetHit(true)
        self:SetPos(tr.HitPos)
        hook.Remove("PlayerTick", self)
    end

    local ent = tr.Entity
    if (IsValid(ent)) then
        local isplayerobject = ent:IsPlayer() or ent:IsNPC() or ent:GetClass() == "prop_ragdoll"

        if (SERVER) then
            local dmginfo = DamageInfo()
            dmginfo:SetAttacker(self:GetFirer())
            dmginfo:SetInflictor(IsValid(self.Weapon) and self.Weapon or self:GetFirer())
            dmginfo:SetDamageType(DMG_BULLET)
            dmginfo:SetDamage(self.Damage)

            ent:TakeDamageInfo(dmginfo)
        end

        if (isplayerobject) then
            local effectdata = EffectData()
            effectdata:SetStart(tr.HitPos)
            effectdata:SetOrigin(tr.HitPos)
            effectdata:SetScale(1)
            util.Effect("BloodImpact", effectdata)
        else
            util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
        end

        self:EmitSound(self.Hit)

        self:SetParent(ent)
        self:SetOwner(ent)
    elseif (tr.Hit) then
        util.Decal("ManhackCut", tr.HitPos + tr.HitNormal, tr.HitPos - tr.HitNormal)
        self:EmitSound(self.HitWall)
    end
end