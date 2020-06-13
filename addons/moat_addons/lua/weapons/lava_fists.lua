AddCSLuaFile()

if SERVER then
	/*resource.AddFile( "materials/models/hands/hands_color.vmt")
	resource.AddFile( "materials/models/hands/hands_color_jive.vmt")
	resource.AddFile( "materials/models/hands/pimp_body_color.vmt")
	resource.AddFile( "materials/models/hands/sleeves.vmt")
	resource.AddFile( "models/v_me_fists.mdl")*/
else
    WebElements = {}
    WebElements.CircleOutline	= "http://i.imgur.com/WhK77op.png"
    WebElements.Circle 	  		= "http://i.imgur.com/YmbEJWD.png"
    WebElements.Lava 	  		= "http://i.imgur.com/swJIriB.jpg"
    WebElements.BandedCircle		= "http://i.imgur.com/OQpzdFx.png"
    WebElements.HeartOutline		= "http://i.imgur.com/OFaYwW7.png"
    WebElements.ClockHand		= "http://i.imgur.com/jQyeVXt.png"
    WebElements.QuadCircle		= "http://i.imgur.com/8uMN5HY.png"
    WebElements.PlusSign			= "http://i.imgur.com/N78SHA0.png"
    WebElements.SpeechBubble		= "https://i.imgur.com/rrSZw9C.png"
    WebElements.PowerMeter		= "https://i.imgur.com/AB6fK9L.png"


end
function FrameDelay( func )
    timer.Simple( FrameTime()*2, func )
end
SWEP.Base         = "weapon_tttbase"
function SWEP:Holster() return false end
SWEP.AllowDrop              = false
SWEP.PrintName = "Fists"
SWEP.Author = "Kilburn, robotboy655, MaxOfS2D & Tenrys"
SWEP.Purpose = "Well we sure as hell didn't use guns! We would just wrestle Hunters to the ground with our bare hands! I used to kill ten, twenty a day, just using my fists."
SWEP.Slot = 0
SWEP.SlotPos = 4
SWEP.CanDrop = false
SWEP.Spawnable = true
SWEP.ViewModel = "models/v_me_fists.mdl"
SWEP.WorldModel = ""
SWEP.ViewModelFOV = 70
SWEP.UseHands = true
SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.DrawCrosshair = true
SWEP.DrawAmmo = false
SWEP.HitDistance = 48
local SwingSound = Sound("WeaponFrag.Throw")
local HitSound = Sound("Flesh.ImpactHard")
local tVal
local math = math
local util = util
local Vector = Vector
local m_HasDispatchedEgg

local c_CurrentColor = Color( 255, 0, 0 )
local c_DesiredColor = Color(255,0,0)


function SWEP:Initialize()
	self:SetHoldType("normal")
	self:SetEggs(6)
end

function SWEP:SetupDataTables()
	self:NetworkVar("Int", 1, "Eggs")
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextSprint")
end

function SWEP:UpdateNextSprint()
	local vm = self.Owner:GetViewModel()
	self:SetNextSprint(CurTime() + vm:SequenceDuration() / vm:GetPlaybackRate())
end

function SWEP:PrimaryAttack(NoForce)

	self.Owner:SetAnimation(PLAYER_ATTACK1)
	local anim = "Shove"
	tVal = not NoForce
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence(anim))
	self:EmitSound(SwingSound)
	self:UpdateNextSprint()
	self:SetNextMeleeAttack(CurTime() + 0.2)
	self:SetNextPrimaryFire(CurTime() + 0.6)
	self:SetNextSecondaryFire(CurTime() + 0.6)
	self.Owner:SetNW2Int("$fist_attack_index", self.Owner:GetNW2Int("$fist_attack_index") + 1)

	if not NoForce then

		local tR_v = util.TraceLine({
			start = self.Owner:GetShootPos(),
			endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
			filter = self.Owner,
			mask = MASK_SHOT_HULL
		})

		if not IsValid(tR_v.Entity) then
			tR_v = util.TraceHull({
				start = self.Owner:GetShootPos(),
				endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector() * self.HitDistance,
				filter = self.Owner,
				mins = Vector(-10, -10, -8),
				maxs = Vector(10, 10, 8),
				mask = MASK_SHOT_HULL
			})
		end

		if tR_v.Hit then
			self:EmitSound(HitSound)

			if SERVER then
				self.Owner:ViewPunch(Angle(0, (-2):random(2), (-2):random(2)))
			end

			local Entity = tR_v.Entity
			if not IsValid(Entity) then return end
			if Entity:IsPlayer() then
				Entity:EmitSound("vo/npc/Barney/ba_pain0" .. math.random( 9 ) .. ".wav")
				if Entity:GetMoveType() == 9 then
					Entity:SetMoveType( 2 )
				end
			end
			if not Entity:IsPlayer() then
				if hook.Call( "Lava.PlayerPushEntity", nil, self.Owner, Entity ) == nil then
					if Entity:GetPhysicsObject():IsValid() then
						Entity:GetPhysicsObject():AddVelocity(self.Owner:GetAimVector() * (10000 * Entity:GetPhysicsObject():GetMass():Clamp(1, 100)))
					end
				end
			else
				Entity.m_LastShovedBy = self.Owner
				Entity.m_LastShovedTime = CurTime()
				if hook.Call( "Lava.PlayerPushPlayer", nil, self.Owner, Entity ) == nil then
                    local vec = self.Owner:GetForward()
                    vec.z = Entity:OnGround() and 0.2 or -0.2
					Entity:SetVelocity(vec * 1000)
				end
			end
		end
	end
end

function SWEP:Reload()
	hook.Call("Lava.FistsReload", nil, self.Owner, self )
	self.NextRagdollTime = self.NextRagdollTime or CurTime() + 1

	local pos = self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_Head1"))
	local trace = util.TraceLine({
		start = pos,
		endpos = Vector(pos.x, pos.y, self.Owner:GetBonePosition(self.Owner:LookupBone("ValveBiped.Bip01_R_Foot")).z),
		filter = player.GetAll()
	})

	if SERVER and self.NextRagdollTime < CurTime() and not trace.Hit then
		Ragdoll.Enable(self.Owner)
		self.Owner:Flashlight(false)
		self.Owner.m_NextRagdollifcationTime = CurTime() + 1
	end
end

function SWEP:SecondaryAttack()
	hook.Call("Lava.FistsSecondaryAttack", nil, self.Owner, self )
	self:PrimaryAttack(self:GetEggs() > 0)
	if self:GetEggs() < 1 then return end
	self:SetEggs(self:GetEggs() - 1)
	m_HasDispatchedEgg = true

	if SERVER then
		local egg = ents.Create("prop_physics")
		egg:SetPos(self.Owner:GetShootPos())
		egg:SetModel("models/props_phx/misc/egg.mdl")
		egg.m_EggParent = self.Owner
		egg:Spawn()
		egg:SetOwner(self.Owner)
		egg:Activate()
		local m_Vel = hook.Call("Lava.PlayerEggDispatched", nil, self.Owner, self, egg )
		egg:GetPhysicsObject():AddAngleVelocity(self.Owner:GetAimVector() * (m_Vel or 1024))
		egg:GetPhysicsObject():AddVelocity(self.Owner:GetAimVector() * (m_Vel or 1024))
		egg.m_Velocity = egg:GetVelocity()
		egg:SetCustomCollisionCheck(true)

		if m_Vel == false then
			egg:Remove()
			return
		end

		FrameDelay(function()
			if IsValid(egg) then
				egg:SetOwner()
				egg.m_Velocity = egg:GetVelocity()
			end
		end)
	end
end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:SendViewModelMatchingSequence(vm:LookupSequence("Draw"))
	vm:SetPlaybackRate(1)
	self:SetNextPrimaryFire(CurTime() + vm:SequenceDuration() / 1)
	self:SetNextSecondaryFire(CurTime() + vm:SequenceDuration() / 1)
	self:UpdateNextSprint()

	return true
end

function SWEP:Think()
	local owner = self:GetOwner()
	local vm = owner:GetViewModel()
	local anim = vm:GetSequenceName(vm:GetSequence())
	local curtime = CurTime()
	local Sprinttime = self:GetNextSprint()

	if (Sprinttime > 0 and curtime > Sprinttime) and owner:GetVelocity():Length2D() > owner:GetRunSpeed() - 10 and owner:OnGround() then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("Sprint"))
		self:UpdateNextSprint()
	elseif owner:GetNW2String("$climbquery", "") ~= "" and anim ~= "Shove" then
		self:SendWeaponAnim(191)
		self:SetCycle(0)
		vm:SetCycle(0)
		self:SetPlaybackRate(0)
	elseif not owner:OnGround() then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("Attack_Charge_Idle"))
	elseif owner:OnGround() and anim == "Attack_Charge_Idle" then
		vm:SendViewModelMatchingSequence(vm:LookupSequence("Idle"))
	end

	if SERVER then
		local rand = util.SharedRandom("m_SharedPunch", -1, 1, os.time())

		if not owner:OnGround() and not owner.m_FistsHasJumped then
			owner.m_FistsHasJumped = true
			owner:ViewPunch(Angle(-5, rand, rand))
		elseif owner:OnGround() and owner.m_FistsHasJumped then
			owner.m_FistsHasJumped = nil
			owner:ViewPunch(Angle(-2, rand, rand))
		end

		if owner:OnGround() and (owner:KeyDown(4) or owner:Crouching()) and not owner.m_FistHasCrouched then
			owner:ViewPunch(Angle(-3.5, rand / 2, rand / 2))
			owner.m_FistHasCrouched = true
		elseif (not owner:KeyDown(4) and not owner:Crouching()) and owner.m_FistHasCrouched then
			owner:ViewPunch(Angle(-2, rand / 2, rand / 2))
			owner.m_FistHasCrouched = nil
		end
	end
end

function SWEP:PreDrawViewModel(View, Weapon, Player)
	--View.RenderOverride = function() end
end

if SERVER then
	local net = net

	local player = player
	util.AddNetworkString("egged")

	hook.Add("PropBreak", "PropVengeance", function(Player, Object)
		if Object.m_EggParent and Object:GetModel() == "models/props_phx/misc/egg.mdl" then
			if Object.m_Velocity then
				util.Decal("BirdPoop", Object:GetPos(), Object:GetPos() + Object.m_Velocity, Object)
			end

			for _,Player in ipairs(player.GetAll()) do
				if Player:EyePos():Distance(Object:GetPos()) < 28 then
					if Object.m_EggParent ~= Player then

						local Weapon = Object.m_EggParent:GetActiveWeapon()

						if IsValid(Weapon) and Weapon:GetClass() == "lava_fists" then
							Weapon:SetEggs(Weapon:GetEggs() + 1)
						end
					end

					net.Start("egged")
					net.WriteEntity( Player )
					net.Broadcast()

					hook.Call("Lava.PlayerEgged", nil, Object.m_EggParent, Object, Player )
					break
				end
			end
		end
	end)
else
	local m_AmEgged
	local m_EggRefract = 1
	local DrawMaterialOverlay = DrawMaterialOverlay
	local FrameTime = FrameTime
	local EggCount
	local m_ShouldPlus
	local m_Position
	local White = color_white

	net.Receive("egged", function()
		local Player = net.ReadEntity()
		if (not IsValid(Player)) then return end

		if Player == LocalPlayer() then
			m_EggRefract = 1
			m_AmEgged = true
		end

		Player:AddVCDSequenceToGestureSlot( GESTURE_SLOT_FLINCH, Player:LookupSequence("zombie_attack_frenzy"), 0, false )
		Player:EmitSound("vo/npc/male01/ow02.wav")

		timer.Simple( 3, function()
			if IsValid( Player ) then
				Player:AddVCDSequenceToGestureSlot( GESTURE_SLOT_FLINCH, Player:LookupSequence("zombie_attack_frenzy"), 0, true )
			end
		end)
	end)

	hook.Add("RenderScreenspaceEffects", "E G G E D", function()
        if not istable(MOAT_LAVA) then return end
		if m_AmEgged then
			DrawMaterialOverlay("models/props_lab/tank_glass001", m_EggRefract)
			DrawMaterialOverlay("effects/water_warp01", m_EggRefract)
			DrawMaterialOverlay("models/shadertest/shader3", m_EggRefract)
			m_EggRefract = m_EggRefract:lerp(0, FrameTime())

			if m_EggRefract < 0.01 then
				m_AmEgged = nil
			end
		end
	end)

	hook.Add("HUDPaint", "AddEggz", function()
        if not istable(MOAT_LAVA) then return end
		local Weapon = LocalPlayer():GetActiveWeapon()

		if Weapon:IsValid() and Weapon:GetClass() == "lava_fists" then
			EggCount = EggCount or Weapon:GetEggs()

			if  EggCount < Weapon:GetEggs() then
				if m_HasDispatchedEgg then
					m_HasDispatchedEgg = nil
				end
				EggCount = Weapon:GetEggs()
				m_Position = ScrH() - ScrH() / 7
				m_ShouldPlus = true
			elseif EggCount ~= Weapon:GetEggs() then
				EggCount = Weapon:GetEggs()
			end
		end

		if m_ShouldPlus then
			cdn.DrawImageRotated(WebElements.PlusSign, ScrW() * 0.925 + (CurTime() * 3):sin() * 15, m_Position, 50, 50, Color(255,255,255,m_Position / 5), 0)
			m_Position = m_Position - FrameTime() * 255

			if m_Position < ScrH() / 3 then
				m_ShouldPlus = false
			end
		end
	end)
end

if SERVER then return end
local surface = surface
local draw = draw
local c_CValue = 1
local pColor = pColor
local vgui = vgui
local CrosshairPos = {}
local function EyeTraceEntity()
	local t = LocalPlayer():GetEyeTrace().Entity
	if IsValid( t ) and type( t ) == "Player" then
		return Color(0,255,0)
	end
end
if CLIENT then
	local cmeta = debug.getregistry().Color
	local ma = math.Approach
	local lp = Lerp
	function cmeta:BadLerp(b, n)
		return Color(lp(n, self.r, b.r), lp(n, self.g, b.g), lp(n, self.b, b.b), lp(n, self.a, b.a))
	end
	function cmeta:BadAlpha(n)
		return Color(self.r, self.g, self.b, n)
	end
end

function SWEP:DrawHUD()
	if vgui.CursorVisible() then return end
	if hook.Call("Lava.ShouldDrawCrosshair", nil, self.Owner, self ) == false then return end
	local Player = LocalPlayer()
	local tr = Player:GetEyeTrace()
	local tosc

	cam.Wrap3D(function()
		tosc = tr.HitPos:ToScreen()
	end)

	c_CValue = c_CValue:lerp(Player:GetVelocity():Length() / 5)

	if tVal then
		c_CValue = c_CValue + ScrH() / 20
		tVal = nil
	end

	if LocalPlayer():ShouldDrawLocalPlayer() then
		c_CValue = c_CValue:Clamp(10, ScrH() / 20)
	end

	c_DesiredColor = EyeTraceEntity() or Color(255,0,0)
	c_CurrentColor = c_CurrentColor:BadLerp( c_DesiredColor, FrameTime() * 3 ):BadAlpha(255 - c_CValue)


	local xE, xT = (ScrH() / 100 + c_CValue), (c_CValue * ScrH() / 300)
	-- cdn.DrawImageRotated(WebElements.QuadCircle, tosc.x, tosc.y, xE / 2 + (CurTime() * 10):sin() * 5, xE / 2 + (CurTime() * 10):sin() * 5, Color(255,255,255,255 - c_CValue), (c_CValue / 5):sin() * 180)
	-- cdn.DrawImageRotated(WebElements.CircleOutline, tosc.x, tosc.y, xT + (CurTime() * 10):sin() * 5, xT + (CurTime() * 10):sin() * 5, Color(255,255,255,255 - c_CValue), 0)
	cdn.DrawImageRotated(WebElements.QuadCircle, tosc.x, tosc.y, xE / 2 + (CurTime() * 10):sin() * 5 * 2, xE / 2 + (CurTime() * 10):sin() * 5 * 2, c_CurrentColor, (c_CValue / 5):sin() * 180)
	cdn.DrawImageRotated(WebElements.QuadCircle, tosc.x, tosc.y, xE / 2 + (CurTime() * 5):sin() * 5 * 5 * 2, xE / 2 + (CurTime() * 5):sin() * 5 * 5 * 2, c_CurrentColor, (c_CValue / 5):sin() * 180)
	local Size = ScrH() / 12

	for i = 1, self:GetEggs() do
		if not LAVA_EX then
			cdn.DrawImageRotated("https://static.moat.gg/f/532a095366d323af3f0a2ef72439c709.png", ScrW() - Size * (0.3 * i) - Size, ScrH() - Size * 1.5, Size, Size, nil, i == self:GetEggs() and (CurTime() * 5):sin() * 15 or -15, true)
		end
	end

	CrosshairPos[1], CrosshairPos[2] = tosc.x, tosc.y
end

_G.LavaCrosshairPos = CrosshairPos