AddCSLuaFile()

SWEP.HoldType = "normal"
SWEP.PrintName = "Lay Taunt"

if CLIENT then
   SWEP.Slot      = 5
   SWEP.Icon = "moat_inv/moat_taunt.png"

   SWEP.ViewModelFOV = 10
end

SWEP.Base = "weapon_tttbase"
SWEP.ViewModel  = "models/weapons/v_crowbar.mdl"
SWEP.WorldModel = "models/weapons/w_crowbar.mdl"

SWEP.Primary.ClipSize       = -1
SWEP.Primary.DefaultClip    = -1
SWEP.Primary.Automatic      = false
SWEP.Primary.Ammo           = "none"
SWEP.Secondary.ClipSize     = -1
SWEP.Secondary.DefaultClip  = -1
SWEP.Secondary.Automatic    = false
SWEP.Secondary.Ammo         = "none"
SWEP.CurrentCamera = 0
SWEP.TauntAnimation = ACT_HL2MP_ZOMBIE_SLUMP_IDLE
SWEP.TauntLoop = true
SWEP.TauntOver = CurTime()
SWEP.ViewAngles = Angle(0, 0, 0)

SWEP.Kind = WEAPON_UNARMED
SWEP.AllowDelete = false
SWEP.AllowDrop = false

SWEP.NoSights = true

function SWEP:GetClass()
   return "weapon_ttt_unarmed"
end

function SWEP:SetupDataTables()
	self:NetworkVar("Bool", 0, "TauntActive")
	self:SetTauntActive(false)
end

function SWEP:OnDrop()
   self:Remove()
end

function SWEP:ShouldDropOnDie()
   return false
end

function SWEP:InitializeTaunt()
	if (SERVER) then
		self:CreateRagdoll()
		self:SetTauntActive(true)
	end
end

function SWEP:CreateRagdoll()
	if (not IsValid(self.Owner)) then return end
	local pl = self.Owner
	SafeRemoveEntity(pl.Ragdoll)
	local rag = ents.Create "prop_ragdoll"
	if (not IsValid(rag)) then return end
	self.Ragdoll = rag
	pl.PlayDead = rag
	rag:SetOwner(pl)
	rag:SetDTEntity(CORPSE.dti.ENT_PLAYER, pl)
	rag:SetDTBool(CORPSE.dti.BOOL_FOUND, true)
	rag:SetDTEntity(10, pl)
	rag:SetPos(pl:GetPos())
	rag:SetModel(pl:GetModel())
	rag:SetAngles(pl:GetAngles())

	local col = pl:GetPlayerColor()
	rag.GetPlayerColor = function() return col end
	rag:SetColor(pl:GetColor())

	rag:SetCustomCollisionCheck(true)
	rag.CheckThisShit = true
	rag.IsPlayDead = true
	rag.CanPickup = false
	rag:Spawn()
	rag:Activate()

	local phys = rag:GetPhysicsObject()
	if (IsValid(phys)) then
		phys:AddGameFlag(FVPHYSICS_PLAYER_HELD)
	end

	timer.Tick(function()
		if (IsValid(rag)) then rag:CollisionRulesChanged() end
	end)

	local ang = pl:GetAngles()
	ang.p = 0

	local num = rag:GetPhysicsObjectCount() - 1
	for i = 0, num do
		local bone = rag:GetPhysicsObjectNum(i)
		if (not IsValid(bone)) then continue end
		local bp, ba = pl:GetBonePosition(rag:TranslatePhysBoneToBone(i))

		bp, ba = WorldToLocal(bp - pl:OBBCenter(), ba, pl:GetPos(), ang)
		bp, ba = LocalToWorld(bp, ba, pl:GetPos(), Angle(90, ang.y + 180, 180))
		bp = bp + Vector(0, 0, 20)
		if (bp and ba) then
			bone:SetPos(bp)
			bone:SetAngles(ba)
		end
	end


	pl:SetNoDraw(true)

	net.Start "MOAT_PLAYER_CLOAKED"
	net.WriteEntity(pl)
	net.WriteBool(true)
	net.Broadcast()
end

hook.Add("EntityTakeDamage", "Play Dead Taunt", function(ent, dmg)
	if (dmg:GetDamageType() == DMG_CRUSH and dmg:GetAttacker() == game.GetWorld()) then
		return
	end

	if (ent:IsPlayer() and IsValid(ent.PlayDead)) then
		local wep = ent:GetActiveWeapon()
		if (IsValid(wep)) then
			wep:EndTaunt()
		end

		return
	end

	if (not ent.IsPlayDead) then
		return
	end

	local p = ent:GetOwner()

	if (IsValid(p)) then
		p:GetActiveWeapon():EndTaunt()
		p:TakeDamageInfo(dmg)
	end
end)

function SWEP:EndTaunt()
	if (CLIENT) then return end

	SafeRemoveEntity(self.Ragdoll)
	self:SetTauntActive(false)

	if (not IsValid(self.Owner)) then
		return
	end

	self:GetOwner().PlayDead = nil

	self.Owner:SetNoDraw(false)

	net.Start "MOAT_PLAYER_CLOAKED"
	net.WriteEntity(self.Owner)
	net.WriteBool(false)
	net.Broadcast()
end

function SWEP:OnRemove()
	if (self:GetTauntActive()) then
		self:EndTaunt()
	end
end

function SWEP:PrimaryAttack()
	if (self:GetNextPrimaryFire() > CurTime() or not IsFirstTimePredicted() or self:GetTauntActive()) then return end
	if (not self.Owner:OnGround()) then return end

	self:SetNextPrimaryFire(CurTime() + 1)

	if (CLIENT) then
		self.CurrentCamera = 0
	end

	self:InitializeTaunt()
end

function SWEP:SecondaryAttack()
end

function SWEP:Reload()
end

function SWEP:Think()
	if (SERVER and self:GetTauntActive()) then
		local pl = self.Owner
		if (not IsValid(pl)) then
			return self:EndTaunt()
		end

		if (pl:MoveKeysDown()) then
			return self:EndTaunt()
		end

		if (IsValid(self.Ragdoll) and self.Ragdoll:GetPos():DistToSqr(pl:GetPos()) > 3184) then
			self:SetNextPrimaryFire(CurTime() + 1)
			return self:EndTaunt()
		end
	end
end

function SWEP:Deploy()
   if SERVER and IsValid(self.Owner) then
      self.Owner:DrawViewModel(false)
   end
   return true
end

function SWEP:Holster()
	if (self:GetTauntActive()) then
		self:EndTaunt()
	end

    return true
end

function SWEP:DrawWorldModel()
end

function SWEP:DrawWorldModelTranslucent()
end

function SWEP:CalcView(ply, pos, ang, fov)
    if (self:GetTauntActive()) then
    	local calc = {}

    	self.CurrentCamera = Lerp(FrameTime() * 5, self.CurrentCamera, 100)

    	local extra_vec = pos - (ang:Forward() * self.CurrentCamera)

    	local tr = util.TraceLine({
			start = pos,
			endpos = extra_vec,
			filter = ply
		})

    	if (tr.Hit) then
    		extra_vec = tr.HitPos + (ang:Forward() * 10)
    	end

    	calc.origin = extra_vec
    	calc.angles = ang
    	calc.fov = fov

    	return calc.origin, calc.angles, calc.fov, true
    end
end