

AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")

include('shared.lua')

local rangecvar = CreateConVar("sentry_range", "5000", {FCVAR_ARCHIVE})
local hpcvar = CreateConVar("sentry_hp", "50", {FCVAR_ARCHIVE})
local rofcvar = CreateConVar("sentry_rate_of_fire", "0.1", {FCVAR_ARCHIVE})
local dmgcvar = CreateConVar("sentry_damage", "5", {FCVAR_ARCHIVE})
local shotcvar = CreateConVar("sentry_shots_total", "60", {FCVAR_ARCHIVE})
local spreadcvar = CreateConVar("sentry_spread", "0", {FCVAR_ARCHIVE})


local sentryRange = rangecvar:GetInt()
function ENT:Initialize() //always spawn -90p
	self:SetModel("models/props_phx/facepunch_barrel.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_NONE)
	self:GetPhysicsObject():Wake()
	self:SetColor(Color(101, 101, 101, 255))
	self:SetModelScale(0)
	
	self.Pipe = ents.Create("prop_dynamic")
	self.Pipe:SetModel("models/props_canal/mattpipe.mdl")
	self.Pipe:PhysicsInit(SOLID_VPHYSICS)
	self.Pipe:SetMoveType(MOVETYPE_NONE)
	local ang = self:GetAngles()
	ang:RotateAroundAxis(ang:Up(), 180)
	ang:RotateAroundAxis(ang:Right(), -90)
	self.Pipe:SetPos(self:GetPos()-ang:Up()*7.5)
	self.Pipe:SetAngles(ang)
	self.Pipe:SetColor(Color(0, 0, 0, 255))
	
	self.Weapon = ents.Create("prop_dynamic")
	self.Weapon:SetModel("models/weapons/w_smg_mac10.mdl")
	self.Weapon:PhysicsInit(SOLID_VPHYSICS)
	self.Weapon:SetMoveType(MOVETYPE_NONE)
	self.Weapon:SetPos(self:GetPos()-ang:Up()*19.3828+ang:Forward()*0.5)
	self.NextShot = 0
	self.HealthPoints = hpcvar:GetInt()
	self.TotalShots = 0
end

function ENT:OnTakeDamage(dmg)
	local dmg = dmg:GetDamage()
	if self.HealthPoints-dmg <= 0 then
		local effectdata = EffectData()
		effectdata:SetStart(self:GetPos())
		effectdata:SetOrigin(effectdata:GetStart())
		util.Effect("HelicopterMegaBomb", effectdata)
		sound.Play("weapons/explode3.wav", self:GetPos(), 85, 115)
		self:Remove()
		return
	end
	self.HealthPoints = self.HealthPoints-dmg
end

function ENT:Think()
	local tbl, pos = player.GetAll(), self:GetPos()
	local target
	for i=1, #tbl do
		if tbl[i]:Team() != TEAM_SPECTATOR and (TEAM_SPEC and tbl[i]:Team() != TEAM_SPEC or true) and !tbl[i]:IsTraitor() and tbl[i]:Alive() and tbl[i]:GetPos():Distance(pos) < sentryRange and tbl[i]:Visible(self) then
			target = tbl[i]
			break
		end
	end
	if !target then return end
	
	local bone = target:LookupBone("ValveBiped.Bip01_Spine2")
	if !bone then return end
	local bonePos, boneAng = target:GetBonePosition(bone)
	
	local anglewep = (bonePos-self.Weapon:GetPos()):Angle()
	local anglepipe = Angle(anglewep.p, anglewep.y, anglewep.r)
	local selfAng = self:GetAngles()
	selfAng:RotateAroundAxis(selfAng:Up(), 180)
	selfAng:RotateAroundAxis(selfAng:Right(), -90)
	self.Pipe:SetAngles(Angle(selfAng.p, anglepipe.y, selfAng.r))
	self.Weapon:SetAngles(Angle(anglewep.p, anglewep.y, 0))

	if self.NextShot > CurTime() then return end
	self.NextShot = CurTime()+rofcvar:GetFloat()
	local bullets = {}
	bullets.Attacker = self.TurretOwner
	bullets.Damage = dmgcvar:GetInt()
	bullets.Force = bullets.Damage
	bullets.Num = 1
	bullets.Tracer = 1
	bullets.Spread = Vector(spreadcvar:GetFloat(), spreadcvar:GetFloat(), 0)
	local ang = self.Weapon:GetAngles()
	bullets.Src = self.Weapon:GetPos()+ang:Forward()*10
	bullets.Dir = ang:Forward()
	self.Weapon:FireBullets(bullets)
	sound.Play("weapons/ar1/ar1_dist"..math.random(1,2)..".wav", self:GetPos(), 80)
	self.TotalShots = self.TotalShots+1
	if shotcvar:GetInt() != 0 and self.TotalShots == shotcvar:GetInt() then
		local effectdata = EffectData()
		effectdata:SetStart(self:GetPos())
		effectdata:SetOrigin(effectdata:GetStart())
		util.Effect("HelicopterMegaBomb", effectdata)
		sound.Play("weapons/explode3.wav", self:GetPos(), 85, 115)
		self:Remove()
	end

	self:NextThink(CurTime() + .1)
	return true
end

function ENT:OnRemove()
	if self.Pipe then
		self.Pipe:Remove()
	end
	if self.Weapon then
		self.Weapon:Remove()
	end
end
