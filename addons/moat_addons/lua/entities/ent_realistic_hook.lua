AddCSLuaFile()

ENT.Type = "anim"

ENT.Spawnable = false
ENT.AdminSpawnable = true

ENT.Model = "models/props_c17/TrapPropeller_Lever.mdl"
ENT.HitSound = Sound( "physics/metal/metal_barrel_impact_hard7.wav" )

local ServerConvarFlags = {FCVAR_ARCHIVE, FCVAR_REPLICATED, FCVAR_SERVER_CAN_EXECUTE}
CreateConVar( "hatshook_hookplayers", "1", ServerConvarFlags, "Allows the Grappling Hook to grab players" )
CreateConVar( "hatshook_physics", "1", ServerConvarFlags, "Grappling hook is launched as a projectile" )
CreateConVar( "hatshook_speed", "1000", ServerConvarFlags, "Launch velocity of the grappling hook (Max range for non-physics hooks)" )

CreateConVar( "hatshook_breakpower", "3", ServerConvarFlags, "Strength of each breakout attempt" )
CreateConVar( "hatshook_breakregen", "1", ServerConvarFlags, "Breakout depletion rate" )

function ENT:SetupDataTables()
	self:NetworkVar( "Bool", 0, "HasHit" )
	
	self:NetworkVar( "Entity", 0, "Wep" )
	self:NetworkVar( "Entity", 1, "TargetEnt" )
	
	self:NetworkVar( "Int", 0, "Dist" )
	self:NetworkVar( "Int", 1, "Durability" )
	
	self:NetworkVar( "Int", 2, "FollowBone" )
	self:NetworkVar( "Vector", 1, "FollowOffset" )
	self:NetworkVar( "Angle", 0, "FollowAngle" )
	
	self:NetworkVar( "Vector", 0, "ShootDir" )
end

function ENT:Initialize()
	self:SetModel( self.Model )
	
	--self:SetMoveType( MOVETYPE_VPHYSICS )
	self:PhysicsInit( SOLID_VPHYSICS )
	if not cvars.Bool( "hatshook_hookplayers" ) then
		self:SetCollisionGroup( COLLISION_GROUP_WEAPON )
	end
	
	self:PhysWake()
	local phys = self:GetPhysicsObject()
	if IsValid(phys) then
		if SERVER then
			self:SetShootDir( self.Owner:GetAimVector() * cvars.Number( "hatshook_speed" ) )
		end
		phys:SetVelocity( self:GetShootDir() )
	end
	
	self.HookHealth = 100
	
	hook.Add( "AllowPlayerPickup", self, self.AllowPlayerPickup )
	if CLIENT then hook.Add( "HUDPaint", self, self.HUDPaint ) end
	
	if SERVER then
		local timerName = tostring(self).." Hook Durability Restore"
		timer.Create( timerName, 0.1, 0, function()
			if not IsValid(self) then timer.Destroy(timerName) return end
			self:SetDurability( math.Approach(self:GetDurability(), 0, cvars.Number("hatshook_breakregen") ) )
		end)
		hook.Add( "KeyPress", self, self.PlayerKeyPress )
	end
end

function ENT:Destroyed( NoCooldown )
	if CLIENT then return end
	
	local ef = EffectData()
	ef:SetStart( self:GetPos() )
	ef:SetOrigin( self:GetPos() )
	ef:SetScale( 1 )
	ef:SetRadius( 1 )
	ef:SetMagnitude( 1 )
	ef:SetNormal( self:GetRight() )
	
	util.Effect( "Sparks", ef, true, true )
	sound.Play( self.HitSound, self:GetPos(), 75, 100 )
	
	if IsValid( self:GetWep() ) and self:GetWep().SetCooldown then
		self:GetWep():SetCooldown( NoCooldown and self:GetWep():GetCooldown()+10 or 100 )
	end
	
	self:Remove()
end
function ENT:OnTakeDamage( DmgInfo )
	self.HookHealth = (self.HookHealth or 0) - DmgInfo:GetDamage()
	if self.HookHealth<=0 then
		self:Destroyed()
	end
end

--local NoHitEnts = { ["func_breakable_surf"] = true, ["ent_realistic_hook"] = true } // This is stuff we shouldn't attach to, glitches out
local NoHitEnts = { ["worldspawn"] = true, ["player"] = true, ["prop_ragdoll"] = true } // This is stuff we shouldn't attach to, glitches out
function ENT:PhysicsCollide( data, phys )
	if self:GetHasHit() then return end // Already hit

	if IsValid(data.HitEntity) and not NoHitEnts[data.HitEntity:GetClass()] then // Something that'll bug out, eg a window
		self:Destroyed( true )
		return
	end

	if IsValid(data.HitEntity) and data.HitEntity:IsPlayer() and MOAT_CONTAGION_ROUND_ACTIVE then // Something that'll bug out, eg a window
		if (CLIENT) then
			if (MG_CG.InfectedPlayers and MG_CG.InfectedPlayers[data.HitEntity] and MG_CG.InfectedPlayers[self.Owner]) then
				return
			end
		else
			if (MG_CG.Infected and MG_CG.Infected[data.HitEntity] and MG_CG.Infected[self.Owner]) then
				self:Destroyed(true)
				return
			end
		end
	end
	
	local tr = util.TraceLine( {start = (data.HitPos - (data.HitNormal*10)), endpos = (data.HitPos+data.HitNormal*10), filter = self} )
	if tr.HitSky then return end
	
	timer.Simple(0,function()
		if not IsValid(self) then return end
		
		self:SetCollisionGroup( COLLISION_GROUP_WORLD )
		
		self:SetPos( data.HitPos )
		local ang = data.HitNormal:Angle()
		ang:RotateAroundAxis( ang:Up(), 90 )
		self:SetAngles( ang )
		self:SetMoveType( MOVETYPE_NONE )
	end)

	if (not IsValid(self:GetWep().Owner)) then return end
	
	self:SetDist( data.HitPos:Distance( self:GetWep().Owner:GetShootPos() ) )
	
	local ef = EffectData()
	ef:SetOrigin( data.HitPos )
	ef:SetNormal( data.HitNormal )
	ef:SetStart( data.HitPos )
	ef:SetMagnitude( 2 )
	ef:SetScale( 1 )
	ef:SetRadius( 1 )
	
	util.Effect( "Sparks", ef, true, true )
	sound.Play( self.HitSound, data.HitPos, 75, 100 )
	
	if IsValid( data.HitEntity ) and data.HitEntity~=self and data.HitEntity~=self.Owner and (not (data.HitEntity:IsWeapon() and data.HitEntity:GetOwner()==self.Owner)) then
		self:SetParent( data.HitEntity )
		
		if data.HitEntity:GetClass():sub(1,5)~="func_" then
			for i=0,data.HitEntity:GetPhysicsObjectCount()-1 do
				local p = data.HitEntity:GetPhysicsObjectNum( i )
				if p==data.HitObject then
					--self:SetParentPhysNum( data.HitEntity:TranslatePhysBoneToBone(i) )
					--self:FollowBone( data.HitEntity, data.HitEntity:TranslatePhysBoneToBone(i) )
					--print(i,data.HitEntity:TranslatePhysBoneToBone(i))
					
					self:SetFollowBone( data.HitEntity:TranslatePhysBoneToBone(i) )
					if (not self:GetFollowBone()) then continue end
					local pos, ang = data.HitEntity:GetBonePosition( self:GetFollowBone() )
					if pos and ang then
						self:SetFollowOffset( self:GetPos() - pos )
						self:SetFollowAngle( self:GetAngles()-ang )
					end
					break
				end
			end
		end
		
		self:SetTargetEnt( data.HitEntity )
	end
	
	self:SetHasHit( true )
end

-- Misc hooks --
----------------
function ENT:Think()
	if SERVER and (not (IsValid(self:GetWep()) and self:GetWep()==self.Owner:GetActiveWeapon()) ) then self:Remove() return end
	
	local phys = self:GetPhysicsObject()
	if IsValid(phys) and self:GetHasHit() then // This stuff doesn't work in the collision hook
		phys:EnableMotion( false )
		phys:SetPos( self:GetPos() )
		phys:SetAngles( self:GetAngles() )
	end
end

function ENT:AllowPlayerPickup( ply, ent )
	if ply==self.Owner then return false end // They're currently hooked to something, if we let them pick it up they can exploit and fly
end

-- 3D Drawing --
----------------
local HookCable = Material( "cable/cable2" )
function ENT:Draw()
	if IsValid( self:GetTargetEnt() ) then
		if (self:GetTargetEnt():IsPlayer() and self:GetTargetEnt():Team() == TEAM_SPEC) then
			self:Destroyed()
			return
		end
		if (not self:GetFollowBone()) then return end
		local bpos, bang = self:GetTargetEnt():GetBonePosition( self:GetFollowBone() )
		local npos, nang = self:GetFollowOffset(), self:GetFollowAngle()
		if npos and nang and bpos and bang then
			npos:Rotate( nang )
			nang = nang+bang
			
			npos = bpos+npos
			
			self:SetPos( npos )
			self:SetAngles( nang )
		end
	end
	
	self:DrawModel()
	
	// We'll draw the beam from both the weapon and the hook, less likely to move out of rendering when it should be visible
	if not IsValid( self:GetWep() ) then return end
	if self.Owner==LocalPlayer() and not hook.Call("ShouldDrawLocalPlayer", GAMEMODE, self.Owner) then return end // Badly aligned, the rope will always be visible from the ViewModel draw anyway
	
	if IsValid(self.Owner) then
		local att = self:GetWep():GetAttachment( 1 )
		
		render.SetMaterial( HookCable )
		if att and att.Pos then
			render.DrawBeam( self:GetPos(), att.Pos, 1, 0, 2, Color(255,255,255,255) )
		else
			render.DrawBeam( self:GetPos(), self:GetWep():GetPos(), 1, 0, 2, Color(255,255,255,255) )
		end
	end
end

-- HUD stuff --
---------------
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
local function ShadowText( txt, x, y, col )
	draw.DrawText( txt, "Default", x+1, y+1, Color(0,0,0), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
	draw.DrawText( txt, "Default", x, y, col or Color(255,255,255), TEXT_ALIGN_CENTER, TEXT_ALIGN_TOP )
end
function ENT:HUDPaint()
	if not (LocalPlayer()==self:GetTargetEnt()) then return end
	
	ShadowText( "Rope length: "..tostring(self:GetDist()), ScrW()/2, ScrH()/2-60 )
	ShadowText( "You have been hooked!", ScrW()/2, ScrH()/2-75, Color(255,100,100) )
	ShadowText( (input.LookupBinding("+use") or "[USE]"):upper() .. " - Break free", ScrW()/2, ScrH()/2-40 )
	DrawChargeBar( (ScrW()/2)-70, (ScrH()/2)-20, 140, 15, self:GetDurability() )
end

if SERVER then
	function ENT:PlayerKeyPress( ply, key )
		if (ply~=self:GetTargetEnt() or key~=IN_USE) then return end
		
		self:SetDurability( self:GetDurability()+cvars.Number("hatshook_breakpower") )
		if self:GetDurability()>=100 then self:Destroyed() end
	end
end
