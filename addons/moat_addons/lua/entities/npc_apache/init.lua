AddCSLuaFile("cl_init.lua")
AddCSLuaFile("shared.lua")
include('shared.lua')
--make snpc hurt you
--have bounding box move w/ model
--have it make nicenice w/ npc_soldier
ENT.Alerted = false
ENT.bleeds = 0
ENT.StartHealth = 650
ENT.PlayerFriendly = 0
ENT.AttackingMelee = false
ENT.State = 0 --1 is moving to enemy, 2 is staying put
ENT.BreathTime = 0
ENT.Enemy = NULL
ENT.BreathTime = 0
ENT.dead = false
ENT.DestAlt = 0
ENT.rocket_toggle = false
ENT.Controller = NULL
ENT.EyeAnglesLerp = Angle(0, 0, 0)
ENT.MaxAcceleration = 500
ENT.MaxSpeed = 500
ENT.RocketCoolDown = CurTime()
ENT.CanUltimate = true
ENT.RocketUltimateCoolDown = CurTime()

function ENT:Initialize()
    self:SetModel("models/usmcapachelicopter.mdl")
    self.Entity:PhysicsInit(SOLID_VPHYSICS) -- Make us work with physics,  	
    self.Entity:SetMoveType(MOVETYPE_VPHYSICS) --after all, gmod is a physics  	
    self.Entity:SetSolid(SOLID_VPHYSICS) -- Toolbox  
    self:CapabilitiesAdd(CAP_MOVE_FLY)
    self:SetHealth(self.StartHealth)
    self.Enemy = NULL
    --self:EmitSound("npc/attack_helicopter/aheli_rotor_loop1.wav",500,95);
    self.LoopSound = CreateSound(self, Sound("npc/attack_helicopter/aheli_rotor_loop1.wav"))
    self.LoopSound:PlayEx(1000, 100)
    self.EyeAnglesLerp = self:GetAngles()
    self.DestAlt = self:GetPos().z + 500
    local phys = self.Entity:GetPhysicsObject()

    if (phys:IsValid()) then
        phys:Wake()
        phys:EnableGravity(false)
    end
end

function ENT:OnTakeDamage(dmg)
    if (not dmg:IsBulletDamage()) then return end

    self:SetHealth(self:Health() - dmg:GetDamage())

    if (self.Controller) then
    	self.Controller:SetHealth(self:Health())
    end

    if self:Health() <= 0 and not self.dead then
        self.dead = true

        if (self.Controller) then
        	self.Controller:Kill()
        end

        self:KilledDan()
    end --run on death	
end

local velocity_speed = 1
local angle_additional = Angle(-20, 0, 0)
local angle_lerp = 20

function ENT:ControllerControls()
	local controller = self.Controller
	local phy = self:GetPhysicsObject()

    self.EyeAnglesLerp = LerpAngle(FrameTime() * angle_lerp, self.EyeAnglesLerp, controller:EyeAngles() + angle_additional)

    self:SetAngles(self.EyeAnglesLerp)

    if (not phy) then return end
    
    if (controller:KeyDown(IN_FORWARD)) then
    	phy:SetVelocity(phy:GetVelocity() + self.EyeAnglesLerp:Forward() * (600 * velocity_speed))
    	self:SetAngles(self.EyeAnglesLerp)
    end

    if (controller:KeyDown(IN_BACK)) then
    	phy:SetVelocity(phy:GetVelocity() + self.EyeAnglesLerp:Forward() * (-300 * velocity_speed))
    end

    if (controller:KeyDown(IN_MOVELEFT)) then
    	phy:AddVelocity(self:GetRight() * (-200 * velocity_speed))
    end

    if (controller:KeyDown(IN_MOVERIGHT)) then
    	phy:AddVelocity(self:GetRight() * (200 * velocity_speed))
    end

    if (controller:KeyDown(IN_JUMP)) then
    	phy:AddVelocity(Angle(0, 90, 0):Up() * (300 * velocity_speed))
    end

    if (controller:KeyDown(IN_DUCK)) then
    	phy:AddVelocity(Angle(0, 90, 0):Up() * -(300 * velocity_speed))
    end

    if (controller:KeyDown(IN_ATTACK)) then
    	local wantedvector = self.Controller:GetAimVector()
	    local shoot_vector = wantedvector
        local bullet = {}
        bullet.Num = 4
        bullet.Src = self:GetPos() + self:GetForward() * 150
        bullet.Damage = 20
        bullet.Force = 200
        bullet.Tracer = 1
        bullet.Spread = Vector(0.01, 0.01, 0)
        bullet.Dir = shoot_vector
        bullet.Callback = function(ent, tr, dmg)
        	util.ScreenShake(tr.HitPos, 5, 5, 0.2, 1000)
        end
        self:FireBullets(bullet)
        self:EmitSound("apache/fire.wav", 500, 100, 1)
    end

    if (controller:KeyDown(IN_ATTACK2) and not controller:KeyDown(IN_SPEED) and self.RocketCoolDown <= CurTime()) then
        local shoot_vector = self.Controller:GetAimVector()
        
        local rocket = ents.Create("proj_dan_heli_shot")

        if self.rocket_toggle then
            rocket:SetPos(self:LocalToWorld(Vector(150, 40, -20)))
            self.rocket_toggle = false
        else
            rocket:SetPos(self:LocalToWorld(Vector(150, -40, -20)))
            self.rocket_toggle = true
        end

        rocket:SetAngles(shoot_vector:Angle())
        rocket:Activate()
        rocket:Spawn()
        local phy = rocket:GetPhysicsObject()

        if phy:IsValid() then
            phy:ApplyForceCenter((shoot_vector * 7500))
        end

        self.RocketCoolDown = CurTime() + 2
    end

    if (controller:KeyDown(IN_ATTACK2) and controller:KeyDown(IN_SPEED) and self.CanUltimate and self.RocketUltimateCoolDown <= CurTime()) then
        for i = 1, 15 do
        	timer.Simple(0.15 * i, function()
        		local shoot_vector = self.Controller:GetAimVector()
        		local rocket = ents.Create("proj_dan_heli_shot")

       			if self.rocket_toggle then
            		rocket:SetPos(self:LocalToWorld(Vector(150, 40, -20)))
            		self.rocket_toggle = false
        		else
            		rocket:SetPos(self:LocalToWorld(Vector(150, -40, -20)))
            		self.rocket_toggle = true
        		end

        		rocket:SetAngles(shoot_vector:Angle())
        		rocket:Activate()
        		rocket:Spawn()
        		local phy = rocket:GetPhysicsObject()

        		if phy:IsValid() then
            		phy:ApplyForceCenter((shoot_vector * 7500))
        		end
        	end)
        end

        self.RocketUltimateCoolDown = CurTime() + 10
    end

    self.Controller:SetPos(self:GetPos() + Vector(0, 0, 100))
end

function ENT:Think()
    if CurTime() > self.BreathTime then
        --self.EmitSound(self,"vehicles/Crane/crane_turn_loop2.wav",420,100)
        self.BreathTime = CurTime() + 2
    end

    if (SERVER and self.Controller ~= NULL) then
    	self:ControllerControls()
    end

    if (self:Health() > 0 and self.Controller ~= NULL) then

        --set fixed angles
        local phy = self:GetPhysicsObject()

        if phy:IsValid() then
            --local velocity = phy:GetVelocity()
            --phy:SetVelocity(velocity)
        end

        if self.DestAlt + 100 > self:GetPos().z then
            local phy = self:GetPhysicsObject()

            if phy:IsValid() then
                phy:ApplyForceCenter((Vector(0.15, 0, 1) * 5000))
            end
        elseif self.DestAlt + 100 < self:GetPos().z then
            local phy = self:GetPhysicsObject()

            if phy:IsValid() then
                phy:ApplyForceCenter((Vector(0.15, 0, -1) * 5000))
            end
        end
    end
end

function ENT:Touch(ent)
    if ent:GetClass() == "npc_grenade_rocket" then
        self:TakeDamage(200, ent)

        return
    end

    if self.State == 0 then
        ent:TakeDamage(100, self)
    end
end

function ENT:GetAngleDiff(angle1, angle2)
    local result = angle1 - angle2

    if result < -180 then
        result = result + 360
    end

    if result > 180 then
        result = result - 360
    end

    return result
end

function ENT:SelectSchedule()
    if self.Enemy:IsValid() == false then
        self.Enemy = NULL
    elseif self.Enemy:Health(health) <= 0 then
        self.Enemy = NULL
    end

    if self:Health() > 0 then
        local haslos = self:HasLOS()
        local distance = 0
        local enemy_pos = 0

        if self.Enemy:IsValid() == false then
            self.Enemy = NULL
        elseif self.Enemy:Health(health) <= 0 then
            self.Enemy = NULL
        elseif self.Enemy == self then
            self.Enemy = NULL
        end

        if self.Enemy == NULL then
            --print( "No Enemy!" );
            --play idle sounds every now and then
            --print( "Enemy!" );
            --print(self.Enemy)
            --distance = 4000
            -- too far away
            --move to him
            --if in reasonable distance
            --stay put
            --if too close 
            --stay put
        else
            enemy_pos = self.Enemy:GetPos()
            distance = self:GetPos():Distance(enemy_pos)

            if distance > 2300 then
                self.State = 0
            elseif distance < 2300 and distance > 380 then
                self.State = 1
            else
                self.State = 1
            end
        end --no enemy
    end
end

function ENT:StopHurtSounds()
end

function ENT:KilledDan()
    --create ragdoll
    local ragdoll = ents.Create("prop_physics")
    ragdoll:SetModel("models/apgb/helicopter_brokenpiece_06_body.mdl")
    ragdoll:SetPos(self:GetPos())
    ragdoll:SetAngles(self:GetAngles())
    ragdoll:Spawn()
    ragdoll:SetSkin(self:GetSkin())
    ragdoll:SetColor(self:GetColor())
    ragdoll:SetMaterial(self:GetMaterial())
    undo.AddEntity(ragdoll)
    local ragdoll = ents.Create("prop_physics")
    ragdoll:SetModel("models/apgb/helicopter_brokenpiece_04_cockpit.mdl")
    ragdoll:SetPos(self:LocalToWorld(Vector(100, 0, 0)))
    ragdoll:SetAngles(self:GetAngles())
    ragdoll:Spawn()
    ragdoll:SetSkin(self:GetSkin())
    ragdoll:SetColor(self:GetColor())
    ragdoll:SetMaterial(self:GetMaterial())
    undo.AddEntity(ragdoll)
    local ragdoll = ents.Create("prop_physics")
    ragdoll:SetModel("models/apgb/helicopter_brokenpiece_05_tailfan.mdl")
    ragdoll:SetPos(self:LocalToWorld(Vector(-100, 0, 0)))
    ragdoll:SetAngles(self:GetAngles())
    ragdoll:Spawn()
    ragdoll:SetSkin(self:GetSkin())
    ragdoll:SetColor(self:GetColor())
    ragdoll:SetMaterial(self:GetMaterial())
    --my code
    undo.AddEntity(ragdoll)
    cleanup.ReplaceEntity(self, ragdoll)

    --ignight ragdoll if on fire.
    if self:IsOnFire() then
        ragdoll:Ignite(math.Rand(8, 10), 0)
    end

    --position bones the same way.
    for i = 1, 128 do
        local bone = ragdoll:GetPhysicsObjectNum(i)
    end

    --kill our turrent
    local bar = ents.Create("env_shake")
    bar:SetPos(self:GetPos())
    bar:SetKeyValue("amplitude", "8")
    bar:SetKeyValue("radius", "4000")
    bar:SetKeyValue("duration", "0.75")
    bar:SetKeyValue("frequency", "128")
    bar:Fire("StartShake", 0, 0)
    --kill our turrent
    --self.myturrent:KilledDan()
    local blargity = EffectData()
    blargity:SetStart(self:GetPos())
    blargity:SetOrigin(self:GetPos())
    blargity:SetScale(500)
    self.LoopSound:Stop()
    util.Effect("HelicopterMegaBomb", blargity)
    util.Effect("ThumperDust", blargity)
    self:StopSound("npc/attack_helicopter/aheli_rotor_loop1.wav")
    self:Remove()
end

function ENT:OnRemove()
    self:StopSound("npc/attack_helicopter/aheli_rotor_loop1.wav")
    self.LoopSound:Stop()
end

function ENT:HasLOS()
    if self.Enemy ~= NULL then
        --local shootpos = self:GetAimVector()*(self:GetPos():Distance(self.Enemy:GetPos())) + self:GetPos()
        --local shootpos = self.Enemy:GetPos()
        local tracedata = {}
        tracedata.start = self:GetPos()
        tracedata.endpos = self.Enemy:GetPos()
        tracedata.filter = self
        local trace = util.TraceLine(tracedata)

        if trace.HitWorld == false then
            return true
        else
            return false
        end
    end

    return false
end