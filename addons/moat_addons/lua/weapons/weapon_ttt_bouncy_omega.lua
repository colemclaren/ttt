
AddCSLuaFile()

SWEP.HoldType = "normal"

DEFINE_BASECLASS("weapon_tttbase")

if CLIENT then
   SWEP.PrintName = "Bouncy Ball Maker"
   SWEP.Slot = 3

   SWEP.ViewModelFOV = 10
end

SWEP.Base = "weapon_tttbase"
SWEP.CanDrop = false
SWEP.AutoSpawnable = false
SWEP.WeaponID = AMMO_SMOKE
-- SWEP.Kind = WEAPON_NADE

SWEP.ViewModel          = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel         = "models/props/cs_office/paper_towels.mdl"

SWEP.DrawCrosshair      = false
SWEP.ViewModelFlip      = false
SWEP.AllowDrop          = false
SWEP.Primary.Automatic  = true

function SWEP:Initialize()
    self.Balls = 0
end

function SWEP:DrawWorldModel()
end

function SWEP:PreDrawViewModel(vm)
    vm:SetNoDraw(true)
end

function SWEP:PostdrawViewModel(vm)
    vm:SetNoDraw(false)
end

function SWEP:CreateBall()
    return ents.Create "sent_ball"
end

function SWEP:PrimaryAttack()
    if (SERVER and self.Balls <= 8) then
        local owner = self:GetOwner()
        local start = owner:GetShootPos()
        local size = math.random(16, 48)
        local endpos = start + owner:GetAimVector() * (size * 2)
        local tr = util.TraceHull {
            filter = owner,
            start = start,
            endpos = endpos,
            mins = Vector(-size, -size, -size),
            maxs = Vector(size, size, size)
        }
        if (tr.Hit) then
            return
        end
        self.Balls = self.Balls + 1
        local ent = self:CreateBall()
        ent:SetPos(endpos)
        ent:SetBallSize(size)
        ent:Spawn()
        ent:Activate()
        ent:GetPhysicsObject():SetVelocity(owner:GetAimVector() * 600 + owner:GetVelocity())
		ent:SetCollisionGroup(COLLISION_GROUP_WEAPON)
        -- ent.OnRemove = function(s) self.Balls = self.Balls - 1 end
        ent.Use = function(s) s:Remove() end
		
		timer.Simple(10, function()
			if (IsValid(ent)) then
				ent:Remove()
			end
		end)
    end

    self:SetNextPrimaryFire(CurTime() + 2)
end

function SWEP:SecondaryAttack()
end