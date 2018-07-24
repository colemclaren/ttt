if SERVER then
    AddCSLuaFile("shared.lua")
end

CreateConVar("ttt_ttester_delay", "1")
CreateConVar("ttt_ttester_destroystring", "Your portable tester has been destroyed!")
CreateConVar("ttt_ttester_dmglog", "1")
CreateConVar("ttt_ttester_chatlog", "0")
CreateConVar("ttt_ttester_innocentstring", "%s is an innocent. Protect him!")
CreateConVar("ttt_ttester_traitorstring", "%s is a traitor! Kill him!")
CreateConVar("ttt_ttester_talarm", "1")
CreateConVar("ttt_ttester_ambience", "1")
CreateConVar("ttt_ttester_ialarm", "1")
CreateConVar("ttt_ttester_uses", "3")
CreateConVar("ttt_ttester_multi", "0")
CreateConVar("ttt_ttester_explode", "0")

if CLIENT then
    ENT.Icon = "vgui/ttt/icon_cust_porttester.png"
    ENT.PrintName = "Portable Tester"

    ENT.TargetIDHint = {
        name = "Portable Tester",
        hint = "E to use the tester!"
    }
end

ENT.AlarmSound = "ambient/alarms/klaxon1.wav"
ENT.Type = "anim"
ENT.Health = 50
ENT.Model = Model("models/props/cs_militia/microwave01.mdl")
ENT.CanUseKey = true
ENT.CanHavePrints = true
ENT.Uses = 3
ENT.CanUse = true
ENT.InnocentColour = Color(75, 255, 0)
ENT.TraitorColour = Color(255, 0, 0)
ENT.White = color_white
ENT.Material = "models/debug/debugwhite"
AccessorFunc(ENT, "Placer", "Placer")
ENT.AmbienceSound = "ambient/machines/air_conditioner_loop_1.wav"
ENT.InAlarmSound = "buttons/combine_button5.wav"

function ENT:Initialize()
    local ambi = GetConVarNumber("ttt_ttester_ambience")
    local uses = GetConVarNumber("ttt_ttester_uses")
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
            phys:SetMass(20)
        end

        self:SetUseType(CONTINUOUS_USE)

        if ambi == 1 then
            self.asound = CreateSound(self, self.AmbienceSound)
            self.asound:Play()
        end
    end

    self:SetHealth(200)
    self:SetColor(Color(255, 255, 255, 255))
    self:SetPlacer(nil)
    self.fingerprints = {}
    self.Uses = uses
end

function ENT:SetColour(tstate)
    self:SetMaterial(self.Material)

    if tstate then
        self:SetColor(self.TraitorColour)
    else
        self:SetColor(self.InnocentColour)
    end
end

function ENT:UseCheck()
    self.Uses = self.Uses - 1
    self.CanUse = false
    local dstring = GetConVarString("ttt_ttester_destroystring")
    local delay = GetConVarNumber("ttt_ttester_delay")

    timer.Simple(delay, function()
        if not IsValid(self) then return end
        self:SetColor(self.White)
        self:SetMaterial("")

        if self.Uses == 0 then
            util.EquipmentDestroyed(self:GetPos())
            self:Remove()

            if IsValid(self:GetPlacer()) then
                CustomMsg(self:GetPlacer(), dstring, Color(255, 255, 255))
            end
        end

        self.CanUse = true
    end)
end

function ENT:SendMessage(tstate, ply)
    local chatlog = GetConVarNumber("ttt_ttester_chatlog")
    local ilog = GetConVarString("ttt_ttester_innocentstring")
    local tlog = GetConVarString("ttt_ttester_traitorstring")
    if chatlog == 0 then return end

    for k, v in pairs(player.GetAll()) do
        if tstate or ply:IsTraitor() then
            v:ChatPrint(Format(tlog, ply:Nick()))
        else
            v:ChatPrint(Format(ilog, ply:Nick()))
        end
    end
end

function ENT:Use(ply)
    if not ply:Alive() then return end
    if not ply then return end
    if not IsValid(ply) then return end
    if not self.CanUse then return end
    local talarm = GetConVarNumber("ttt_ttester_talarm")
    local ialarm = GetConVarNumber("ttt_ttester_ialarm")
    local multi = GetConVarNumber("ttt_ttester_multi")

    if (ply.Tested and multi == 0) or self.Uses <= 0 or ply:IsActiveDetective() then
        self:EmitSound("buttons/combine_button_locked.wav")

        return
    end

    ply.Tested = true

    if ply:IsTraitor() then
        self:SendMessage(true, ply)
        self:SetColour(true)
        self:UseCheck()

        if talarm == 1 then
            self:EmitSound(self.AlarmSound)
        end
    else
        self:SendMessage(false, ply)
        self:SetColour(false)
        self:UseCheck()

        if ialarm == 1 then
            self:EmitSound(self.InAlarmSound)
        end
    end
end

function ENT:OnTakeDamage(dmginfo)
    --  if dmginfo:GetAttacker() == self:GetPlacer() then return end
    local dmglog = GetConVarNumber("ttt_ttester_dmglog")
    local dstring = GetConVarString("ttt_ttester_destroystring")
    self:TakePhysicsDamage(dmginfo)
    self:SetHealth(self:Health() - dmginfo:GetDamage())
    local att = dmginfo:GetAttacker()

    if IsPlayer(att) and dmglog == 1 then
        DamageLog(Format("%s damaged a portable tester for %d dmg", att:Nick(), dmginfo:GetDamage()))
    end

    if self:Health() < 0 then
        self:Remove()
        util.EquipmentDestroyed(self:GetPos())

        if IsValid(self:GetPlacer()) then
            CustomMsg(self:GetPlacer(), dstring, Color(255, 255, 255))
        end
    end
end

if SERVER then
    function ENT:OnRemove()
        if self.asound then
            self.asound:Stop()
        end
    end
end