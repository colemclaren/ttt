AddCSLuaFile()

if SERVER then
	/*resource.AddFile( "materials/models/hands/hands_color.vmt")
	resource.AddFile( "materials/models/hands/hands_color_jive.vmt")
	resource.AddFile( "materials/models/hands/pimp_body_color.vmt")
	resource.AddFile( "materials/models/hands/sleeves.vmt")
	resource.AddFile( "models/v_me_fists.mdl")*/
else
    WebElements = {}
    WebElements.CircleOutline	= "https://static.moat.gg/f/8IyaugdkU2ofps69WOpSpNEOJphr.png"
    WebElements.Circle 	  		= "https://static.moat.gg/f/m3d4nPegJ54TRsJce7ohIuLYi2mM.png"
    WebElements.Lava 	  		= "https://static.moat.gg/f/V8AViRgPo77b4TZPEarHK8zsW8Wz.jpg"
    WebElements.BandedCircle		= "https://static.moat.gg/f/r6eme6X9oUamu7I8kljtArKa9ZJ7.png"
    WebElements.HeartOutline		= "https://static.moat.gg/f/lmsokk8XWStmiccOupNlOdGkdF1h.png"
    WebElements.ClockHand		= "https://static.moat.gg/f/V7L3I0oJvhILX3fpbeXRVnGEPWLi.png"
    WebElements.QuadCircle		= "https://static.moat.gg/f/mEeGzSHefrWCmWvY5CAup4TrOBhX.png"
    WebElements.PlusSign			= "https://static.moat.gg/f/yrUmejBbXZyInphLh7qJyRLMRaQA.png"
    WebElements.SpeechBubble		= "https://static.moat.gg/f/hBPdWU7GV9eAwx7T74VyjWPAzFVf.png"
    WebElements.PowerMeter		= "https://static.moat.gg/f/ltKuiDtsnxDUnv5DVLImH6uTQwZA.png"


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

function SWEP:Initialize()
	self:SetHoldType("normal")
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "Bomb")
	self:NetworkVar("Bool", 1, "BombFire")
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "NextSprint")
end

function SWEP:UpdateNextSprint()
end

function SWEP:PrimaryAttack(NoForce)
		if self.Owner.IsBomb then
			if self:GetBomb() then return end
			if SERVER then
				self:ThrowTNT()
			else
				self.ThrewBomb = CurTime() + 2
			end
			NoForce = true
		end

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
				--self.Owner:ViewPunch(Angle(0, (-2):random(2), (-2):random(2)))
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
end

if SERVER then
	util.AddNetworkString("TNT.IsBomb")
	util.AddNetworkString("TNT.NewBomb")
	util.AddNetworkString("TNT.FuseTime")
	function TNTSetBomb(ply)
		CurTNTBomb = ply
		print("setbomb",ply)
		net.Start("TNT.IsBomb")
		net.WriteBool(false)
		net.Broadcast()
		for k,v in ipairs(player.GetAll()) do 
			if v.IsBomb then
				v:SetModel("models/player/leet.mdl")
			end
			v.IsBomb = false
			v:SetColor(Color(255,255,255)) 
			v:SetRunSpeed(220)
			v:SetWalkSpeed(220)
			v.SpeedMod = 1
		end 
		ply:SetModel(GAMEMODE.playermodel or "models/player/phoenix.mdl")
		net.Start("TNT.IsBomb")
		net.WriteBool(true)
		net.Send(ply)
		net.Start("TNT.NewBomb")
		net.WriteString(ply:Nick())
		net.Broadcast()
		ply:SetColor(Color(255,0,0))
		--BroadcastLua("chat.AddText(Color(255,0,0),[[" .. ply:Nick():gsub("%]%]","") .. "]],Color(255,255,255),[[ now has the bomb!]])")
		ply.IsBomb = true
	end
	function ChangeTNTFuseTime(t,r)
		if r then TNTFuseTime = CurTime() end
		TNTFuseTime = (TNTFuseTime or CurTime()) + t
		net.Start("TNT.FuseTime")
		net.WriteInt(TNTFuseTime,32)
		net.Broadcast()
	end
else
	net.Receive("TNT.IsBomb",function()
		LocalPlayer().IsBomb = net.ReadBool()
		if LocalPlayer().IsBomb then
			for k,v in ipairs(player.GetAll()) do
				if v.Skeleton then v:SetNoDraw(true) end
			end
		else
			for k,v in ipairs(player.GetAll()) do
				v:SetNoDraw(false)
			end
		end
	end)
end

hook.Add("ShouldCollide","NoCollideTNT",function(a,b)
	if CLIENT and not MOAT_TNT then return end
	if SERVER and not MG_TNT.InProgress then return end
	if SERVER and MG_TNT.Won then return end
	if a.NoCollide == "B" and (b.IsBomb) then return false end
	if b.NoCollide == "B" and (a.IsBomb) then return false end

	

	if b.NoCollide == "E" and (not a.IsBomb) then return false end
	if a.NoCollide == "E" and (not b.IsBomb) then return false end

	if (a.DidThing) or b.DidThing then return end

	if a.NoCollide == "B" and (b.Skeleton) then return false end
	if b.NoCollide == "B" and (a.Skeleton) then return false end

	if a.IsBomb and b.Skeleton then return false end
	if b.IsBomb and a.Skeleton then return false end
end)

--models/props_junk/PopCan01a.mdl
function SWEP:ThrowTNT()
	if self:GetBomb() then return end
	self:SetBomb(true)
	local ply = self.Owner
	ply:EmitSound([[weapons\tnt\draw.wav]])
	local egg = ents.Create("tnt_ball")
	CurTNTThrow = egg
	self.Bomb = egg
	egg.Bomb = true
	egg.NoCollide = "B"
	egg:SetCustomCollisionCheck(true)
	egg:CollisionRulesChanged()
	egg.sound = CreateSound(egg,"npc/manhack/mh_blade_loop1.wav")
	egg.sound:Play()
	egg:CallOnRemove("Stop sound", function()
		egg.sound:Stop()
		self:SetBomb(false)
	end)
	egg.Wep = self
	egg.Owner = self.Owner
	egg:SetGravity(1)
	egg:SetBallSize(25)
	egg:SetPos(self.Owner:GetShootPos())
	egg:SetModel("models/weapons/w_vir_tnt.mdl")
	egg.m_EggParent = self.Owner
	egg:Spawn()
	egg:SetOwner(self.Owner)
	egg:Activate()
	egg:GetPhysicsObject():AddAngleVelocity(self.Owner:GetAimVector() * (1024 * 10))
	egg:GetPhysicsObject():AddVelocity(self.Owner:GetAimVector() * (1024 * 10))
	egg.m_Velocity = egg:GetVelocity()
	--ThrewBomb
	timer.Simple(2,function()
		if not IsValid(egg) then return end
		if egg.Didthing then return end
		egg:EmitSound("npc/manhack/gib.wav")
		egg:Remove()
		self:SetBomb(false)
	end)
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

function SWEP:SecondaryAttack()
	if self:GetBomb() then return end
	if self.Owner.Skeleton then 
		self:PrimaryAttack()
	return end
	self:PrimaryAttack(true)
	if SERVER then
		if not self.Owner.IsBomb then
			if self:GetBombFire() then return end
			self:SetBombFire(true)
			local ply = self.Owner
			ply:EmitSound([[weapons\tnt\draw.wav]])
			local egg = ents.Create("prop_physics")
			egg:Ignite(100,0)
			egg:SetFriction(200000)
			egg:SetElasticity(0)
			egg:SetGravity(0.8)
			egg.NoCollide = "E"
			egg:SetCustomCollisionCheck(true)
			egg:CollisionRulesChanged()
			egg:AddCallback("PhysicsCollide", function(s,t)
				if s.DidThing then return end
				local ply = t.HitEntity
				if ply.IsBomb then
					-- shorten fuse
					ChangeTNTFuseTime(-1.25)
				end
				FrameDelay(function()
					s:Remove()
				end)
				self:SetBombFire(false)
				s.DidThing = true
			end)
			egg:SetPos(self.Owner:GetShootPos())
			egg:SetModel("models/props_junk/PopCan01a.mdl")
			egg:SetColor(Color(0,0,0,0))
			egg:SetRenderMode(RENDERMODE_TRANSALPHA)
			egg.m_EggParent = self.Owner
			egg:Spawn()
			egg:SetOwner(self.Owner)
			egg:Activate()
			egg:GetPhysicsObject():AddAngleVelocity(self.Owner:GetAimVector() * (m_Vel or 1024))
			egg:GetPhysicsObject():AddVelocity(self.Owner:GetAimVector() * (m_Vel or 1024))
			egg.m_Velocity = egg:GetVelocity()

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
		else
			self:ThrowTNT()
		end
	else
		if self.IsBomb then
			self.ThrewBomb = CurTime() + 2
		end
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
			--owner:ViewPunch(Angle(-5, rand, rand))
		elseif owner:OnGround() and owner.m_FistsHasJumped then
			owner.m_FistsHasJumped = nil
			--owner:ViewPunch(Angle(-2, rand, rand))
		end

		if owner:OnGround() and (owner:KeyDown(4) or owner:Crouching()) and not owner.m_FistHasCrouched then
			--owner:ViewPunch(Angle(-3.5, rand / 2, rand / 2))
			owner.m_FistHasCrouched = true
		elseif (not owner:KeyDown(4) and not owner:Crouching()) and owner.m_FistHasCrouched then
			--owner:ViewPunch(Angle(-2, rand / 2, rand / 2))
			owner.m_FistHasCrouched = nil
		end
	end
end

function SWEP:PreDrawViewModel(View, Weapon, Player)
	--View.RenderOverride = function() end
end

if SERVER then return end
local surface = surface
local draw = draw
local c_CValue = 1
local pColor = pColor
local vgui = vgui
local CrosshairPos = {}

function SWEP:DrawHUD()
	if vgui.CursorVisible() then return end
	if hook.Call("Lava.ShouldDrawCrosshair", nil, self.Owner, self ) == false then return end
	local Player = LocalPlayer()
	local tr = Player:GetEyeTrace()
	local tosc
	local w,h = ScrW(),ScrH()
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

	local xE, xT = (ScrH() / 100 + c_CValue), (c_CValue * ScrH() / 300)
	local t = LocalPlayer().IsBomb
	if not t then
		cdn.DrawImageRotated(WebElements.QuadCircle, tosc.x, tosc.y, xE / 2 + (CurTime() * 10):sin() * 5, xE / 2 + (CurTime() * 10):sin() * 5, Color(255,255,255,255 - c_CValue), (c_CValue / 5):sin() * 180)
		cdn.DrawImageRotated(WebElements.CircleOutline, tosc.x, tosc.y, xT + (CurTime() * 10):sin() * 5, xT + (CurTime() * 10):sin() * 5, Color(255,255,255,255 - c_CValue), 0)
	else
		cdn.DrawImageRotated(WebElements.QuadCircle, tosc.x, tosc.y, xE / 2 + (CurTime() * 10):sin() * 5, xE / 2 + (CurTime() * 10):sin() * 5, Color(255,0,0,255 - c_CValue), (c_CValue / 5):sin() * 180)
		cdn.DrawImageRotated(WebElements.CircleOutline, tosc.x, tosc.y, xT + (CurTime() * 10):sin() * 5, xT + (CurTime() * 10):sin() * 5, Color(255,0,0,255 - c_CValue), 0)
	end
	local Size = ScrH() / 12


	CrosshairPos[1], CrosshairPos[2] = tosc.x, tosc.y

	if LocalPlayer().IsBomb and (self.ThrewBomb or 0) > CurTime() then
		local bw = 100
		local t = self.ThrewBomb - CurTime()
		bw = math.max(0,bw * (t/2)) -- <
		draw.RoundedBox(0, w/2-50, h/2 -50, bw, 15, Color(255,0,0))
		surface.DrawOutlinedRect(w/2 - 50, h/2 - 50, 100, 15)
	end
end

_G.LavaCrosshairPos = CrosshairPos