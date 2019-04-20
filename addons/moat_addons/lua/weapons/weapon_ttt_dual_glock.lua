
AddCSLuaFile()

SWEP.Base = "weapon_tttbase"
SWEP.HoldType = "duel"
SWEP.UseHands = false
SWEP.PrintName = "Dual Glocks"

if CLIENT then
   SWEP.Slot = 1

   SWEP.Icon = "vgui/ttt/icon_glock"
   SWEP.IconLetter = "c"
end

SWEP.Kind = WEAPON_PISTOL
SWEP.WeaponID = AMMO_GLOCK
SWEP.ENUM = 11

SWEP.Primary.Recoil	= 1
SWEP.Primary.Damage = 10
SWEP.Primary.Delay = 0.06
SWEP.Primary.Cone = 0.028
SWEP.Primary.ClipSize = 20
SWEP.Primary.Automatic = true
SWEP.Primary.DefaultClip = 20
SWEP.Primary.ClipMax = 60
SWEP.Primary.Ammo = "Pistol"
SWEP.Primary.NumShots = 2
SWEP.Primary.Range = 300
SWEP.AutoSpawnable = false
SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= false
SWEP.ViewModelFOV		= 54
SWEP.ViewModel          = "models/weapons/cstrike/c_pist_glock18.mdl"
SWEP.WorldModel         = "models/weapons/w_pist_glock18.mdl"

SWEP.Primary.Sound = Sound "Weapon_Glock.Single"

SWEP.HeadshotMultiplier = 1.45

DEFINE_BASECLASS "weapon_tttbase"

function SWEP:Initialize()
    BaseClass.Initialize(self)
    if (CLIENT) then
        self.WorldModelEntity = ClientsideModel(self.WorldModel)
        self.WorldModelEntity:SetNoDraw(true)
    end
end

function SWEP:OnRemove()
    if (CLIENT) then
        self.WorldModelEntity:Remove()
    end
end

function SWEP:ViewModelDrawn(vm)
    if (self.InsideDraw) then
        return
    end

    self.InsideDraw = true

	vm:DrawModel()
    self.ViewModelFlip = not self.ViewModelFlip
    vm:SetupBones()
	vm:DrawModel()

    self.InsideDraw = false
end

if (CLIENT) then
    function SWEP:DrawWorldModel()
        local WorldModel = self.WorldModelEntity
        local _Owner = self:GetOwner()
    
        local lp = LocalPlayer()
        if (lp ~= _Owner) then
            if (lp:GetObserverMode() == OBS_MODE_IN_EYE and lp:GetObserverTarget() == _Owner) then
                return
            end
        end
    
        if (old) then
            old(self)
        else
            self:DrawModel()
        end
        
        if (IsValid(_Owner)) then
            -- Specify a good position
            
            _Owner:SetupBones()
            local boneid = _Owner:LookupBone "ValveBiped.Bip01_L_Hand" -- Right Hand
            local b3 = WorldModel:LookupBone "ValveBiped.Bip01_R_Hand" or WorldModel:LookupBone "ValveBiped.weapon_bone"
            if not boneid or not b3 then return end

    
            local matrix = _Owner:GetBoneMatrix(boneid)
            local mpos, mang
            local m3 = WorldModel:GetBoneMatrix(b3)
            if (m3) then
                mpos, mang = m3:GetTranslation(), m3:GetAngles()
            else
                mpos, mang = WorldModel:GetBonePosition(b3)
            end
    
            if not matrix or not mpos then return end
            
            local pos, ang = LocalToWorld(vector_origin, Angle(0, 0, 180), matrix:GetTranslation(), matrix:GetAngles())
            local lpos, lang = WorldToLocal(WorldModel:GetPos(), WorldModel:GetAngles(), mpos, mang)
            pos, ang = LocalToWorld(lpos, lang, pos, ang)
    
            if (self.Offset) then
                pos = pos + ang:Forward() * self.Offset.Pos.Forward + ang:Right() * self.Offset.Pos.Right + ang:Up() * self.Offset.Pos.Up
                ang:RotateAroundAxis(ang:Up(), self.Offset.Ang.Up)
                ang:RotateAroundAxis(ang:Right(), self.Offset.Ang.Right)
                ang:RotateAroundAxis(ang:Forward(), self.Offset.Ang.Forward)
                ang:RotateAroundAxis(ang:Forward(), 180)
            end
    
            local offsetVec = self.OffsetVector or Vector(0, -2, 0)
            local offsetAng = self.OffsetAngle or Angle(-5, -10, 0)
    
            pos, ang = LocalToWorld(offsetVec, offsetAng, pos, ang)
    
            WorldModel:SetPos(pos)
            WorldModel:SetAngles(ang)
            WorldModel:SetupBones()
        else
            WorldModel:SetPos(self:GetPos() + self:GetAngles():Right() * 5)
            WorldModel:SetAngles(self:GetAngles())
        end
        WorldModel:DrawModel()
    end

    function SWEP:FireAnimationEvent( pos, ang, event, options )
        if (not self.CSMuzzleFlashes) then return end
        if (not IsValid(self.Owner)) then return end

        -- CS Muzzle flashes
        if ( event == 5001 or event == 5011 or event == 5021 or event == 5031 ) then

            local data = EffectData()
            data:SetFlags( 0 )
            data:SetEntity( self.Owner:GetViewModel() )
            data:SetAttachment( math.floor( ( event - 4991 ) / 10 ) )
            data:SetScale( 1 )

            if ( self.CSMuzzleX ) then
                util.Effect( "CS_MuzzleFlash_X", data )
            else
                util.Effect( "CS_MuzzleFlash", data )
            end

            return true
        end

    end
end