ENT.Type = "anim"

DEFINE_BASECLASS "base_anim"

local function Reset(ply)
    local hitboxes = ply.HitBoxes_ or {}
    for _, ent in pairs(ents.FindByClass "player_hitbox") do
        if ent:GetPlayer() == ply then
            ent:Remove()
        end
    end
    table.Empty(hitboxes)

    for group = 0, ply:GetHitBoxGroupCount() - 1 do
        for hitbox = 0, ply:GetHitBoxCount(group) - 1 do
            local ent = ents.Create "player_hitbox"
            ent:SetHitBox(hitbox)
            ent:SetHitGroup(group)
            ent:SetPlayer(ply)
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

    ply.HitBoxes_ = {}
end

function ENT:SetupDataTables()
    self:NetworkVar("Vector", 0, "Mins")
    self:NetworkVar("Vector", 1, "Maxs")
    self:NetworkVar("Entity", 0, "Player")
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

    self.PhysCollide = CreatePhysCollideBox(self:GetMins(), self:GetMaxs())
    self:SetCustomCollisionCheck(true)
end

function ENT:OnTakeDamage(dmg)
    self:GetPlayer():TakeDamageInfo(dmg)
end

function ENT:Think()
    local hitbox, hitgroup = self:GetHitBox(), self:GetHitGroup()
    local owner = self:GetPlayer()

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

    self:SetPos(pos)
    self:SetAngles(angles)
end


function ENT:TestCollision(startpos, delta, isbox, extents, mask)
    if (mask ~= MASK_SHOT) then
        return
    end

    local pos, normal, frac = self.PhysCollide:TraceBox(self:GetPos(), self:GetAngles(), startpos, startpos + delta, -extents, extents)
    if (pos) then
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

hook.Add("ShouldCollide", "moat.hitbox", function(e1, e2)
    local ply, hitbox
    if (e1:GetClass() == "player_hitbox") then
        hitbox = e1
    elseif (e2:GetClass() == "player_hitbox") then
        hitbox = e2
    else
        return
    end
    if (e1:IsPlayer()) then
        ply = e1
    elseif (e2:IsPlayer()) then
        ply = e2
    else
        return false
    end
    if (ply == hitbox:GetPlayer() or not hitbox:GetPlayer():Alive() or hitbox:GetPlayer():IsSpec()) then
        return false
    end
end)

hook.Add("PlayerSpawn", "moat.hitbox", Reset)