AddCSLuaFile()

SWEP.Author 				= "jmoak3"
SWEP.Contact 				= "mrjmoak3@gmail.com"
SWEP.Purpose 				= "BRAINS"
SWEP.Instructions 			= "BRAINS"
	
SWEP.Spawnable 				= false
SWEP.UseHands 				= false
SWEP.ViewModel				= "models/weapons/c_arms_citizen.mdl"
SWEP.WorldModel				= ""
SWEP.Base					= "weapon_tttbase"
--SWEP.Kind = WEAPON_EQUIP

SWEP.HoldType = "knife"
SWEP.Primary.ClipSize 		= -1
SWEP.Primary.DefaultClip	= -1
SWEP.DrawAmmo = true
SWEP.ViewModelFOV  = 70
SWEP.ViewModelFlip = true
SWEP.Primary.Automatic = false
SWEP.Damage = 10
SWEP.Category 				= "jmoak3"

SWEP.DrawCrosshair = false
SWEP.Primary.Ammo 			= ""

SWEP.CoolEffect = false

SWEP.Secondary.ClipSize 	= -1
SWEP.Secondary.DefaultClip	= -1
SWEP.Secondary.Automatic	= false
SWEP.Secondary.Ammo			= "none"
SWEP.AllowDrop = false
SWEP.ViewModelFlip = false
SWEP.PrintName 				= "Zombie Hands"
SWEP.Slot					= 6
SWEP.AutoSpawnable = false
SWEP.LimitedStock = true
SWEP.HitTime = 0.1
SWEP.CoolDown = 0.4
SWEP.IdleWait = 0.4

local testing = false

function SWEP:Initialize()
	self:SetWeaponHoldType(self.HoldType)
	--if (SERVER) then self.Owner:SetMaxSpeed(50) end
	self.CanFire = true
	
	self:NetworkVar("Float", 0, "NextMeleeAttack")
	self:NetworkVar("Float", 1, "CoolMeleeAttack")
	self:NetworkVar("Float", 2, "IdleTime")
	self:SetNextMeleeAttack(-1)
	self:SetIdleTime(-1)
	self:SetCoolMeleeAttack(-1)
	local dxlevel = GetConVarNumber("mat_dxlevel")
	if (dxlevel > 89) then self.CoolEffect = true end
end

function SWEP:Deploy()
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "fists_draw" ) )
	return true
end
function SWEP:Reload()

end

function SWEP:OnDrop()
	self:Remove()
end

function SWEP:Holster()
	return false
end

function SWEP:Think()
	if (SERVER && InfectConfig.FixZombieModels) then
		self.Owner:SetModel("models/player/zombie_classic.mdl")
	end
	
	if (InfectConfig.TouchInfect) then
		local attackableEnts = ents.FindInSphere(self.Owner:GetPos(), InfectConfig.TouchInfectRadius)
		if (attackableEnts != nil) then
			for _,i in pairs(attackableEnts) do
				if (i:IsPlayer() && i:Alive() && i != self.Owner && SERVER) then
					self:Infect(i)
				end
			end
		end
	end

	if (table.Count(self.Owner:GetWeapons()) > 1 && SERVER) then
		self.Owner:StripAll()
		self.Owner:Give("weapon_zombie")
		self.Owner:SelectWeapon("weapon_zombie")
		CustomMsg(self.Owner, "NOM", Color(255, 0, 0))
	end
	
	local nextMelee = self:GetNextMeleeAttack()
	local nextCool = self:GetCoolMeleeAttack()
	local nextIdle = self:GetIdleTime()
	
	if (nextMelee > 0 && CurTime() >= nextMelee && !(nextCool > 0)) then
		self:CutEmUp()
		self:SetCoolMeleeAttack(CurTime() + self.CoolDown)
	end
	
	if (nextCool > 0 && CurTime() >= nextCool && !(nextIdle > 0)) then
		self:Idle()
		self:SetIdleTime(CurTime() + self.IdleWait)
	end
	
	if (nextIdle > 0 && CurTime() >= nextIdle) then
		self:SetNextMeleeAttack(0)
		self:SetCoolMeleeAttack(0)
		self:SetIdleTime(0)
	end
end

function SWEP:CutEmUp()
	local trace = util.TraceLine( 
	{
		start = self.Owner:GetShootPos(),
		endpos = self.Owner:GetShootPos() + self.Owner:GetAimVector()*150,
		filter = self.Owner
	})
	local i = trace.Entity
	if (trace.HitNonWorld) then
		if ((i:IsPlayer() && i:Alive() && i:EntIndex() != self.Owner:EntIndex()) ||
					(i:GetClass() == "prop_physics" || i:GetClass() == "prop_physics_multiplayer" || i:GetClass() == "prop_dynamic")) then
			self:EmitSound("npc/zombie/claw_strike"..math.random(1,3)..".wav")
			
			if (SERVER) then 
				--if player deal damage normally
				if (i:IsPlayer()) then
					i:TakeDamage(self.Damage, self.Owner, self)
				end
				--if prop...
				if (i:GetClass() == "prop_physics" || i:GetClass() == "prop_physics_multiplayer" || i:GetClass() == "prop_dynamic") then
					timer.Create("DamageTimer"..math.random(1,999), 0, 1, 
					function() 
						if (i:IsValid()) then 
							i:TakeDamage(self.Damage, self.Owner, self)
						end
					end)
				end
				
				if (math.random(1, InfectConfig.InfectScratchChance ) == 1 && 
					i:IsPlayer() && i:GetActiveWeapon():IsValid() &&
						i:GetActiveWeapon():GetClass() != "weapon_zombie") then 
						self:Infect(i) 
				end
				if (i:IsPlayer()) then
					i:ViewPunch(Angle(math.random(-1, 1)*self.Damage, math.random(-1, 1)*self.Damage, math.random(-1, 1)*self.Damage))
				end
				if (i:GetClass() == "prop_physics" || i:GetClass() == "prop_physics_multiplayer" || i:GetClass() == "prop_dynamic") then
					local phys = i:GetPhysicsObject()
					if (phys != nil && phys != NULL && phys:IsValid()) then
						phys:ApplyForceCenter(self.Owner:GetAimVector():GetNormalized() * 20000)
					end
				end
			end
		end
	end
end

function SWEP:PrimaryAttack()
	local nextMelee = self:GetNextMeleeAttack()
	if (IsFirstTimePredicted() && !(nextMelee > 0)) then
		--self.Weapon:SendWeaponAnim(ACT_VM_HITCENTER)
		
		self.Owner:SetAnimation( PLAYER_ATTACK1 )
		
		local vm = self.Owner:GetViewModel()
		vm:ResetSequence( vm:LookupSequence( "fists_right" ) )

		--self.Owner:DoAnimationEvent(PLAYER_ATTACK1)
		
		self:EmitSound("npc/zombie/zombie_voice_idle"..math.random(1,2)..".wav")
		self:SetNextMeleeAttack(CurTime()+self.HitTime)	
	end
end

function SWEP:SecondaryAttack()
end

function SWEP:Precache()
	util.PrecacheSound("npc/zombie/zombie_voice_idle1.wav")
	util.PrecacheSound("npc/zombie/zombie_voice_idle2.wav")
    util.PrecacheSound("npc/zombie/claw_strike1.wav")
    util.PrecacheSound("npc/zombie/claw_strike2.wav")
    util.PrecacheSound("npc/zombie/claw_strike3.wav")
    util.PrecacheSound("npc/zombie/claw_miss1.wav")
    util.PrecacheSound("npc/zombie/claw_miss2.wav")
end

function SWEP:OnRemove()
end

function SWEP:DrawHUD()
	if (self.CoolEffect) then DrawMaterialOverlay( "models/shadertest/shader4", 0.05) end
end

function SWEP:Infect(plyr)
	if (plyr != nil && plyr != NULL && plyr != null && SERVER) then
		if (!InfectConfig.TInfect) then
			if (plyr:IsPlayer() && (plyr != self.Owner) && plyr:IsValid() &&
				plyr:GetActiveWeapon():IsValid() && plyr:Alive() && 
				plyr:GetActiveWeapon():GetClass() != "weapon_zombie" &&
				plyr:GetRole() != ROLE_TRAITOR) then
					if (!timer.Exists("InfectionTimer"..plyr:GetName().."")) then
						timer.Create("InfectionTimer"..plyr:GetName().."", math.random(InfectConfig.InfectTimeMin, InfectConfig.InfectTimeMax), 1, 
						function()
							if (plyr:GetActiveWeapon():IsValid() && plyr:Alive() &&
									plyr:GetActiveWeapon():GetClass() != "weapon_zombie" &&
										plyr:GetRole() != ROLE_TRAITOR) then
								if (InfectConfig.PZ) then
									local pos = plyr:GetPos()
									plyr:SetRole(ROLE_TRAITOR)
									plyr:Spawn()
									plyr:EmitSound("npc/zombie/zo_attack"..math.random(1,2)..".wav")
									plyr:SetModel("models/player/zombie_classic.mdl")
									plyr:SetPos(pos)
									timer.Create("GiveWepTimer"..math.random(1,999), 0, 2, 
									function() 
										if (plyr:IsValid()) then 
											plyr:StripAll()
											plyr:Give("weapon_zombie")
											plyr:SelectWeapon("weapon_zombie")
										end
									end)
									plyr:SetHealth(InfectConfig.Health)
									CustomMsg(plyr, "YOU ARE NOW A ZOMBIE!!", Color(255, 0, 0))
									SendFullStateUpdate()
								else
									local ent = ents.Create("npc_infectiouszombie")
									ent:SetPos(plyr:GetPos())
									ent:Spawn()
									ent:Activate()
									plyr:SetPos(plyr:GetPos()+ Vector(0,0,15))
									plyr:Kill()
								end
							end
							--player:takeDamage(
						end)
						
						if (InfectConfig.InfectMessage) then CustomMsg(plyr, "YOU HAVE BEEN INFECTED!!", Color(255, 0, 0)) end
					end
				if (InfectConfig.ScreenTick) then
					if (!timer.Exists("ShakeTimer"..plyr:GetName().."")) then
						CustomMsg(self.Owner, "THEY TASTE GOOD!!", Color(255, 0, 0))
						timer.Create("ShakeTimer"..plyr:GetName().."", InfectConfig.ScreenTickFreq, 0,
						function()
							plyr:ViewPunch(Angle(math.random(-1,1),math.random(-1,1),math.random(-1,1)))
						end)
					end
				end
			end
		else 
			if (plyr:IsPlayer() && (plyr != self.Owner) && plyr:IsValid() &&
				plyr:GetActiveWeapon():IsValid() && plyr:Alive() && 
				plyr:GetActiveWeapon():GetClass() != "weapon_zombie") then
					if (!timer.Exists("InfectionTimer"..plyr:GetName().."")) then
						timer.Create("InfectionTimer"..plyr:GetName().."", math.random(InfectConfig.InfectTimeMin, InfectConfig.InfectTimeMax), 1, 
						function()
							if (plyr:GetActiveWeapon():IsValid() && plyr:Alive() &&
									plyr:GetActiveWeapon():GetClass() != "weapon_zombie") then
								if (InfectConfig.PZ) then
									local pos = plyr:GetPos()
									plyr:SetRole(ROLE_TRAITOR)
									plyr:Spawn()
									plyr:EmitSound("npc/zombie/zo_attack"..math.random(1,2)..".wav")
									plyr:SetModel("models/player/zombie_classic.mdl")
									plyr:SetPos(pos)
									timer.Create("GiveWepTimer"..math.random(1,999), 0, 2, 
										function() 
											if (plyr:IsValid()) then 
												plyr:StripAll()
												plyr:Give("weapon_zombie")
												plyr:SelectWeapon("weapon_zombie")
											end
										end)
									plyr:SetHealth(InfectConfig.Health)
									CustomMsg(plyr, "YOU ARE NOW A ZOMBIE!!", Color(255, 0, 0))
									SendFullStateUpdate()
								else
									local ent = ents.Create("npc_infectiouszombie")
									ent:SetPos(plyr:GetPos())
									ent:Spawn()
									ent:Activate()
									plyr:SetPos(plyr:GetPos()+ Vector(0,0,15))
									plyr:Kill()
								end
							end
							--player:takeDamage(
						end)
						
						if (InfectConfig.InfectMessage) then CustomMsg(plyr, "YOU HAVE BEEN INFECTED!!", Color(255, 0, 0)) end
					end
				
				if (InfectConfig.ScreenTick) then
					if (!timer.Exists("ShakeTimer"..plyr:GetName().."")) then
						CustomMsg(self.Owner, "THEY TASTE GOOD!!", Color(255, 0, 0))
						timer.Create("ShakeTimer"..plyr:GetName().."", InfectConfig.ScreenTickFreq, 0,
						function()
							plyr:ViewPunch(Angle(math.random(-1,1),math.random(-1,1),math.random(-1,1)))
						end)
					end
				end
			end
		end		
	end
end

function SWEP:Idle()
	local vm = self.Owner:GetViewModel()
	vm:ResetSequence( vm:LookupSequence( "fists_idle_01") )
end

function StopTimers(plyr)
	if (timer.Exists("InfectionTimer"..plyr:GetName().."")) then
		timer.Destroy("InfectionTimer"..plyr:GetName().."")
	end
	
	if (timer.Exists("ShakeTimer"..plyr:GetName().."")) then
		timer.Destroy("ShakeTimer"..plyr:GetName().."")
	end
end
hook.Add("PlayerSpawn", "Stop Timers", StopTimers)

function CheckHeadshot(plyr, hitgroup, dmg)
	if (plyr:IsPlayer() && InfectConfig.HeadshotOnly && plyr:GetActiveWeapon():IsValid() &&
			plyr:GetActiveWeapon():GetClass() == "weapon_zombie") then
		if (hitgroup != HITGROUP_HEAD) then
			plyr:SetHealth(InfectConfig.Health)
			dmg = 0
		end
	end
end
hook.Add("ScalePlayerDamage", "CheckForPZombieHeadshot", CheckHeadshot)

function ZombiesCantUseWeapons(plyr, wep)
	if (plyr:IsPlayer() && plyr:GetActiveWeapon():IsValid() &&
			plyr:GetActiveWeapon():GetClass() == "weapon_zombie") then
		return false
	end
end
hook.Add("PlayerCanPickupWeapon", "ZombiesCantUseWeaponsCheck", ZombiesCantUseWeapons)


--function MuteZombies(plyr, bind, pressed)
--	if (InfectConfig.MuteZombies) then
--		 if (string.find(bind, "+voicerecord") && plyr:GetActiveWeapon():IsValid() &&
--				plyr:GetActiveWeapon():GetClass() == "weapon_zombie") then
--			  return false
--		 end
--	end
--end
--hook.Add("PlayerBindPress", "MutePlayerZombies", MuteZombies)

