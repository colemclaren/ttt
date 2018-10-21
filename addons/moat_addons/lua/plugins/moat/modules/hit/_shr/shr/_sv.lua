util.AddNetworkString "shr"
if (not SHR_Val) then SHR_Val = math.random(-99999999, 99999999) end

local ENTITY = FindMetaTable "Entity"
function ENTITY:HitRegCheck()
	return self:IsPlayer() and self:GetInfoNum("shr_enabled", 1) == 1 and self:PacketLoss() <= 10
end

SHR.Keys = {}
function SHR:PrepareForHit(p, dmg, dir, src, num)
	math.randomseed(p:GetCurrentCommand():CommandNumber())
	local k = p:EntIndex() .. "shr" .. math.random()

	SHR.Keys[k] = {p, {dmg, dir, p:GetEyeTraceNoCursor()}, p:GetActiveWeapon(), num}
	timer.Simple(2, function() SHR.Keys[k] = nil end)
end

function SHR.FireBullets(e, t)
	local p = e:HitRegCheck()
	if (p and t.Damage and t.Damage ~= 0) then
		SHR:PrepareForHit(e, t.Damage, t.Dir or Vector(), t.Src or Vector(), t.Num or 1)
		t.Damage = 0
		return true
	end
end
hook.Add("EntityFireBullets", "SHR.FireBullets", SHR.FireBullets)

SHR.Players = {}
function SHR:RemoveKey(s, pl, num)
	SHR.Keys[s][4] = SHR.Keys[s][4] - 1
	if (SHR.Keys[s][4] <= 0) then
		SHR.Players[pl] = num
		SHR.Keys[s] = nil
	end
end

function SHR:InvalidPosition(eye, pl, pos, ent, tr)
	local d1, d2 = eye:DistToSqr(tr.StartPos) > 5184, pos:DistToSqr(ent:GetPos()) > 5184
	if (d1 or d2) then return true end

	return util.TraceLine({start = eye, endpos = pos, filter = {pl, ent}}).HitWorld
end

function SHR:WeHit(k, s, ent, eye, pos, dmgfrc, hg)
	if (ent == k[1] or (ent:IsPlayer() and ent:GetObserverMode() ~= OBS_MODE_NONE)) then return end
	if (SHR.Players[k[1]] and SHR.Players[k[1]] == k[2][2]:LengthSqr()) then return end
	if (self.Config.WallChecks and self:InvalidPosition(eye, k[1], pos, ent, k[2][3])) then return end

	local dmginfo = DamageInfo()
	dmginfo:SetAttacker(k[1])
	dmginfo:SetDamage(k[2][1])
	dmginfo:SetDamageForce(dmgfrc)
	dmginfo:SetDamagePosition(pos)
	dmginfo:SetDamageType(DMG_BULLET)
	dmginfo:SetInflictor(k[3])

	if (ent:IsPlayer() and (hook.Run("ScalePlayerDamage", ent, hg, dmginfo) or hook.Run("PlayerShouldTakeDamage", ent, k[1]) == false)) then
		return
	end

	if (ent:IsNPC()) then hook.Run("ScaleNPCDamage", ent, hg, dmginfo) end

	ent:TakeDamageInfo(dmginfo)

	self:RemoveKey(s, k[1], k[2][2]:LengthSqr())
end

net.Receive("shr", function(_, pl)
	local v = net.ReadDouble()
	if (v ~= SHR_Val) then return end

	local s = net.ReadString()
	local k = SHR.Keys[s]
	if (not k or not IsValid(k[1]) or k[1] ~= pl) then return end
	if (pl:GetObserverMode() ~= OBS_MODE_NONE) then return end

	SHR:WeHit(k, s, net.ReadEntity(), net.ReadVector(), net.ReadVector(), net.ReadVector(), net.ReadUInt(4))
end)

hook.Add("PlayerAuthed", "SHR.PlayerAuthed", function(pl)
	net.Start "shr"
	net.WriteDouble(SHR_Val)
	net.Send(pl)
end)

function SHR.ClientChange(pl)
	local n = tostring(pl:GetInfoNum("shr_enabled", 1) == 1 and 0 or 1)
	pl:ConCommand("shr_enabled " .. n)
end

function SHR.IsCommand(str)
	local s, t = str:match("^!?/?(%w+)"), SHR.Config.Commands
	for i = 1, #t do if (s == t[i]) then return true end end

	return false
end

hook.Add("PlayerSay", "SHR.ChatCommands", function(pl, str)
	if (not SHR.Config.Commands) then return end
	if (SHR.IsCommand(str)) then SHR.ClientChange(pl) return "" end
end)


hook.Add("D3A_Initialize", "SHR.ChatCommands", function()
	if (not SHR.Config.Commands) then return end

	for k, v in pairs(SHR.Config.Commands) do
		table.insert(D3A.Config.IgnoreChatCommands, v)
	end
end)