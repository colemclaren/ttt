AddCSLuaFile()
if (SERVER) then
    include "quaternion.lua"
end
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
        local parents = {
            hitboxes = {},
            bones = {}
        }

        for group = 0, ply:GetHitBoxGroupCount() - 1 do
            parents.hitboxes[group] = {}
            for hitbox = 0, ply:GetHitBoxCount(group) - 1 do
                local ent = ents.Create "player_hitbox"
                parents.hitboxes[group][hitbox] = ent
                ent:SetOwner(ply)
                ent:SetHitGroup(group)
                ent:SetHitBox(hitbox)
                ent.ModelStr = ply:GetModel()

                local bone = ply:GetHitBoxBone(hitbox, group)
                parents.bones[bone] = ent

                ent:SetBone(bone)

                local scale = ply:GetManipulateBoneScale(bone)

                local mins, maxs = ply:GetHitBoxBounds(hitbox, group)
                ent.Mins = mins * scale * BIG_SCALE
                ent.Maxs = maxs * scale * BIG_SCALE

                table.insert(hitboxes, ent)
            end
        end

        for group = 0, ply:GetHitBoxGroupCount() - 1 do
            for hitbox = 0, ply:GetHitBoxCount(group) - 1 do
                local ent = parents.hitboxes[group][hitbox]
                local bone = ply:GetHitBoxBone(hitbox, group)
                local parent = ply:GetBoneParent(bone)
                if (parent ~= -1 and parents.bones[parent]) then
                    parent = parents.bones[parent]
                    ent:SetHitBoxParent(parent)
                    parent.children = parent.children or {}
                    table.insert(parent.children, ent)
                end
                ent:Spawn()
            end
        end
    end)

    ply.HitBoxes_ = {}
end

function ENT:SetupDataTables()
    self:NetworkVar("Int", 0, "HitBox")
    self:NetworkVar("Int", 1, "HitGroup")
    self:NetworkVar("Int", 2, "Bone")
    self:NetworkVar("Entity", 0, "HitBoxParent")
end

function ENT:Initialize()
    self:PhysicsInitBox(self.Mins, self.Maxs)
    self:SetSolid(SOLID_VPHYSICS)
    self:PhysWake()
    self:GetPhysicsObject():EnableGravity(false)
    self.PhysCollide = CreatePhysCollideBox(self:GetCollisionBounds())

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

function ENT:Recalculate(parent, prevmatr)
    if (not SERVER) then
        return
    end

    local owner = self:GetOwner()

    if (owner:GetModel() ~= self.ModelStr) then
        Reset(owner)
        self:Remove()
        return
    end

    local bone = self:GetBone()

    local bmatr = owner:GetBoneMatrix(bone)
    pos = bmatr:GetTranslation() + owner:GetManipulateBonePosition(bone)

    local matr = Matrix()
    if (not prevmatr) then
        prevmatr = Matrix()
    end
    prevmatr:Rotate(owner:GetManipulateBoneAngles(bone))
    matr:SetAngles(bmatr:GetAngles())
    matr:Rotate(prevmatr:GetAngles())

    if (parent) then
        local angles = matr:GetAngles()
        pos, angles = WorldToLocal(pos, angles, owner:GetBonePosition(parent:GetBone()))
        pos, angles = LocalToWorld(pos, angles, parent:GetPos(), parent:GetAngles())
    end

    self:SetPos(pos)
    self:SetAngles(matr:GetAngles())

    local children = self.children
    if (children) then
        local m = Matrix()
        for i = 1, #children do
            m:Set(prevmatr)
            children[i]:Recalculate(self, m, owner:GetManipulateBoneAngles(bone))
        end
    end

    if (not parent) then
        self:NextThink(CurTime())
        return true
    end
end

function ENT:Think()
    if (not IsValid(self:GetOwner())) then
        self:Remove()
        return
    end
    if (not IsValid(self:GetHitBoxParent())) then
        return self:Recalculate()
    end
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
    local owner = self:GetOwner()
    if (owner == LocalPlayer() and not hook.Run("ShouldDrawLocalPlayer", owner) or owner:IsDeadTerror() or owner:IsSpec()) then
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
    concommand.Add("player_hitbox_tag", function(ply, cmd, args)
        local e = ply:GetEyeTrace().Entity
        if (args[1]) then
            e = Player(tonumber(args[1]))
        end
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