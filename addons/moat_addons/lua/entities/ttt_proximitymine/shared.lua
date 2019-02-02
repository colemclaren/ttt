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

ENT.Dying = false
ENT.Warmup = 15
ENT.Armed = false
ENT.ActivationRadius = 225
ENT.DamageRadius = 280

-- traditional equipment destruction effects
function ENT:OnTakeDamage(dmginfo)
    self:TakePhysicsDamage(dmginfo)
    self:SetHealth(self:Health() - dmginfo:GetDamage())

    if self:Health() < 0 and not self.Dying then
        self:Explode()
    end
end

function ENT:Explode()
    self.Dying = true
    local effect = EffectData()
    local pos = self:GetPos()
    effect:SetStart(pos)
    effect:SetOrigin(pos)
    util.Effect("Explosion", effect, true, true)

    local dmgowner = self:GetPlacer()
    self:SphereDamage(dmgowner, pos, self.DamageRadius)

    util.EquipmentDestroyed(self:GetPos())
    self:Remove()
end

function ENT:SphereDamage(dmgowner, center, radius)
    -- It seems intuitive to use FindInSphere here, but that will find all ents
    -- in the radius, whereas there exist only ~16 players. Hence it is more
    -- efficient to cycle through all those players and do a Lua-side distance
    -- check.
    local r = radius ^ 2

    for _, ent in pairs(ents.FindInSphere(self:GetPos(), radius)) do
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
            local tr2 = util.TraceLine{
                endpos = self:GetPos(),
                start = ent:GetPos(),
                mask = MASK_SHOT,
                filter = {self, ent},
                collisiongroup = COLLISION_GROUP_WEAPON
            }

            local cont1, cont2 = util.GetSurfaceData(tr.SurfaceProps), util.GetSurfaceData(tr2.SurfaceProps)

            local walldist = tr2.HitPos:Distance(tr.HitPos)

            local mult = 1 - (walldist * (cont1.hardnessFactor + cont2.hardnessFactor)) / radius
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

                if distance < self.ActivationRadius then
                    playersnear = playersnear + 1

                    if self.Armed then
                        self:Explode()
                    end
                end
            end

            if playersnear == 0 and not self.Armed and not self.Dying then
                self.Armed = true

                if SERVER then
                    sound.Play(beep, self:GetPos(), 75, 100)
                end
            end
        end
    end
end