if SERVER then
    AddCSLuaFile()
    util.AddNetworkString("Bat Primary Hit")
else
    SWEP.Author = "Gamefreak"
    SWEP.Slot = 7
    SWEP.ViewModelFOV = 70
    SWEP.ViewModelFlip = false
    SWEP.Icon = "VGUI/ttt/icon_homebat"

    SWEP.EquipMenuData = {
        type = "Melee Weapon",
        desc = "Left click to hit a home run!\nHas 3 uses."
    }
end

SWEP.PrintName = "Homerun Bat"
SWEP.Base = "weapon_tttbase"
SWEP.ViewModel = Model("models/weapons/gamefreak/v_nessbat.mdl")
SWEP.WorldModel = Model("models/weapons/gamefreak/w_nessbat.mdl")
SWEP.HoldType = "melee"
SWEP.Primary.Damage = 35
SWEP.Primary.Delay = .5
SWEP.Primary.ClipSize = 3
SWEP.Primary.DefaultClip = 3
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.AutoSpawnable = false
SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE}
SWEP.LimitedStock = true
SWEP.DeployDelay = 0.9
SWEP.Range = 100
SWEP.VelocityBoostAmount = 500
SWEP.DeploySpeed = 10

function SWEP:Deploy()
    self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
    self:SetNextPrimaryFire(CurTime() + self.DeployDelay)

    return self.BaseClass.Deploy(self)
end

function SWEP:OnRemove()
    if CLIENT and IsValid(self.Owner) and self.Owner == LocalPlayer() and self.Owner:Alive() then
        RunConsoleCommand("lastinv")
    end
end

function SWEP:PrimaryAttack()
    local ply, wep = self.Owner, self.Weapon
    wep:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
    if not IsValid(ply) or wep:Clip1() <= 0 then return end
    ply:SetAnimation(PLAYER_ATTACK1)
    wep:SendWeaponAnim(ACT_VM_MISSCENTER)
    wep:EmitSound("Bat.Swing")
    local av, spos, tr = ply:GetAimVector(), ply:GetShootPos()
    local epos = spos + av * self.Range
    local kmins = Vector(1, 1, 1) * 7
    local kmaxs = Vector(1, 1, 1) * 7
    self.Owner:LagCompensation(true)

    local tr = util.TraceHull({
        start = spos,
        endpos = epos,
        filter = ply,
        mask = MASK_SHOT_HULL,
        mins = kmins,
        maxs = kmaxs
    })

    -- Hull might hit environment stuff that line does not hit
    if not IsValid(tr.Entity) then
        tr = util.TraceLine({
            start = spos,
            endpos = epos,
            filter = ply,
            mask = MASK_SHOT_HULL
        })
    end

    self.Owner:LagCompensation(false)
    local ent = tr.Entity
    if not tr.Hit or not (tr.HitWorld or IsValid(ent)) then return end

    if ent:GetClass() == "prop_ragdoll" then
        ply:FireBullets{
            Src = spos,
            Dir = av,
            Tracer = 0,
            Damage = 0
        }
    end

    if CLIENT then return end
    net.Start("Bat Primary Hit")
    net.WriteTable(tr)
    net.WriteEntity(ply)
    net.WriteEntity(wep)
    net.Broadcast()
    local isply = ent:IsPlayer()

    if isply then
        self:TakePrimaryAmmo(1)
        wep:SetNextPrimaryFire(CurTime() + wep.Primary.Delay * 4)

        if ent:GetMoveType() == MOVETYPE_LADDER then
            ent:SetMoveType(MOVETYPE_WALK)
        end

        local boost = wep.VelocityBoostAmount
        ent:SetVelocity(ply:GetVelocity() + Vector(av.x, av.y, math.max(1, av.z + .35)) * math.Rand(boost * .8, boost * 1.2) * 2)

        ent.was_pushed = {
            att = self.Owner,
            t = CurTime(),
            wep = self:GetClass()
        }
    elseif ent:GetClass() == "prop_physics" then
        local phys = ent:GetPhysicsObject()

        if IsValid(phys) then
            local boost = wep.VelocityBoostAmount
            phys:ApplyForceOffset(ply:GetVelocity() + Vector(av.x, av.y, math.max(1, av.z + .35)) * math.Rand(boost * 4, boost * 8), tr.HitPos)
        end
    end

    do
        local dmg = DamageInfo()
        dmg:SetDamage(isply and self.Primary.Damage or self.Primary.Damage * .5)
        dmg:SetAttacker(ply)
        dmg:SetInflictor(wep)
        dmg:SetDamageForce(av * 2000)
        dmg:SetDamagePosition(ply:GetPos())
        dmg:SetDamageType(DMG_CLUB)
        ent:DispatchTraceAttack(dmg, tr)
    end

    if wep:Clip1() <= 0 then
        timer.Simple(0.49, function()
            if IsValid(self) then
                if (SERVER) then self:Remove() end
                RunConsoleCommand("lastinv")
            end
        end)
    end
end

if CLIENT then
    net.Receive("Bat Primary Hit", function()
        local tr, ply, wep = net.ReadTable(), net.ReadEntity(), net.ReadEntity()
        local ent = tr.Entity
        local edata = EffectData()
        edata:SetStart(tr.StartPos)
        edata:SetOrigin(tr.HitPos)
        edata:SetNormal(tr.Normal)
        edata:SetSurfaceProp(tr.SurfaceProps)
        edata:SetHitBox(tr.HitBox)
        edata:SetEntity(ent)
        local isply = ent:IsPlayer()

        if (not IsValid(ent)) then return end
        if (not IsValid(wep)) then return end

        if isply or ent:GetClass() == "prop_ragdoll" then
            if isply then
                wep:EmitSound("Bat.Sound")

                timer.Simple(.48, function()
                    if IsValid(ent) and IsValid(wep) then
                        if ent:Alive() then
                            wep:EmitSound("Bat.HomeRun")
                        end
                    end
                end)
            end

            util.Effect("BloodImpact", edata)
        else
            util.Effect("Impact", edata)
        end
    end)
end