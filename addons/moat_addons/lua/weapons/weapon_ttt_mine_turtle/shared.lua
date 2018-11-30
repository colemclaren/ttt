--[[Author informations]]--
SWEP.Author = "Zaratusa"
SWEP.Contact = "http://steamcommunity.com/profiles/76561198032479768"

local detectiveEnabled = CreateConVar("ttt_mineturtle_detective", 0, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should Detectives be able to buy the Mine Turtle?")
local traitorEnabled = CreateConVar("ttt_mineturtle_traitor", 1, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Should Traitors be able to buy the Mine Turtle?")
CreateConVar("ttt_mineturtle_max", 5, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Maximum amount of turtles everyone can carry.")
CreateConVar("ttt_mineturtle_bought", 2, {FCVAR_SERVER_CAN_EXECUTE, FCVAR_ARCHIVE, FCVAR_REPLICATED}, "Amount of turtles you receive, when you buy a Mine Turtle.")

-- always derive from weapon_tttbase
SWEP.Base = "weapon_tttbase"
SWEP.PrintName = "Mine Turtle"
--[[Default GMod values]]--
SWEP.Primary.Ammo = "none"
SWEP.Primary.Delay = 1.5
SWEP.Primary.Automatic = false
SWEP.Primary.ClipSize = GetConVar("ttt_mineturtle_max"):GetInt()
SWEP.Primary.DefaultClip = GetConVar("ttt_mineturtle_bought"):GetInt()
SWEP.Secondary.Delay = 1.5
SWEP.FiresUnderwater = false

--[[Model settings]]--
SWEP.HoldType = "slam"
SWEP.ViewModel = Model("models/weapons/zaratusa/mine_turtle/v_mine_turtle.mdl")
SWEP.WorldModel	= Model("models/weapons/zaratusa/mine_turtle/w_mine_turtle.mdl")

--[[TTT config values]]--

-- Kind specifies the category this weapon is in. Players can only carry one of
-- each. Can be: WEAPON_... MELEE, PISTOL, HEAVY, NADE, CARRY, EQUIP1, EQUIP2 or ROLE.
-- Matching SWEP.Slot values: 0      1       2     3      4      6       7        8
SWEP.Kind = WEAPON_EQUIP1

-- If AutoSpawnable is true and SWEP.Kind is not WEAPON_EQUIP1/2,
-- then this gun can be spawned as a random weapon.
SWEP.AutoSpawnable = false

-- The AmmoEnt is the ammo entity that can be picked up when carrying this gun.
SWEP.AmmoEnt = "none"

-- CanBuy is a table of ROLE_* entries like ROLE_TRAITOR and ROLE_DETECTIVE. If
-- a role is in this table, those players can buy this.
SWEP.CanBuy = {ROLE_TRAITOR}
-- If LimitedStock is true, you can only buy one per round.
SWEP.LimitedStock = true

-- If AllowDrop is false, players can't manually drop the gun with Q
SWEP.AllowDrop = true

-- If NoSights is true, the weapon won't have ironsights
SWEP.NoSights = true

function SWEP:PrimaryAttack()
	if (self:CanPrimaryAttack() and self:GetNextPrimaryFire() <= CurTime()) then
		self:SetNextPrimaryFire(CurTime() + self.Primary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Primary.Delay)

		self:MineDrop()
	end
end

function SWEP:MineDrop()
	local owner = self.Owner
	if (SERVER and IsValid(owner)) then
		local mine = ents.Create("ttt_mine_turtle")
		if (IsValid(mine)) then
			self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
			local src = owner:GetShootPos()
			local ang = owner:GetAimVector()
			local vel = owner:GetVelocity()

			local throw = vel + ang * 200

			mine:SetPos(src + ang * 10)
			mine:SetPlacer(owner)
			mine:Spawn()

			mine.fingerprints = self.fingerprints

			local phys = mine:GetPhysicsObject()
			if (IsValid(phys)) then
				phys:Wake()
				phys:SetVelocity(throw)
			end

			self:TakePrimaryAmmo(1)
			self:Deploy()
		end
	end
end

function SWEP:SecondaryAttack()
	if (self:CanSecondaryAttack() and self:GetNextSecondaryFire() <= CurTime()) then
		self:SetNextPrimaryFire(CurTime() + self.Secondary.Delay)
		self:SetNextSecondaryFire(CurTime() + self.Secondary.Delay)

		self:MineStick()
	end
end

function SWEP:MineStick()
	local owner = self.Owner
	if (SERVER and IsValid(owner)) then
		local ignore = {owner, self.Weapon}
		local spos = owner:GetShootPos()
		local epos = spos + owner:GetAimVector() * 42

		local tr = util.TraceLine({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID})
		if (tr.HitWorld) then
			local mine = ents.Create("ttt_mine_turtle")
			if (IsValid(mine)) then
				local tr_ent = util.TraceEntity({start=spos, endpos=epos, filter=ignore, mask=MASK_SOLID}, mine)
				if (tr_ent.HitWorld) then
					self.Weapon:SendWeaponAnim(ACT_VM_SECONDARYATTACK)
					local ang = tr_ent.HitNormal:Angle()
					ang.p = ang.p + 90

					mine:SetPos(tr_ent.HitPos + (tr_ent.HitNormal * 3))
					mine:SetAngles(ang)
					mine:SetPlacer(owner)
					mine:Spawn()

					mine.fingerprints = self.fingerprints

					local phys = mine:GetPhysicsObject()
					if IsValid(phys) then
						phys:Wake()
						phys:EnableMotion(false)
					end

					self:TakePrimaryAmmo(1)
					self:Deploy()
				end
			end
		end
	end
end

function SWEP:Deploy()
	if (SERVER and self.Weapon:Clip1() == 0) then
		self:Remove()
	else
		self.Weapon:SendWeaponAnim(ACT_VM_DRAW)
	end
end

-- Reload does nothing
function SWEP:Reload()
end
