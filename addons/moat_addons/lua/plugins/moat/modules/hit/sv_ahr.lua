SHR = {
	Players = {},
	Callbacks = {},
	Config = {
		WallChecks = true,
		MaxWait = 1
	}
}
print("Server Hit Reg Loaded")
util.AddNetworkString("moat_hitmarker")
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

local ENTITY = FindMetaTable "Entity"
function ENTITY:HitRegCheck()
	return self:IsPlayer() and self:GetInfoNum("moat_alt_hitreg", 1) == 1 and self:PacketLoss() <= 10 and self:Ping() < 234
end

function SHR:PrepareForHit(time, num, p, dmg, dir, src, tr, cb)
	SHR.Players[p] = SHR.Players[p] or {}
	local t = SHR.Players[p]
	t[time] = t[time] or {}
	t[time][num] = {
		p = p,
		dmg = dmg,
		dir = dir,
		tr = tr,
		wep = p:GetActiveWeapon(),
		num = num,
		cb = cb
	}
	if (self.Callbacks[p] and self.Callbacks[p][time] and self.Callbacks[p][time][num]) then
		self.Callbacks[p][time][num]()
	end
end

hook.Add("EntityFireBullets", "SHR.FireBullets", function(e, t)
	if (not MOAT_ACTIVE_BOSS and e:HitRegCheck() and t.Damage and t.Damage ~= 0) then

		local cb = t.Callback

		local num = 1
		local time = CurTime()
		local dmg = t.Damage

		t.Callback = function(a, tr, d)
			SHR:PrepareForHit(time, num, e, dmg, t.Dir or Vector(), t.Src or Vector(), tr, not tr.HitGroup and cb or function() end)
			num = num + 1

			if (cb and not tr.HitGroup) then
				return cb(a, tr, d)
			end
		end
		t.Damage = 0

		timer.Simple(SHR.Config.MaxWait, function() SHR.Players[e][time] = nil end)
	end
end)

function SHR:InvalidPosition(eye, pl, pos, ent, tr)
	local d1, d2 = eye:DistToSqr(tr.StartPos) > 5184, pos:DistToSqr(ent:GetPos()) > 5184
	if (d1 or d2) then return true end

	return util.TraceLine({start = eye, endpos = pos, filter = {pl, ent}}).HitWorld
end

function SHR:WeHit(shooter, ent, time, eye, pos, dmgfrc, hg, shotnum)
	local k = self.Players[shooter]
	if (not k or not k[time] or not k[time][shotnum]) then
		self.Callbacks[shooter] = self.Callbacks[shooter] or {}
		self.Callbacks[shooter][time] = self.Callbacks[shooter][time] or {}
		self.Callbacks[shooter][time][shotnum] = function()
			self:WeHit(shooter, ent, time, eye, pos, dmgfrc, hg, shotnum)
		end
		timer.Simple(self.Config.MaxWait, function()
			if (self.Callbacks[shooter][time]) then
				self.Callbacks[shooter][time][shotnum] = nil
				if (self.Callbacks[shooter][time] and not next(self.Callbacks[shooter][time])) then
					self.Callbacks[shooter][time] = nil
				end
			end
		end)
		return
	end
	k = k[time][shotnum]

	--[[ k = {
		p = p,
		dmg = dmg,
		dir = dir,
		tr = p:GetEyeTraceNoCursor(),
		wep = p:GetActiveWeapon(),
		num = num
	}]]
	if (not ent:IsPlayer() or ent:GetObserverMode() ~= OBS_MODE_NONE) then return end
	if (self.Config.WallChecks and self:InvalidPosition(eye, shooter, pos, ent, k.tr)) then return end

	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(shooter)
	dmginfo:SetDamage(k.dmg)
	dmginfo:SetDamageForce(dmgfrc)
	dmginfo:SetDamagePosition(pos)
	dmginfo:SetDamageType(DMG_BULLET)
	dmginfo:SetInflictor(k.wep)
	dmginfo:SetDamageCustom(hg)

	if (hook.Run("ScalePlayerDamage", ent, hg, dmginfo) or hook.Run("PlayerShouldTakeDamage", ent, shooter) == false) then
		return
	end

	if (ent:IsNPC()) then hook.Run("ScaleNPCDamage", ent, hg, dmginfo) end

	ent:TakeDamageInfo(dmginfo)
	if (tobool(shooter:GetInfo("moat_hitmarkers"))) then
		net.Start("moat_hitmarker")
		net.Send(shooter)
	end
	k.tr.AltHitreg = true
	k.cb(shooter, k.tr, dmginfo)
	k.tr.AltHitreg = nil

	if (self.Callbacks[shooter] and self.Callbacks[shooter][time]) then
		self.Callbacks[shooter][time][shotnum] = nil
		if (self.Callbacks[shooter][time] and not next(self.Callbacks[shooter][time])) then
			self.Callbacks[shooter][time] = nil
		end
	end
end

local function takedamage(gm, targ, dmg)
	local ret = gm:OLDEntityTakeDamage(targ, dmg)

	local att = dmg:GetAttacker()
	if (IsValid(att) and att:IsPlayer() and tobool(att:GetInfo("moat_showdamagenumbers")) and GetRoundState() ~= ROUND_PREP and dmg:GetDamage() > 0) then
		net.Start("moat_damage_number")
			net.WriteUInt(dmg:GetDamage(), 32)
			net.WriteUInt(dmg:GetDamageCustom(), 4)
			net.WriteVector(dmg:GetDamagePosition())
		net.Send(att)
	end

	return ret
end

local function register(GM)
	GM.OLDEntityTakeDamage = GM.OLDEntityTakeDamage or GM.EntityTakeDamage
	GM.EntityTakeDamage = takedamage

	net.ReceiveNoLimit("shr", function(_, pl)
		if (not pl:HitRegCheck() or pl:GetObserverMode() ~= OBS_MODE_NONE or net.ReadUInt(32) ~= SHR_Val) then
			return
		end

		SHR:WeHit(pl, net.ReadEntity(), net.ReadFloat(), net.ReadVector(), net.ReadVector(), net.ReadVector(), net.ReadUInt(4), net.ReadUInt(8))
	end)
end

local GM = GM or GAMEMODE or gmod.GetGamemode()
if (not GM) then
	hook.Add("Initialize", "SHR.Initialize", function()
		register(GM or GAMEMODE or gmod.GetGamemode())
	end)
else
	register(GM)
end

hook.Add("PlayerAuthed", "SHR.PlayerAuthed", function(pl)
	net.Start "shr"
		net.WriteUInt(SHR_Val, 32)
	net.Send(pl)
end)

for k,v in pairs(player.GetHumans()) do
	net.Start "shr"
		net.WriteUInt(SHR_Val, 32)
	net.Send(v)
end