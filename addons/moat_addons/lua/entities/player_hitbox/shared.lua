AddCSLuaFile()
ENT.Type = "anim"

DEFINE_BASECLASS "base_anim"

local BIG_SCALE = 1.1

local function Reset(ply)
    if (not SERVER) then
        return
    end
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
                ent.ModelStr = ply:GetModel()

                local bone = ply:GetHitBoxBone(hitbox, group)

                local scale = ply:GetManipulateBoneScale(bone)

                local mins, maxs = ply:GetHitBoxBounds(hitbox, group)
                ent.Mins = mins * scale * BIG_SCALE
                ent.Maxs = maxs * scale * BIG_SCALE

                ent:Spawn()
                table.insert(hitboxes, ent)
            end
        end
    end)

    ply.HitBoxes_ = {}
end

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "HitBox")
    self:NetworkVar("Int", 1, "HitGroup")
end

function ENT:Initialize()
    if (SERVER) then
        self:PhysicsInitBox(self.Mins, self.Maxs)
        self:SetSolid(SOLID_VPHYSICS)
        self:PhysWake()
        self:GetPhysicsObject():EnableGravity(false)
        self.PhysCollide = CreatePhysCollideBox(self:GetCollisionBounds())
    end

    self:EnableCustomCollisions(true)
    self:DrawShadow(false)

    self:SetCollisionGroup(COLLISION_GROUP_DEBRIS)

    self:SetCustomCollisionCheck(true) -- has to do this unfortunately

end

function ENT:OnTakeDamage(dmg)
    if (dmg:IsDamageType(DMG_BULLET)) then
        self:GetOwner():TakeDamageInfo(dmg)
    end
end

function ENT:Think()
    if (not SERVER) then
        return
    end

    local hitbox, hitgroup = self:GetHitBox(), self:GetHitGroup()
    local owner = self:GetOwner()

    if (not IsValid(owner)) then
        self:Remove()
        return
    end

    if (owner:GetModel() ~= self.ModelStr) then
        Reset(owner)
        self:Remove()
        return
    end

    local bone = owner:GetHitBoxBone(hitbox, hitgroup)

    local pos, angles = owner:GetBonePosition(bone)

    self:SetPos(pos)
    self:SetAngles(angles)

    self:NextThink(CurTime())
    return true
end

local in_fire = false

hook.Add("EntityFireBullets", "moat.hitbox", function(att, data)
    local callback = data.Callback
    in_fire = att
    data.Callback = function(...)
        timer.Simple(0, function()
            in_fire = false
        end)
        if (callback) then
            return callback(...)
        end
    end
end)

function ENT:TestCollision(startpos, delta, isbox, extents, mask)
    if (not SERVER or not in_fire or in_fire == self:GetOwner() or self:GetOwner():IsSpec() or not self:GetOwner():Alive()) then
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

function ENT:Draw()
    if (self:GetOwner() == LocalPlayer()) then
        return
    end

    render.SetColorMaterial()
    local mins, maxs = self:GetCollisionBounds()
    render.DrawWireframeBox(self:GetPos(), self:GetAngles(), mins, maxs, Color(0,255,0,255), true)
end

hook.Add("ShouldCollide", "moat.hitbox", function(e1, e2)
    local hitbox = e1:GetClass() == "player_hitbox" and e1 or e2:GetClass() == "player_hitbox" and e2 or nil
    local other = e1 == hitbox and e1 or e2 == hitbox and e1 or nil
    if (hitbox) then
        return other:IsPlayer()
    end
end)

function ENT:UpdateTransmitState()
    return self.Transmit and TRANSMIT_PVS or TRANSMIT_NEVER
end

if (SERVER) then
    concommand.Add("player_hitbox_tag", function(ply)
        local e = ply:GetEyeTrace().Entity
        if (IsValid(e) and e:IsPlayer()) then
            for k,v in pairs(ents.FindByClass "player_hitbox") do
                if (v:GetOwner() == e) then
                    v.Transmit = true
                    v:AddEFlags(EFL_FORCE_CHECK_TRANSMIT)
                end
            end
        end
    end)
end

hook.Add("PlayerSpawn", "moat.hitbox", Reset)