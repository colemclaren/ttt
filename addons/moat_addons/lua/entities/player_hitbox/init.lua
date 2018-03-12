ENT.Type = "anim"

DEFINE_BASECLASS "base_anim"

local function Reset(ply)
    local hitboxes = ply.HitBoxes_ or {}
    for _, ent in pairs(ents.FindByClass "player_hitbox") do
        if ent:GetOwner() == ply then
            ent:Remove()
        end
    end
    table.Empty(hitboxes)

    timer.Create("reset_hitboxes_"..ply:EntIndex(), 4, 1, function()
        print("reset",ply:Nick())
        for group = 0, ply:GetHitBoxGroupCount() - 1 do
            for hitbox = 0, ply:GetHitBoxCount(group) - 1 do
                local ent = ents.Create "player_hitbox"
                ent:SetHitBox(hitbox)
                ent:SetHitGroup(group)
                ent:SetOwner(ply)
                ent:SetModelStr(ply:GetModel())

                local bone = ply:GetHitBoxBone(hitbox, group)

                local scale = ply:GetManipulateBoneScale(bone)

                local mins, maxs = ply:GetHitBoxBounds(hitbox, group)
                ent:SetMins(mins * scale)
                ent:SetMaxs(maxs * scale)

                ent:Spawn()
                table.insert(hitboxes, ent)
            end
        end
    end)

    ply.HitBoxes_ = {}
end

function ENT:SetupDataTables()
    self:NetworkVar("Vector", 0, "Mins")
    self:NetworkVar("Vector", 1, "Maxs")
    self:NetworkVar("Int", 0, "HitBox")
    self:NetworkVar("Int", 1, "HitGroup")
    self:NetworkVar("String", 0, "ModelStr")
end

function ENT:Initialize()
    self:PhysicsInitBox(self:GetMins(), self:GetMaxs())
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysWake()

    self:SetCollisionBounds(self:GetMins(), self:GetMaxs())
    self:EnableCustomCollisions(true)
    self:DrawShadow(false)

    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

    self.PhysCollide = CreatePhysCollideBox(self:GetMins(), self:GetMaxs())
end

function ENT:OnTakeDamage(dmg)
    self:GetOwner():TakeDamageInfo(dmg)
end

function ENT:Think()
    local hitbox, hitgroup = self:GetHitBox(), self:GetHitGroup()
    local owner = self:GetOwner()

    if (not IsValid(owner)) then
        self:Remove()
        return
    end

    if (owner:GetModel() ~= self:GetModelStr()) then
        Reset(owner)
        self:Remove()
        return
    end

    local bone = owner:GetHitBoxBone(hitbox, hitgroup)

    local pos, angles = owner:GetBonePosition(bone)

    self:SetPos(pos + Vector(0,0,10))
    self:SetAngles(angles)
end

local in_fire = false

hook.Add("EntityFireBullets", "moat.hitbox", function(att, data)
    local callback = data.Callback
    in_fire = att
    print"t"
    data.Callback = function(...)
        timer.Simple(0, function()
            print"d"
            in_fire = false
        end)
        if (callback) then
            return callback(...)
        end
    end
end)

function ENT:TestCollision(startpos, delta, isbox, extents, mask)
    if (not in_fire or in_fire == self:GetOwner() or self:GetOwner():IsSpec() or not self:GetOwner():Alive()) then
        print(false, in_fire, self:GetOwner())
        return
    end

    local pos, normal, frac = self.PhysCollide:TraceBox(self:GetPos(), self:GetAngles(), startpos, startpos + delta, -extents, extents)
    if (pos) then
        print(self:GetOwner(), in_fire)
        return {
            HitPos = pos,
            Normal = normal,
            Fraction = frac
        }
    end
end

function ENT:UpdateTransmitState()
    return TRANSMIT_NEVER
end

hook.Add("PlayerSpawn", "moat.hitbox", Reset)