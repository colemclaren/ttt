SHR = {
	Players = {},
	Callbacks = {},
	Config = {
		WallChecks = true,
		MaxWait = 1
	}
}
print("Server Hit Reg Loaded")
util.AddNetworkString("moat_hitreg_command")
util.AddNetworkString("moat_damage_number")
util.AddNetworkString "shr"

hook.Add("PlayerSay", "moat_ChatCommand", function(ply, text, team)
	if (table.HasValue(MOAT_HITREG.ChatCommands, text) or table.HasValue(MOAT_HITREG.ChatCommands, text:lower())) then
		net.Start("moat_hitreg_command")
		net.Send(ply)

		return ""
	end
end)

if (not SHR_Val) then
	SHR_Val = math.random(0, 0xFFFFFFFF)
end

local MAX_Ping = 300 -- changes

util.AddNetworkString "AHR_MaxPing"

timer.Create("AHR_PingCheck", 5, 0, function()
	local avg_ping = 0
	local ply_count = player.GetCount()

	for _, ply in pairs(player.GetAll()) do
		avg_ping = avg_ping + ply:Ping() / ply_count
	end

	MAX_Ping = math.floor(0.5 + math.max(150, avg_ping + 40))
	-- net.Start "AHR_MaxPing"
	-- 	net.WriteUInt(MAX_Ping, 32)
	-- net.Broadcast()
end)

local ENTITY = FindMetaTable "Entity"
function ENTITY:HitRegCheck()
	return self:IsPlayer() and self:GetInfoNum("moat_alt_hitreg", 1) == 1 and self:Ping() < 300 --MAX_Ping
end

function SHR:CreateShot(wpn, shotnum, firenum)
	firenum = firenum or wpn:GetDTInt(28)
	local owner = wpn:GetOwner()
	local t = SHR.Players[owner]
	if (not t) then
		t = {}
		SHR.Players[owner] = t
	end
	local t1 = t[wpn]
	if (not t1) then
		t1 = {}
		t[wpn] = t1
	end
	local t2 = t1[firenum]
	if (not t2) then
		t2 = {}
		t1[firenum] = t2
	end
	local t3 = t2[shotnum]
	if (not t3) then
		t3 = {}
		t2[shotnum] = t3

		timer.Simple(SHR.Config.MaxWait, function()
			t2[shotnum] = nil
			if (not next(t2)) then
				t1[firenum] = nil
			end
		end)
	end
	return t3
end

function SHR:WeHit(shooter, ent, wpn, eye, localposx, localposy, localposz, dmgfrc, hg, fire_num, shot_num)
	if (not IsValid(wpn) or not IsValid(ent) or not IsValid(shooter)) then
		return
	end

	if (shooter:GetObserverMode() ~= OBS_MODE_NONE or wpn:GetOwner() ~= shooter or not IsValid(ent) or (ent:IsPlayer() and ent:GetObserverMode() ~= OBS_MODE_NONE)) then
		return
	end

	local localpos = Vector(localposx, localposy, localposz)

	local mins, maxs = ent:OBBMins(), ent:OBBMaxs()
	if (localpos:DistToSqr((mins + maxs) / 2) > mins:DistToSqr(maxs)) then
		return
	end

	local pos = ent:LocalToWorld(localpos)

	local shot = self:CreateShot(wpn, shot_num, fire_num)

	if (shot.Done) then
		return
	end

	if (not shot.Damage) then
		shot.WaitingCallback = function()
			self:WeHit(shooter, ent, wpn, eye, localposx, localposy, localposz, dmgfrc, hg, fire_num, shot_num)
		end
		return
	end

	shot.Done = true

	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(shooter)
	dmginfo:SetDamage(shot.Damage)
	dmginfo:SetDamageForce(dmgfrc)
	dmginfo:SetDamagePosition(pos)
	dmginfo:SetDamageType(DMG_BULLET)
	dmginfo:SetInflictor(wpn)
	dmginfo:SetDamageCustom(hg + 1)
	dmginfo:ScaleDamage(shooter:GetDamageFactor() or 1)

	if (ent:IsPlayer() and (hook.Run("ScalePlayerDamage", ent, hg, dmginfo) or hook.Run("PlayerShouldTakeDamage", ent, shooter) == false))then
		return
	end

	if (ent:IsNPC()) then hook.Run("ScaleNPCDamage", ent, hg, dmginfo) end

	if (shot.Callback) then
		local tr = {
			Entity = ent,
			Fraction = 1,
			FractionLeftSolid = 0,
			Hit = true,
			HitBox = 0,
			HitGroup = hg,
			HitNoDraw = false,
			HitNonWorld = false,
			HitNormal = Vector(1, 0, 0), -- bad, redo
			HitPos = pos,
			HitSky = false,
			HitWorld = false,
			MatType = 0,
			Normal = (pos - eye):GetNormalized(),
			PhysicsBone = 0,
			SurfaceProps = 0,
			StartSolid = false,
			AllSolid = false
		}
		shot.Callback(shooter, tr, dmginfo)
	end

	ent:TakeDamageInfo(dmginfo)

	dmginfo:SetDamageCustom(0)
end

function SHR:SendHitEffects(pl, num, pos)
	net.Start "moat_damage_number"
		net.WriteUInt(num, 32)
		net.WriteVector(pos)
	net.Send(pl)

	return (IsValid(pl) and num and pos)
end

local function hiteffects(targ, dmg)
	if (GetRoundState() == ROUND_PREP or not dmg /*or dmg:GetDamage() <= 0*/) then
		return false
	end

	local att = dmg:GetAttacker()
	if (not IsValid(targ) or not IsValid(att) or not att:IsPlayer()) then
		return false
	end

	local apache = (IsValid(MOAT_APACHE_ENT) and MOAT_APACHE_ENT == targ) or (IsValid(MOAT_BOSS_CUR_PLY) and MOAT_BOSS_CUR_PLY == targ)
	if (not targ:IsPlayer() and not apache) then
		return false
	end

	return SHR:SendHitEffects(att, dmg:GetDamage(), dmg:GetDamagePosition())
end
hook("PlayerHitEffects", hiteffects)


local function takedamage(gm, targ, dmg)
	local ret = gm:OLDEntityTakeDamage(targ, dmg)

	if (not hiteffects(targ, dmg)) then
		return
	end

	return ret
end

local function entityfirebullets(gm, e, t)
	if (e:IsPlayer()) then
		local wpn = e:GetActiveWeapon()
		wpn:SetDTInt(28, wpn:GetDTInt(28) + 1)
	end

	if (gm.OldEntityFireBullets) then
		gm:OldEntityFireBullets(e, t)
	end
	if (e:HitRegCheck()) then
		local cb = t.Callback

		local num = 1

		local wpn = e:GetActiveWeapon()
		local dmg = t.Damage

		t.Callback = function(a, tr, d)


			if (not (IsValid(tr.Entity) and tr.Entity:IsPlayer())) then
				local shot = SHR:CreateShot(wpn, num)
				if (not shot.Done) then
					shot.Callback = cb
					shot.Damage = dmg
					shot.Trace = tr
				end
				if (shot.WaitingCallback) then
					shot.WaitingCallback()
					shot.WaitingCallback = nil
					shot.Done = true
				end
			end

			num = num + 1
			if (cb) then
				return cb(a, tr, d)
			end
		end
	end

	return true
end

local function register(GM)
	GM.OLDEntityTakeDamage = GM.OLDEntityTakeDamage or GM.EntityTakeDamage
	GM.EntityTakeDamage = takedamage
	if (GM.OldEntityFireBullets == nil) then
		GM.OldEntityFireBullets = GM.EntityFirebullets or false
	end
	GM.EntityFireBullets = entityfirebullets
end

local GM = GM or GAMEMODE or gmod.GetGamemode()
if (not GM) then
	hook.Add("Initialize", "SHR.Initialize", function()
		register(GM or GAMEMODE or gmod.GetGamemode())
	end)
else
	register(GM)
end

net.ReceiveNoLimit("shr", function(_, pl)
	if (not pl:HitRegCheck() or pl:GetObserverMode() ~= OBS_MODE_NONE or net.ReadUInt(32) ~= SHR_Val) then
		return
	end

	SHR:WeHit(pl, net.ReadEntity(), net.ReadEntity(), 
		net.ReadVector(),
		net.ReadFloat(), net.ReadFloat(), net.ReadFloat(), 
		net.ReadVector(),
		net.ReadUInt(4), net.ReadUInt(32), net.ReadUInt(8)
	)
end)

hook.Add("PlayerAuthed", "SHR.PlayerAuthed", function(pl)
	net.Start "shr"
		net.WriteUInt(SHR_Val, 32)
	net.Send(pl)
end)

for k,v in pairs(player.GetAll()) do
	net.Start "shr"
		net.WriteUInt(SHR_Val, 32)
	net.Send(v)
end