AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
local rangecvar = CreateConVar("sentry_range", "1000", {FCVAR_ARCHIVE})
local hpcvar = CreateConVar("sentry_hp", "50", {FCVAR_ARCHIVE})
local rofcvar = CreateConVar("sentry_rate_of_fire", "0.25", {FCVAR_ARCHIVE})
local dmgcvar = CreateConVar("sentry_damage", "5", {FCVAR_ARCHIVE})
local shotcvar = CreateConVar("sentry_shots_total", "60", {FCVAR_ARCHIVE})
local spreadcvar = CreateConVar("sentry_spread", "0", {FCVAR_ARCHIVE})
local sentryRange = 1000
ENT.NextShot = 0
ENT.HealthPoints = math.random(200, 300)
ENT.TotalShots = 0
ENT.TurretOwner = NULL
ENT.Target = NULL
ENT.Alerted = false
ENT.turret_turningsd = nil
ENT.NextResetEnemyT = 0
--always spawn -90p
function ENT:Initialize()
	self:SetModel("models/Combine_turrets/Floor_turret.mdl")
	self:PhysicsInit(SOLID_VPHYSICS)
	self:SetMoveType(MOVETYPE_VPHYSICS)
	self:GetPhysicsObject():Wake()
	self:GetPhysicsObject():SetMass(100)
	self:SetCollisionBounds(Vector(13, 13, 60), Vector(-13, -13, 0))
	self:SetColor(Color(255, 0, 0, 255))
	self.TurretOwner = self.TurretOwner or NULL
	self.Target = NULL

	self.SpawnTime = CurTime()

	self.NextShot = 0
	self.HealthPoints = math.random(200, 300)
	self.TotalShots = 0
	self.Turret_AlarmTimes = 0
	self.Turret_NextAlarmT = 0
	self.Alerted = false

	sound.Play("npc/turret_floor/deploy.wav", self:GetPos(), 65, math.random(100, 110))
	self.turret_turningsd = CreateSound(self, "npc/turret_wall/turret_loop1.wav")
	self.turret_turningsd:SetSoundLevel(70)
	self.turret_turningsd:PlayEx(1,100)
end

function ENT:OnTakeDamage(dmg)
    local dmg = dmg:GetDamage()

    if self.HealthPoints - dmg <= 0 then
        local effectdata = EffectData()
        effectdata:SetStart(self:GetPos())
        effectdata:SetOrigin(effectdata:GetStart())
        util.Effect("HelicopterMegaBomb", effectdata)
        sound.Play("weapons/explode3.wav", self:GetPos(), 85, 115)
        self:Remove()

        return
    end

    self.HealthPoints = self.HealthPoints - dmg
end

ENT.Turret_TurningSound = "npc/turret_wall/turret_loop1.wav"
ENT.Turret_AlarmSound = {"npc/turret_floor/ping.wav"}
ENT.Turret_RetractSound = {"npc/turret_floor/retract.wav"}
ENT.Turret_FireSound = {"npc/turret_floor/shoot1.wav","npc/turret_floor/shoot2.wav","npc/turret_floor/shoot3.wav"}
ENT.Turret_AlarmTimes = 0
ENT.Turret_NextAlarmT = 0
ENT.ResetedEnemy = false
local thinking = .1
function ENT:Think()
    local tbl, pos = player.GetAll(), self:GetPos()
    local target

    for i = 1, #tbl do
        if tbl[i]:Team() ~= TEAM_SPECTATOR and (TEAM_SPEC and tbl[i]:Team() ~= TEAM_SPEC or true) and not tbl[i]:IsTraitor() and tbl[i]:Alive() and tbl[i]:GetPos():Distance(pos) < sentryRange and tbl[i]:Visible(self) and self:GetForward():Dot((tbl[i]:GetPos() -self:GetPos()):GetNormalized()) >= math.cos(math.rad(75)) then
			target = tbl[i]
	
			if (not IsValid(self.Target) or (IsValid(self.Target) and self.Target ~= tbl[i])) then
				self.Alerted = false
				self.ResetedEnemy = false
				self.Target = tbl[i]
			end

            break
        end
    end

    if (not IsValid(target)) then
		self.Turret_NextAlarmT = 0
		return
	end


	self.Turret_StandDown = false
	if (CurTime() > self.Turret_NextAlarmT) then
		self.Turret_NextAlarmT = CurTime() + 1
		sound.Play("npc/turret_floor/ping.wav", self:GetPos(), 75, 100)
	end

    local bone = target:LookupBone("ValveBiped.Bip01_Spine2")
    if not bone then return end
    local bonePos, boneAng = target:GetBonePosition(bone)
    local selfPos, selfAng = self:GetBonePosition(3)
    local off = bonePos - (pos)
	local sAng = self:GetAngles()
	local sFw = sAng:Forward()
	local sRt = sAng:Right()
	local sUp = sAng:Up()

	local rOff = off:Dot(sRt)
	local fOff = off:Dot(sFw)
	local yaw = -(math.atan2(rOff,fOff) * 180 / math.pi)
	if yaw < -75 or yaw > 75 then return end
	local uOff = off:Dot(sUp)
	local pitch = (math.atan2(uOff,(off - uOff * sUp):Length()) * 180 / math.pi)
	if (self:GetPoseParameter("aim_yaw") ~= yaw) then self:SetPoseParameter("aim_yaw", yaw) end
	if (self:GetPoseParameter("aim_pitch") ~= pitch) then self:SetPoseParameter("aim_pitch", pitch) end
	selfPos, selfAng = self:GetBonePosition(3)
	local shootPos = selfPos+selfAng:Up()*3+selfAng:Right()*-1.5+selfAng:Forward()*1.5
    if self.NextShot > CurTime() then return end
    self.NextShot = CurTime() + .1
    local bullets = {}
    bullets.Attacker = self.TurretOwner
    bullets.Damage = 5
    bullets.Force = bullets.Damage
    bullets.Num = 1
    bullets.Tracer = 1
	bullets.TracerName = "AR2Tracer"
    bullets.Spread = Vector(spreadcvar:GetFloat(), spreadcvar:GetFloat(), 0)
    bullets.Src = shootPos
	-- bullets.AmmoType = "AR2"
	local dirAng = (bonePos-shootPos)
	dirAng:Normalize()
	bullets.Dir = dirAng
	self:FireBullets(bullets)
    sound.Play("npc/turret_floor/shoot" .. math.random(1, 3) .. ".wav", self:GetPos(), 90, math.random(100, 110))
	local FireLight1 = ents.Create("light_dynamic")
	FireLight1:SetKeyValue("brightness", "4")
	FireLight1:SetKeyValue("distance", "120")
	FireLight1:SetPos(shootPos)
	FireLight1:SetLocalAngles(selfAng)
	FireLight1:Fire("Color", "225 31 31")
	FireLight1:SetParent(self)
	FireLight1:Spawn()
	FireLight1:Activate()
	FireLight1:Fire("TurnOn","",0)
	FireLight1:Fire("Kill","",0.07)
	self:DeleteOnRemove(FireLight1)

    self.TotalShots = self.TotalShots + 1

    if shotcvar:GetInt() ~= 0 and self.TotalShots >= shotcvar:GetInt() then
        local effectdata = EffectData()
        effectdata:SetStart(self:GetPos())
        effectdata:SetOrigin(effectdata:GetStart())
        util.Effect("HelicopterMegaBomb", effectdata)
        sound.Play("weapons/explode3.wav", self:GetPos(), 85, 115)
        self:Remove()
    end

    self:NextThink(CurTime() + thinking)

    return true
end

function ENT:OnRemove()
	self:StopSound("npc/turret_wall/turret_loop1.wav")
    if (self.turret_turningsd) then
		self.turret_turningsd:Stop()
	end
end