if SERVER then
	AddCSLuaFile("shared.lua")
	-- resource.AddWorkshop("924364350")
end

SWEP.Base = "weapon_tttbase"

if CLIENT then
	SWEP.PrintName = "Sentry Turret"
	SWEP.Slot = 1
	SWEP.SlotPos = 3
	SWEP.DrawAmmo = false
	SWEP.DrawCrosshair = false
	
	SWEP.Icon = "https://ttt.dev/Ksky0.png"
    SWEP.EquipMenuData = {
       type = "Sentry",
       desc = "Have the ability to set up a sentry that attacks\ninnocents."
    }
end


//SWEP.UseHands = true

SWEP.Author = "Tomasas"
SWEP.Instructions = ""


SWEP.Kind = WEAPON_EQUIP1
SWEP.CanBuy = {ROLE_TRAITOR}
SWEP.AllowDrop = false
SWEP.LimitedStock = true // change to false if you want the turret not be limited to 1 per round!
SWEP.IsSilent = false

SWEP.ViewModelFOV = 62
SWEP.ViewModelFlip = false
SWEP.AnimPrefix	 = "rpg"
//SWEP.ViewModel = ""
SWEP.WorldModel = "models/weapons/w_fists_t.mdl"

SWEP.Spawnable	= true
SWEP.AdminOnly	= true

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = false
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = 0
SWEP.Secondary.Automatic = false
SWEP.Secondary.Ammo = "none"

function SWEP:Initialize()
	self:SetWeaponHoldType("slam")
end

function SWEP:Deploy()
	if SERVER then
		self.Owner:DrawViewModel(false)
		self.Owner:DrawWorldModel(false)
	end
	//return true
end

local emptyFunc = function() end
SWEP.ViewModelDraw = emptyFunc
SWEP.DrawWorldModel = emptyFunc

function SWEP:GetIronsights()
	return false
end

local function CheckIfEmpty(vec)
	local NewVec = Vector(vec.x, vec.y, vec.z)
	NewVec.z = NewVec.z + 35
	NewVec.x = NewVec.x + 12.5
	NewVec.y = NewVec.y + 12.5
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z - 35
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z + 35
	NewVec.x = NewVec.x - 25
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z - 35
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z + 35
	NewVec.y = NewVec.y - 25
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z - 35
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z + 35
	NewVec.x = NewVec.x + 25
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	NewVec.z = NewVec.z - 35
	if util.PointContents(NewVec) == CONTENTS_SOLID then return false end
	
	return true
end

if CLIENT then
	local model
	local function initModel(self)
		model = ClientsideModel("models/hunter/blocks/cube05x105x05.mdl", RENDERGROUP_TRANSLUCENT)
		model:SetRenderMode(RENDERMODE_TRANSALPHA)
		model:SetMaterial("models/debug/debugwhite")
		model.Weapon = self
		local ang = Angle(0, LocalPlayer():GetAngles().y, 90)
		model:SetAngles(ang)
	end
	function SWEP:Think()
		if !IsValid(model) then initModel(self) end
		local tr = self.Owner:GetEyeTrace()
		tr.HitPos.z = tr.HitPos.z + 37.5
		model:SetPos(tr.HitPos)
		if tr.HitPos:Distance(self:GetPos()) > 102.5 or !CheckIfEmpty(tr.HitPos) or tr.HitNormal.x > 0.005 or tr.HitNormal.y > 0.005 or tr.HitNormal.z != 1 then
			model:SetColor(Color(255, 0, 0, 125))
			return
		end
		model:SetColor(Color(0, 255, 0, 125))
		local ang = Angle(0, LocalPlayer():GetAngles().y, 90)
		model:SetAngles(ang)
	
	end
	function SWEP:OnRemove()
		if IsValid(model) then
			model:Remove()
		end
	end
	function SWEP:Holster()
		if IsValid(model) then
			model:Remove()
		end
		return true
	end
	timer.Create("sentry_marker_delete", 2, 0, function()
		if !IsValid(model) or !model.Weapon or !LocalPlayer():IsValid() then return end
		local wep = LocalPlayer():GetActiveWeapon()
		if wep and wep != model.Weapon then model:Remove() end
	end)
end

function SWEP:PrimaryAttack()
	if CLIENT then return end
	local tr = self.Owner:GetEyeTrace()
	if tr.HitPos:Distance(self:GetPos()) > 100 or !CheckIfEmpty(tr.HitPos) or tr.HitNormal.x > 0.005 or tr.HitNormal.y > 0.005 or tr.HitNormal.z != 1 then return end
	local tbl = player.GetAll()
	for i=1, #tbl do
		if tbl[i]:GetPos():Distance(tr.HitPos) < 25 then return end
	end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	local ent = ents.Create("traitor_sentry")
	ent.TurretOwner = self.Owner
	ent:SetPos(tr.HitPos)
	local newAng = Angle(0, self.Owner:GetAngles().y, 0)
	ent:SetAngles(newAng)
	ent:Spawn()
	self:Remove()
end
SWEP.SecondaryAttack = SWEP.PrimaryAttack

