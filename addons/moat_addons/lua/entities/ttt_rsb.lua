local math = math

if SERVER then
    AddCSLuaFile()
end

AccessorFunc(ENT, "thrower", "Thrower")
AccessorFunc(ENT, "arm_time", "ArmTime", FORCE_NUMBER)
AccessorFunc(ENT, "radius", "Radius", FORCE_NUMBER)
AccessorFunc(ENT, "dmg", "Dmg", FORCE_NUMBER)
ENT.Type = "anim"
ENT.Model = Model("models/weapons/w_c4_planted.mdl")
ENT.CanHavePrints = false
ENT.CanUseKey = false
ENT.Avoidable = true

function ENT:Initialize()
    self:SetModel(self.Model)
    self:SetNoDraw(true)
    self:SetArmTime(45)

    if SERVER then
        self:PhysicsInit(SOLID_VPHYSICS)
    end

    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    if not self:GetThrower() then
        self:SetThrower(nil)
    end

    if not self:GetRadius() then
        self:SetRadius(300)
    end

    if not self:GetDmg() then
        self:SetDmg(GetConVar("RSB_BlastDamage"):GetInt())
    end
end

function ENT:SphereDamage(dmgowner, center, radius)
    -- It seems intuitive to use FindInSphere here, but that will find all ents
    -- in the radius, whereas there exist only ~16 players. Hence it is more
    -- efficient to cycle through all those players and do a Lua-side distance
    -- check.
    local r = radius ^ 2 -- square so we can compare with dotproduct directly
    -- pre-declare to avoid realloc
    local d = 0.0
    local diff = nil
    local dmg = 0

    for _, ent in pairs(player.GetAll()) do
        if IsValid(ent) and ent:Team() == TEAM_TERROR then
            -- dot of the difference with itself is distance squared
            diff = center - ent:GetPos()
            d = diff:Dot(diff)

            if d < r then
                -- deadly up to a certain range, then a quick falloff within 100 units
                d = math.max(0, math.sqrt(d) - 490)
                dmg = -0.01 * (d ^ 2) + 125
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
    end
end

local c4boom = Sound("c4.explode")

function ENT:Explode(tr)
    if SERVER then
        self:SetNoDraw(true)
        self:SetSolid(SOLID_NONE)
        local pos = self:GetPos()

        if util.PointContents(pos) == CONTENTS_WATER or GetRoundState() ~= ROUND_ACTIVE then
            self:Remove()

            return
        end

        local dmgowner = self:GetThrower()
        dmgowner = IsValid(dmgowner) and dmgowner or self
        local r_inner = 750
        local r_outer = self:GetRadius()

        if self.DisarmCausedExplosion then
            r_inner = r_inner / 2.5
            r_outer = r_outer / 2.5
        end

        -- damage through walls
        self:SphereDamage(dmgowner, pos, r_inner)
        -- explosion damage
        util.BlastDamage(self, dmgowner, pos, r_outer, self:GetDmg())
        local effect = EffectData()
        effect:SetStart(pos)
        effect:SetOrigin(pos)
        -- these don't have much effect with the default Explosion
        effect:SetScale(r_outer)
        effect:SetRadius(r_outer)
        effect:SetMagnitude(self:GetDmg())

        if tr.Fraction ~= 1.0 then
            effect:SetNormal(tr.HitNormal)
        end

        effect:SetOrigin(pos)
        util.Effect("Explosion", effect, true, true)
        util.Effect("HelicopterMegaBomb", effect, true, true)

        timer.Simple(0.1, function()
            sound.Play(c4boom, pos, 100, 100)
        end)

        -- extra push
        local phexp = ents.Create("env_physexplosion")
        phexp:SetPos(pos)
        phexp:SetKeyValue("magnitude", self:GetDmg())
        phexp:SetKeyValue("radius", r_outer)
        phexp:SetKeyValue("spawnflags", "19")
        phexp:Spawn()
        phexp:Fire("Explode", "", 0)

        -- few fire bits to ignite things
        timer.Simple(0.2, function()
            StartFires(pos, tr, 4, 5, true, dmgowner)
        end)

        SCORE:HandleC4Explosion(dmgowner, self:GetArmTime(), CurTime())
        self:Remove()
    else
        local spos = self:GetPos()

        local trs = util.TraceLine({
            start = spos + Vector(0, 0, 64),
            endpos = spos + Vector(0, 0, -128),
            filter = self
        })

        util.Decal("Scorch", trs.HitPos + trs.HitNormal, trs.HitPos - trs.HitNormal)
    end
end

function ENT:Think()
    if SERVER then
        if not self:GetParent():Alive() then
            self:Remove()
        end
    end
end