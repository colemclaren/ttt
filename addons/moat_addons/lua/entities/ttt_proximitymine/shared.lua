---- Health dispenser
if SERVER then
    AddCSLuaFile("shared.lua")
end

if CLIENT then
    -- this entity can be DNA-sampled so we need some display info
    ENT.Icon = "VGUI/ttt/icon_health"
    ENT.PrintName = "Health Station"
    local GetPTranslation = LANG.GetParamTranslation
end

ENT.Type = "anim"
ENT.Model = Model("models/props_combine/combine_mine01.mdl")
--ENT.CanUseKey = true
AccessorFunc(ENT, "Placer", "Placer")

function ENT:Initialize()
    self:SetModel(self.Model)
    self:PhysicsInit(SOLID_VPHYSICS)
    self:SetMoveType(MOVETYPE_VPHYSICS)
    self:SetSolid(SOLID_BBOX)
    local b = 32
    self:SetCollisionBounds(Vector(-b, -b, -b), Vector(b, b, b))
    self:SetCollisionGroup(COLLISION_GROUP_WEAPON)

    if SERVER then
        self:SetMaxHealth(200)
        local phys = self:GetPhysicsObject()

        if IsValid(phys) then
            phys:SetMass(200)
        end
    end

    self:SetHealth(50)
    --self:SetColor(Color(180, 180, 250, 255))
    --self:SetPlacer(nil)
end

function ENT:Use(ply)
end

ENT.Dying = 0

-- traditional equipment destruction effects
function ENT:OnTakeDamage(dmginfo)
    self:TakePhysicsDamage(dmginfo)
    self:SetHealth(self:Health() - dmginfo:GetDamage())

    if self:Health() < 0 and self.Dying == 0 then
        self:Explode()
    end
end

function ENT:Explode()
    self.Dying = 1
    local effect = EffectData()
    local pos = self:GetPos()
    effect:SetStart(pos)
    effect:SetOrigin(pos)
    util.Effect("Explosion", effect, true, true)
    local dmgowner = self:GetPlacer()
    self:SphereDamage(dmgowner, pos, 250)
    util.BlastDamage(self, dmgowner, pos, 250, 100)
    util.EquipmentDestroyed(self:GetPos())
    self:Remove()
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
            d = diff:DotProduct(diff)

            if d < r then
                -- deadly up to a certain range, then a quick falloff within 100 units
                d = math.max(0, math.sqrt(d) - 490)
                dmg = -0.01 * (d ^ 2) + 125
                local dmginfo = DamageInfo()
                dmginfo:SetDamage(dmg)
                dmginfo:SetAttacker(dmgowner)
                dmginfo:SetInflictor(self.Entity)
                dmginfo:SetDamageType(DMG_BLAST)
                dmginfo:SetDamageForce(center - ent:GetPos())
                dmginfo:SetDamagePosition(ent:GetPos())
                ent:TakeDamageInfo(dmginfo)
            end
        end
    end
end

ENT.Warmup = 15
ENT.armed = 0
local beep = Sound("npc/roller/mine/rmine_blades_out1.wav")

if SERVER then
    function ENT:Think()
        if self.Warmup > 0 then
            self.Warmup = self.Warmup - 1
        else
            local Players = player.GetAll()
            local playersnear = 0

            for i = 1, table.Count(Players) do
                local ply = Players[i]
                local victimpos = ply:GetPos()
                local targetpos = self:GetPos()
                local distance = victimpos:Distance(targetpos)

                if distance < 225 then
                    playersnear = playersnear + 1

                    if self.armed == 1 then
                        self:Explode()
                    end
                end
            end

            if playersnear == 0 and self.armed == 0 then
                self.armed = 1

                if SERVER then
                    sound.Play(beep, self:GetPos(), 75, 100)
                end
            end
        end
    end
end