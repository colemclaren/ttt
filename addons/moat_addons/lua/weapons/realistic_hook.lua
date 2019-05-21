// A more realistic grappling hook

if SERVER then
	AddCSLuaFile()
	util.AddNetworkString( "realistic_hook BreakFree" )
end

SWEP.Base = "weapon_base"

SWEP.PrintName = "Grappling Hook"
SWEP.Category = "_Hat's Weapons"
SWEP.Author = "my_hat_stinks"
SWEP.Instructions = "Fire to launch the hook"

SWEP.Spawnable = true
SWEP.AdminOnly = true
SWEP.AdminSpawnable = true

SWEP.Slot = 3
SWEP.SlotPos = 1

SWEP.ViewModelFOV = 80
SWEP.Weight = 5
SWEP.AutoSwitchTo = false
SWEP.AutoSwitchFrom = false
SWEP.ViewModelFlip   = false

SWEP.WorldModel = "models/weapons/w_alyx_gun.mdl"
SWEP.ViewModel = "models/weapons/c_pistol.mdl"
SWEP.UseHands = true
SWEP.CanDrop = true

SWEP.Primary.Recoil = 1
SWEP.Primary.Damage = 5
SWEP.Primary.NumShots = 1
SWEP.Primary.Cone = 0
SWEP.Primary.Delay = 0.05

SWEP.Primary.ClipSize = -1
SWEP.Primary.DefaultClip = -1
SWEP.Primary.Automatic = true
SWEP.Primary.Ammo = "none"
SWEP.Primary.ClipMax = -1

SWEP.Secondary.ClipSize = -1
SWEP.Secondary.DefaultClip = -1
SWEP.Secondary.Automatic = true
SWEP.Secondary.Ammo = "none"
SWEP.Secondary.ClipMax = -1
SWEP.Secondary.Delay = 0.5

SWEP.DeploySpeed = 1.5

SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK
SWEP.ReloadAnim = ACT_VM_RELOAD
SWEP.HoldType = "pistol"

---- For TTT
SWEP.Kind = WEAPON_EQUIP
SWEP.AutoSpawnable      = false
SWEP.AmmoEnt = "none"
SWEP.NoSights = true
SWEP.EquipMenuData = {
	type = "item_weapon",
	desc = "A grappling hook.\n\nScale walls or grab things from afar."
};

SWEP.Icon = "entities/realistic_hook"
----

--Standard swep functions--
---------------------------
function SWEP:SetupDataTables()
	self:NetworkVar( "Entity", 1, "Hook" )
	
	self:NetworkVar( "Int", 1, "Cooldown" )
end

function SWEP:Initialize()
	hook.Add( "SetupMove", self, self.PlayerMove )
	--hook.Add( "Tick", self, self.Tick )
	
	if CLIENT then
		self.VElements = table.FullCopy( self.VElements )
		self:CreateModels(self.VElements) // create viewmodels
		
		hook.Add( "PostDrawOpaqueRenderables", self, self.VMDraw )
	end
	
	if SERVER then
		local timerName = tostring(self).." Hook Broken Cooldown"
		timer.Create( timerName, 0.1, 0, function()
			if not IsValid(self) then timer.Destroy(timerName) return end
			self:SetCooldown( math.Approach(self:GetCooldown(), 0, 2) )
		end)
	end
	
	return self.BaseClass.Initialize( self )
end
function SWEP:PrimaryAttack()
	if self:GetCooldown()>0 then return end
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	
	if CLIENT and (not IsFirstTimePredicted()) then return end
	
	if IsValid( self:GetHook() ) then
		local hk = self:GetHook()
		if not (hk.GetHasHit and hk:GetHasHit()) then return end
		
		if SERVER then hk:SetDist( math.Approach( hk:GetDist(), 0, 10 ) ) end
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	elseif SERVER then
		self:LaunchHook()
	end
end
function SWEP:SecondaryAttack()
	if self:GetCooldown()>0 then return end
	
	self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
	self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	
	if IsValid( self:GetHook() ) then
		local hk = self:GetHook()
		if not (hk.GetHasHit and hk:GetHasHit()) then return end
		
		if SERVER then hk:SetDist( hk:GetDist() + 10 ) end
		self:SetNextPrimaryFire( CurTime() + self.Primary.Delay )
		self:SetNextSecondaryFire( CurTime() + self.Primary.Delay )
	elseif SERVER then
		self:LaunchHook()
	end
end
function SWEP:Reload()
	if SERVER and IsValid(self:GetHook()) then
		if self:GetHook():GetDurability()>0 then
			self:SetCooldown( self:GetHook():GetDurability()+20 )
		else
			self:SetCooldown(10)
		end
		self:GetHook():Remove()
	end
end

-- Handling the hook entity --
------------------------------
function SWEP:LaunchHook()
	if not cvars.Bool( "hatshook_physics" ) then return self:LaunchInstant() end
	if not IsValid( self.Owner ) then return end
	
	//self:EmitSound( "physics/metal/metal_box_impact_bullet"..math.random(1,3)..".wav" )
	sound.Play( "physics/metal/metal_canister_impact_soft"..math.random(1,3)..".wav", self.Owner:GetShootPos(), 75, 100, 0.5 )
	self.Owner:ViewPunch( Angle( math.Rand(-5,-2.5), math.Rand(-2,2), 0 ) )
	
	local hk = ents.Create( "ent_realistic_hook" )
	if not IsValid(hk) then return end // Shouldn't happen
	hk:SetPos( self.Owner:GetShootPos() - self.Owner:GetAimVector()*10 )
	local ang = self.Owner:EyeAngles()
	ang:RotateAroundAxis( ang:Up(), 90 )
	hk:SetAngles( ang )
	hk.FireVelocity = self.Owner:GetAimVector() * 500
	hk:SetOwner( self.Owner )
	hk:Spawn()
	
	self:SetHook( hk )
	hk:SetWep( self )
end

function SWEP:GetFilter()
	return cvars.Bool( "hatshook_hookplayers" ) and {self.Owner} or player.GetAll()
end
function SWEP:LaunchInstant()
	if not IsValid( self.Owner ) then return end
	
	local tr = util.TraceLine({
		start=self.Owner:GetShootPos(),
		endpos=self.Owner:GetShootPos()+(self.Owner:GetAimVector()*cvars.Number("hatshook_speed")),
		filter=self:GetFilter()
	})
	if tr.HitSky or not tr.Hit then return end
	
	sound.Play( "physics/metal/metal_canister_impact_soft"..math.random(1,3)..".wav", self.Owner:GetShootPos(), 75, 100, 0.5 )
	self.Owner:ViewPunch( Angle( math.Rand(-10,-5), math.Rand(-4,4), 0 ) )
	
	local hk = ents.Create( "ent_realistic_hook" )
	if not IsValid(hk) then return end // Shouldn't happen
	hk:SetPos( tr.HitPos )
	hk:SetAngles( tr.Normal:Angle() )
	hk.FireVelocity = Vector(0,0,0)
	hk:SetOwner( self.Owner )
	hk:Spawn()
	
	self:SetHook( hk )
	hk:SetWep( self )
	
	hk:PhysicsCollide( {HitEntity=tr.Entity, HitPos=tr.HitPos, HitNormal=tr.Normal} )
end

local HookCable = Material( "cable/cable2" )
function SWEP:DrawRope( attPos )
	if not attPos then return end
	
	
	local hk = self:GetHook()
	if not IsValid(hk) then return end
	
	if self.Owner~=LocalPlayer() or hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self.Owner) then return hk:Draw() end
	
	if IsValid( hk:GetTargetEnt() ) then
		if (not hk:GetFollowBone()) then return end
		local bpos, bang = hk:GetTargetEnt():GetBonePosition( hk:GetFollowBone() )
		local npos, nang = hk:GetFollowOffset(), hk:GetFollowAngle()
		if npos and nang and bpos and bang then
			npos:Rotate( nang )
			nang = nang+bang
			
			npos = bpos+npos
			
			hk:SetPos( npos )
			hk:SetAngles( nang )
		end
	end
	
	render.SetMaterial( HookCable )
	render.DrawBeam( hk:GetPos(), attPos, 1, 0, 2, Color(255,255,255,255) )
end
function SWEP:DrawWorldModel()
	self:DrawModel()
	local att = self:GetAttachment( 1 )
	if (not att) then return end
	self:DrawRope( att.Pos )
end
function SWEP:VMDraw()
	if not (self.Owner==LocalPlayer() and self.Owner:GetActiveWeapon()==self and hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self.Owner)~=false) then return end
	
	local vm = IsValid( self.Owner ) and self.Owner:GetViewModel()
	local pos = self:GetPos()
	if IsValid(vm) and vm:GetAttachment( 1 ) then pos = vm:GetAttachment( 1 ).Pos end
	
	self:DrawRope( pos )
end

-- HUD Stuff --
---------------
local function ShadowText( txt, x, y )
	draw.DrawText( txt, "Default", x+1, y+1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.DrawText( txt, "Default", x, y, Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
end
local ChargeBarCol = { White = Color(255,255,255), DefCol1 = Color(255,50,50), DefCol2 = Color(50,255,50) }
local Gradient = Material( "gui/gradient" )
local function DrawChargeBar( xpos, ypos, width, height, charge, col1, col2 )
	draw.NoTexture()
	
	surface.SetDrawColor( ChargeBarCol.White )
	surface.DrawOutlinedRect( xpos, ypos, width, height )
	
	charge = math.Clamp( charge or 50, 0, 100)
	barLen = (width-2)*(charge/100)
	render.SetScissorRect( xpos+1, ypos+1, xpos+1+barLen, (ypos+height)-1, true )
		surface.SetDrawColor( col2 or ChargeBarCol.DefCol2 )
		surface.DrawRect( xpos+1, ypos+1, width-1, height-2 )
		
		surface.SetMaterial( Gradient )
		surface.SetDrawColor( col1 or ChargeBarCol.DefCol1 )
		surface.DrawTexturedRect( xpos+1, ypos+1, width-1, height-2 )
	render.SetScissorRect( xpos+1, ypos+1, xpos+1+barLen, (ypos+height)-1, false )
	
	draw.NoTexture()
end
function SWEP:DrawHUD()
	if IsValid( self:GetHook() ) and self:GetHook():GetHasHit() then
		ShadowText( "Rope length: "..tostring(self:GetHook():GetDist()), ScrW()/2, ScrH()/2+40 )
		ShadowText( (input.LookupBinding("+attack") or "[PRIMARY FIRE]"):upper() .. " - Retract rope", ScrW()/2, ScrH()/2+70 )
		ShadowText( (input.LookupBinding("+attack2") or "[SECONDARY FIRE]"):upper() .. " - Extend rope", ScrW()/2, ScrH()/2+85 )
		ShadowText( (input.LookupBinding("+reload") or "[RELOAD]"):upper() .. " - Break rope", ScrW()/2, ScrH()/2+100 )
		
		if IsValid( self:GetHook():GetTargetEnt() ) and self:GetHook():GetTargetEnt():IsPlayer() then
			DrawChargeBar( (ScrW()/2)-70, (ScrH()/2)+20, 140, 15, self:GetHook():GetDurability() )
		else
			ShadowText( (input.LookupBinding("+use") or "[USE]"):upper() .. " - Jump off", ScrW()/2, ScrH()/2+115 )
		end
	elseif self:GetCooldown()>0 then
		DrawChargeBar( (ScrW()/2)-70, (ScrH()/2)+20, 140, 15, self:GetCooldown() )
	end
	
	return self.BaseClass.DrawHUD( self ) // TTT Crosshair is drawn here, we have to call it
end

-- Movement Handling --
-----------------------
local function ValidPullEnt(ent)
	if (not IsValid(ent)) or ent:IsPlayer() then return false end
	local phys = ent:GetPhysicsObject()
	
	return (not IsValid(phys)) or ((not phys:HasGameFlag(FVPHYSICS_NO_PLAYER_PICKUP)) and (phys:GetMass()<=50) and (ent.CanPickup!=false) and phys:IsMotionEnabled())
end

function SWEP:PlayerMove( ply, mv, cmd )
	if not (IsValid(self:GetHook()) and self:GetHook().GetHasHit and self:GetHook():GetHasHit()) then return end
	if not (IsValid(self.Owner) and IsValid(ply) and self.Owner:Alive() and ply:Alive()) then return end
	
	local hk = self:GetHook()
	
	if (IsValid(hk:GetTargetEnt()) and hk:GetTargetEnt()~=self and ply~=hk:GetTargetEnt() and (hk:GetTargetEnt():IsPlayer() or ValidPullEnt(hk:GetTargetEnt()))) then return end
	if (hk:GetTargetEnt()==hk or (not (ValidPullEnt(hk:GetTargetEnt()) or hk:GetTargetEnt():IsPlayer()))) and ply~=self.Owner then return end
	
	if (not (ply.InVehicle and self.Owner.InVehicle)) and SERVER then hk:Remove() self:SetCooldown(10) return end // What
	if (ply:InVehicle() or self.Owner:InVehicle() or (not ply:Alive())) and SERVER then hk:Remove() self:SetCooldown(10) return end
	
	if ply~=self.Owner then
		ply.was_pushed = {t=CurTime(),att=self.Owner}
	end
	
	if ply:KeyPressed( IN_USE ) and ply==self.Owner then
		if hk:GetPos()[3] > ply:GetShootPos()[3] then
			mv:SetVelocity( mv:GetVelocity() + Vector(0,0,300) )
		end
		
		if SERVER then self:SetCooldown(10) hk:Remove() end
	end
	
	local TargetPoint = hk:GetPos()
	local ApproachDir = (TargetPoint-ply:GetPos()):GetNormal()
	local ShootPos = self.Owner:GetShootPos() + (Vector(0,0, (self.Owner:Crouching() and 0) or (hk:GetUp()[1]>0.9 and -45) or 0))
	local Distance = hk:GetDist()
	
	if ply~=self.Owner then // Swap direction
		TargetPoint = ShootPos
		ShootPos = ply:GetShootPos() + (Vector(0,0, (ply:Crouching() and 0) or (hk:GetUp()[1]>0.9 and -45) or 0))
		ApproachDir = (TargetPoint-ply:GetPos()):GetNormal()
	end
	
	local DistFromTarget = ShootPos:Distance( TargetPoint )
	if DistFromTarget<(Distance+5) then return end // 5 units off actual distance
	local TargetPos = TargetPoint - (ApproachDir*Distance)
	
	local xDif = math.abs(ShootPos[1] - TargetPos[1])
	local yDif = math.abs(ShootPos[2] - TargetPos[2])
	local zDif = math.abs(ShootPos[3] - TargetPos[3])
	
	--local speedMult = ((DistFromTarget*0.01)^1.1)
	local speedMult = 3+ ( (xDif + yDif)*0.5)^1.01
	local vertMult = math.max((math.Max(300-(xDif + yDif), -10)*0.08)^1.01  + (zDif/2),0)
	if ply~=self.Owner and self.Owner:GetGroundEntity()==ply then vertMult = -vertMult end
	
	local TargetVel = (TargetPos - ShootPos):GetNormal() * 10
	TargetVel[1] = TargetVel[1]*speedMult
	TargetVel[2] = TargetVel[2]*speedMult
	TargetVel[3] = TargetVel[3]*vertMult
	local dir = mv:GetVelocity()
	
	local clamp = 50
	local vclamp = 20
	local accel = 200
	local vaccel = 30*(vertMult/50)
	
	dir[1] = (dir[1]>TargetVel[1]-clamp or dir[1]<TargetVel[1]+clamp) and math.Approach(dir[1], TargetVel[1], accel) or dir[1]
	dir[2] = (dir[2]>TargetVel[2]-clamp or dir[2]<TargetVel[2]+clamp) and math.Approach(dir[2], TargetVel[2], accel) or dir[2]
	
	if ShootPos[3]<TargetPos[3] then
		dir[3] = (dir[3]>TargetVel[3]-vclamp or dir[3]<TargetVel[3]+vclamp) and math.Approach(dir[3], TargetVel[3], vaccel) or dir[3]
		
		if vertMult>0 then self.ForceJump=ply end
	end
	
	mv:SetVelocity( dir )
	//return mv
end

local function ForceJump( ply )
	if not (IsValid(ply) and ply:IsPlayer()) then return end
	if not ply:OnGround() then return end
	
	local tr = util.TraceLine( {start = ply:GetPos(), endpos = ply:GetPos()+Vector(0,0,20), filter = ply} )
	if tr.Hit then return end
	
	ply:SetPos(ply:GetPos()+Vector(0,0,5) )
end
function SWEP:Think()
	if self.ForceJump then
		if IsValid(self.Owner) and self.ForceJump==self.Owner then
			ForceJump( self.Owner )
		elseif IsValid( self:GetHook() ) and IsValid( self:GetHook():GetTargetEnt() ) and self.ForceJump == self:GetHook():GetTargetEnt() then
			ForceJump( self.ForceJump )
		end
		self.ForceJump = nil
	end
	if SERVER then self:EntityPull() end
end

function SWEP:EntityPull() // For pulling entities
	local hk = self:GetHook()
	if IsValid(self.Owner) and IsValid(hk) and hk.GetTargetEnt and IsValid(hk:GetTargetEnt()) and ValidPullEnt(hk:GetTargetEnt()) then
		local ply = hk:GetTargetEnt()
		local phys = ply:GetPhysicsObject()
		if ply:IsPlayer() or (not IsValid(phys)) then return end
		
		local TargetPoint = self.Owner:GetShootPos()
		local ShootPos = ply:GetPos()
		local ApproachDir = (TargetPoint-ply:GetPos()):GetNormal()
		local Distance = hk:GetDist()
		
		local DistFromTarget = ShootPos:Distance( TargetPoint )
		if DistFromTarget<(Distance+5) then return end
		local TargetPos = TargetPoint - (ApproachDir*Distance)
		
		local xDif = math.abs(ShootPos[1] - TargetPos[1])
		local yDif = math.abs(ShootPos[2] - TargetPos[2])
		local zDif = math.abs(ShootPos[3] - TargetPos[3])
		
		--local speedMult = ((DistFromTarget*0.01)^1.1)
		local speedMult = 3+ ( (xDif + yDif)*0.5)^1.01
		local vertMult = math.max((math.Max(100-(xDif + yDif), -10)*0.1)^1.01  + (zDif/2), 0)
		if self.Owner:GetGroundEntity()==ply then vertMult = -vertMult end
		
		local TargetVel = (TargetPos - ShootPos):GetNormal() * 6 * (1 - (phys:GetMass()/50))
		TargetVel[1] = TargetVel[1]*speedMult
		TargetVel[2] = TargetVel[2]*speedMult
		TargetVel[3] = TargetVel[3]*vertMult
		local dir = ply:GetVelocity()
		
		local clamp = 50
		local vclamp = 20
		local accel = 200
		local vaccel = 40*(vertMult/50)
		
		dir[1] = (dir[1]>TargetVel[1]-clamp or dir[1]<TargetVel[1]+clamp) and math.Approach(dir[1], TargetVel[1], accel) or dir[1]
		dir[2] = (dir[2]>TargetVel[2]-clamp or dir[2]<TargetVel[2]+clamp) and math.Approach(dir[2], TargetVel[2], accel) or dir[2]
		
		if ShootPos[3]<TargetPos[3] and vertMult~=0 then
			dir[3] = (dir[3]>TargetVel[3]-vclamp or dir[3]<TargetVel[3]+vclamp) and math.Approach(dir[3], TargetVel[3], vaccel) or dir[3]
		end
		
		phys:SetVelocity( dir )
	end
end


SWEP.VElements = {
	["gun"] = { type = "Model", model = "models/weapons/w_alyx_gun.mdl", bone = "ValveBiped.square", rel = "", pos = Vector(1.1, -1.1, -1.4), angle = Angle(-100, 146, 68), size = Vector(1,1,1), color = Color(255, 255, 255, 255) }
}
-- SWEP Construction Kit code by Clavus, removed everything I don't need. http://facepunch.com/threads/1032378 --
-----------------------------------------------------------------------------------------------------------------
function SWEP:ViewModelDrawn()
	if not IsValid( self.Owner ) then return end
	local vm = self.Owner:GetViewModel()
	if !IsValid(vm) then return end
	
	if (!self.VElements) then return end
	for k, v in pairs( self.VElements ) do
		if not file.Exists( v.model, "GAME" ) then continue end
		local model = v.modelEnt
		
		if (!v.bone) then continue end
		
		local pos, ang = self:GetBoneOrientation( self.VElements, v, vm )
		if (!pos) then continue end
		
		if IsValid(model) then
			model:SetPos(pos + ang:Forward() * v.pos.x + ang:Right() * v.pos.y + ang:Up() * v.pos.z )
			ang:RotateAroundAxis(ang:Up(), v.angle.y)
			ang:RotateAroundAxis(ang:Right(), v.angle.p)
			ang:RotateAroundAxis(ang:Forward(), v.angle.r)
			model:SetAngles(ang)
			local matrix = Matrix()
			matrix:Scale(v.size)
			model:EnableMatrix( "RenderMultiply", matrix )
			
			model:SetMaterial("")
			
			render.SetColorModulation(v.color.r/255, v.color.g/255, v.color.b/255)
			render.SetBlend(v.color.a/255)
			model:DrawModel()
			render.SetBlend(1)
			render.SetColorModulation(1, 1, 1)
		end
	end
end

function SWEP:GetBoneOrientation( basetab, tab, ent, bone_override )
	local bone, pos, ang
	bone = ent:LookupBone(bone_override or tab.bone)
	
	if (!bone) then return end
	
	pos, ang = Vector(0,0,0), Angle(0,0,0)
	local m = ent:GetBoneMatrix(bone)
	if (m) then pos, ang = m:GetTranslation(), m:GetAngles() end
	
	if (IsValid(self.Owner) and self.Owner:IsPlayer() and ent == self.Owner:GetViewModel() and self.ViewModelFlip) then
		ang.r = -ang.r // Fixes mirrored models
	end
	
	return pos, ang
end

function SWEP:CreateModels( tab )
	if (!tab) then return end
	for k, v in pairs( tab ) do
		if (v.type == "Model" and v.model and v.model != "" and (!IsValid(v.modelEnt) or v.createdModel != v.model) and  string.find(v.model, ".mdl") and file.Exists (v.model, "GAME") ) then
			v.modelEnt = ClientsideModel(v.model, RENDER_GROUP_VIEW_MODEL_OPAQUE)
			if (IsValid(v.modelEnt)) then
				v.modelEnt:SetPos(self:GetPos())
				v.modelEnt:SetAngles(self:GetAngles())
				v.modelEnt:SetParent(self)
				v.modelEnt:SetNoDraw(true)
				v.createdModel = v.model
			else
				v.modelEnt = nil
			end
		end
	end
end

function SWEP:RemoveModels(tab)
    if (!tab) then return end
    for k, v in pairs( tab ) do
        if (IsValid(v.modelEnt)) then
            v.modelEnt:Remove()
            v.modelEnt = nil
        end
    end
end

function SWEP:OnRemove()
	if (CLIENT) then
    	self:RemoveModels(self.VElements)
    	self:RemoveModels(self.WElements)
    end
end

function table.FullCopy( tab )
	if (!tab) then return nil end
	local res = {}
	for k, v in pairs( tab ) do
		if (type(v) == "table") then res[k] = table.FullCopy(v)
		elseif (type(v) == "Vector") then res[k] = Vector(v.x, v.y, v.z)
		elseif (type(v) == "Angle") then res[k] = Angle(v.p, v.y, v.r)
		else res[k] = v end
	end
	return res
end

// Make a TTT Swep from what we've got
local TTTSwep = table.Copy( SWEP ) // It's the same as the normal swep, copy over the table
TTTSwep.Base = "weapon_tttbase" // Using TTT weapon base
TTTSwep.Slot = 6 // Put it in the proper slot

TTTSwep.Spawnable = false // Make the TTT version hidden, so people don't accidentally spawn it
TTTSwep.AdminOnly = false
TTTSwep.AdminSpawnable = false

TTTSwep.CanBuy = {ROLE_TRAITOR, ROLE_DETECTIVE} // Make it buyable
weapons.Register( TTTSwep, "ttt_realistic_hook" ) // Register the new weapon
