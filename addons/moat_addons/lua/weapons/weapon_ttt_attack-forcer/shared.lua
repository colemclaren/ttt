

if SERVER then

   AddCSLuaFile( "shared.lua" )

--resource.AddFile("materials/VGUI/ttt/icon_Attack-Forcer.png")

end



SWEP.HoldType			= "pistol"



   SWEP.PrintName = "Attack-Forcer"

if CLIENT then

   SWEP.Slot = 6



   SWEP.EquipMenuData = {

      type = "item_weapon",

      desc = "1 Dart. Force a Player to attack!"

   };



   SWEP.Icon = "VGUI/ttt/icon_Attack-Forcer.png"

end



SWEP.Cat = "Dart Guns"



SWEP.Base = "weapon_tttbase"

SWEP.Primary.Recoil	= 1.35

SWEP.Primary.Damage = 0

SWEP.Primary.Delay = 0.38

SWEP.Primary.Cone = 0.001

SWEP.Primary.ClipSize = 1

SWEP.Primary.Automatic = true

SWEP.Primary.DefaultClip = 1

SWEP.Primary.ClipMax = 1

SWEP.Primary.Ammo = "Dart"



SWEP.Kind = WEAPON_EQUIP

SWEP.CanBuy = {ROLE_TRAITOR} -- only traitors can buy

SWEP.LimitedStock = false

SWEP.AmmoEnt = "item_ammo_dart_ttt"



SWEP.IsSilent = true



SWEP.ViewModel			= "models/weapons/v_pist_usp.mdl"

SWEP.WorldModel			= "models/weapons/w_pist_usp_silencer.mdl"



SWEP.Primary.Sound = Sound( "weapons/usp/usp1.wav" )

SWEP.Primary.SoundLevel = 50

SWEP.Primary.Delay = 1



SWEP.IronSightsPos = Vector( 4.48, -4.34, 2.75)

SWEP.IronSightsAng = Vector(-0.5, 0, 0)



SWEP.PrimaryAnim = ACT_VM_PRIMARYATTACK_SILENCED

SWEP.ReloadAnim = ACT_VM_RELOAD_SILENCED



SWEP.MuzzleEffect			= "rg_muzzle_silenced" -- This is an extra muzzleflash effect

-- Available muzzle effects: rg_muzzle_grenade, rg_muzzle_highcal, rg_muzzle_hmg, rg_muzzle_pistol, rg_muzzle_rifle, rg_muzzle_silenced, none



SWEP.ShellEffect			= "none" -- This is a shell ejection effect

-- Available shell eject effects: rg_shelleject, rg_shelleject_rifle, rg_shelleject_shotgun, none



local str = 'ambient/voices/cough'

local sou = {Sound(str..'1'..'.wav'),Sound(str..'2'..'.wav'),Sound(str..'3'..'.wav'),Sound(str..'4'..'.wav')}



function SWEP:Deploy()

   self.Weapon:SendWeaponAnim(ACT_VM_DRAW_SILENCED)

   return true

end



local function DoPoison(attacker,ply)

	if IsValid(ply) and ply:Alive() and ply.infected and IsValid(attacker) then

		local pos = ply:GetPos()

		local ang = ply:GetAngles()

		local dmg = DamageInfo()

		dmg:SetDamage(0)

		dmg:SetAttacker(attacker)

		dmg:SetInflictor(ply)

		dmg:SetDamageType(DMG_GENERIC)

		ply:TakeDamageInfo(dmg)

	end

end



function SWEP:PrimaryAttack(worldsnd)

	if not self:CanPrimaryAttack() then return end

	if SERVER and self.Owner:GetNW2Bool('disguised',false) == true and string.len(self.Owner:GetNW2String('disgas','')) > 0 then self.Owner:ConCommand('ttt_set_disguise 0') end

	if SERVER and _rdm then

		local stid = self.Owner:SteamID()

		if not _rdm.shotsFired[stid] then _rdm.shotsFired[stid] = {} end

		table.insert(_rdm.shotsFired[stid],CurTime())

	end

	if SERVER and ShootLog then ShootLog(Format("WEAPON:\t %s [%s] shot a %s", self.Owner:Nick(), self.Owner:GetRoleString(), self.Weapon:GetClass())) end

	self.Weapon:SetNextPrimaryFire( CurTime() + self.Primary.Delay )

	self:TakePrimaryAmmo(1)

   --sound.Play(self.Primary.Sound, self.Weapon:GetPos(), self.Primary.SoundLevel)

   self.Weapon:SendWeaponAnim(ACT_VM_IDLE)



   local cone = self.Primary.Cone or 0.1

   local num = 1



   local bullet = {}

   bullet.Num    = num

   bullet.Src    = self.Owner:GetShootPos()

   bullet.Dir    = self.Owner:GetAimVector()

   bullet.Spread = Vector( cone, cone, 0 )

   bullet.Tracer = 1

   bullet.Force  = 0

   bullet.Damage = 0

   bullet.TracerName = "Tracer"



   local owner = self.Owner

   bullet.Callback = function(att, tr, dmginfo)

		local ply = tr.Entity

		if SERVER and IsValid(ply) and (ply:IsPlayer() or ply:IsNPC()) then

			ply.infected = true

			ply:SetNW2Bool('infected',true)

			local attacker = self.Owner

			if ply:IsNPC() then timer.Simple(10,function() if IsValid(ply) then ply:Remove() end end)

			else

				timer.Simple(10,function() DoPoison(attacker,ply) end)
				timer.Create("AttackForcer" .. ply:SteamID64(),0.5,0,function()

					if IsValid(ply) and ply.infected and ply:Alive() then

						ply:ConCommand("+attack")

						timer.Simple(0.25,function() if IsValid(ply) then ply:ConCommand("-attack") end end)

					elseif IsValid(ply) and ply.infected and not ply:Alive() then

						timer.Remove("AttackForcer" .. ply:SteamID64())

					end

				end)

				DamageLog(Format("DMG:\t %s [%s] Infected with Attack-Forcer %s [%s]", self.Owner:Nick(), self.Owner:GetRoleString(), ply:Nick(), ply:GetRoleString()))

			end

		end

	end

   self.Owner:FireBullets( bullet )

	local owner = self.Owner

    if not IsValid(owner) or owner:IsNPC() or (not owner.ViewPunch) then return end

    owner:ViewPunch( Angle( math.Rand(-0.2,-0.1) * self.Primary.Recoil, math.Rand(-0.1,0.1) *self.Primary.Recoil, 0 ) )

end



local function StopPoison(ply)
	if (CLIENT) then return end
	
	for k, v in ipairs(player.GetAll()) do
		timer.Remove("AttackForcer" .. v:SteamID64())
	end
end

hook.Add("TTTEndRound", "PoisonTimerEnd", StopPoison)



local function StopPoison2(ply)
	if IsValid(ply) and ply.infected then
		timer.Remove("AttackForcer" .. ply:SteamID64())
	end
end

hook.Add( "PlayerDisconnected", "playerDisconnected", StopPoison2 )



-- We were bought as special equipment, and we have an extra to give

function SWEP:WasBought(buyer)

   if IsValid(buyer) then -- probably already self.Owner

      buyer:GiveAmmo( 1, "Dart" )

   end

end