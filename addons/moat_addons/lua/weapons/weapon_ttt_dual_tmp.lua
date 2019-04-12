
AddCSLuaFile()

SWEP.HoldType = "duel"
SWEP.PrintName = "Dual TMPs"

SWEP.Slot = 2
SWEP.Base = "weapon_tttbase"

SWEP.Kind = WEAPON_HEAVY
SWEP.ENUM = 7

SWEP.Primary.Damage      = 8
SWEP.Primary.Delay       = 0.06
SWEP.Primary.Cone        = 0.06
SWEP.Primary.ClipSize    = 20
SWEP.Primary.ClipMax     = 60
SWEP.Primary.DefaultClip = 20
SWEP.Primary.NumShots = 2
SWEP.Primary.Automatic   = true
SWEP.Primary.Ammo        = "pistol"
SWEP.Primary.Recoil      = 1.2
SWEP.Primary.Sound       = Sound( "Weapon_TMP.Single" )

SWEP.AutoSpawnable = false
SWEP.UseHands = false

SWEP.AmmoEnt = "item_ammo_pistol_ttt"

SWEP.ViewModelFlip		= true
SWEP.ViewModelFOV		= 54
SWEP.ViewModel  = "models/weapons/cstrike/c_smg_tmp.mdl"
SWEP.WorldModel = "models/weapons/w_smg_tmp.mdl"

SWEP.DeploySpeed = 3

SWEP.HeadshotMultiplier = 1.2

DEFINE_BASECLASS "weapon_tttbase"

function SWEP:ViewModelDrawn(vm)
    if (self.InsideDraw) then
        return
    end

    self.InsideDraw = true

    self.ViewModelFlip = not self.ViewModelFlip
    vm:SetupBones()
    vm:DrawModel()
    self.ViewModelFlip = not self.ViewModelFlip
    

    self.InsideDraw = false
end

if (CLIENT) then
    local WorldModel = ClientsideModel( SWEP.WorldModel )

    -- Settings...
    WorldModel:SetSkin( 1 )
    WorldModel:SetNoDraw( true )

    function SWEP:DrawWorldModel()
        local _Owner = self:GetOwner()

        if ( IsValid( _Owner ) ) then
            -- Specify a good position
            local offsetVec = Vector(6.5, -1.5, -5)
            local offsetAng = Angle(-5, -10, 0)

            local boneid = _Owner:LookupBone "ValveBiped.Bip01_L_Hand" -- Right Hand
            if not boneid then return end

            local matrix = _Owner:GetBoneMatrix( boneid )
            if !matrix then return end

            local newPos, newAng = LocalToWorld( offsetVec, offsetAng, matrix:GetTranslation(), matrix:GetAngles() )

            WorldModel:SetPos( newPos )
            WorldModel:SetAngles( newAng )

            WorldModel:SetupBones()
        else
            WorldModel:SetPos( self:GetPos() )
            WorldModel:SetAngles( self:GetAngles() )
        end

        WorldModel:DrawModel()
        self:DrawModel()
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
            
            self.ViewModelFlip = not self.ViewModelFlip
            

            return true
        end

    end
end