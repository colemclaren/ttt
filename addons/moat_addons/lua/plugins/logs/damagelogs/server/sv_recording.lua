
util.AddNetworkString("M_DL_AskDeathScene")
util.AddNetworkString("M_DL_SendDeathScene")
util.AddNetworkString("M_DL_UpdateLogEnt")

Damagelog.Records = Damagelog.Records or {}
Damagelog.Death_Scenes = Damagelog.Death_Scenes or {}
Damagelog.SceneID = Damagelog.SceneID or 0

local magneto_ents = {}

hook.Add("TTTBeginRound", "TTTBeginRound_SpecDMRecord", function()
	Damagelog.Records = {}
	magneto_ents = {}

	for k,ply in ipairs(player.GetAll()) do
		ply.SpectatingLog = false
	end
end)

timer.Create("SpecDM_Recording", 0.5, 0, function()
	if not GetRoundState or GetRoundState() != ROUND_ACTIVE then return end
	if #Damagelog.Records >= 50 then
		table.remove(Damagelog.Records, 1)
	end
	
	local tbl = {}

	local pls = player.GetAll()
	for i = 1, #pls do
		local v = pls[i]
		if (not IsValid(v)) then continue end
		if (v:IsSpec()) then
			local rag = v.server_ragdoll
			if (not IsValid(rag)) then continue end
			tbl[v:Nick()] = {
				corpse = true,
				pos = pos,
				ang = ang,
				found = CORPSE.GetFound(rag, false)
			}

			continue
		end

		local wep = v:GetActiveWeapon()
		tbl[v:Nick()] = {
			pos = v:GetPos(),
			ang = v:GetAngles(),
			sequence = v:GetSequence(),
			hp = v:Health(),
			wep = IsValid(wep) and wep:GetClass() or "<no wep>",
			role = v:GetRole()
		}
		if IsValid(wep) and wep:GetClass() == "weapon_zm_carry" and IsValid(wep.EntHolding) then
			if (not magneto_ents[wep.EntHolding]) then magneto_ents[wep.EntHolding] = {} end
			magneto_ents[wep.EntHolding].last_saw = CurTime()
		end
	end
	
	for k, v in pairs(magneto_ents) do
		if (IsValid(k) and v.last_saw and v.last_saw > (CurTime() - 15)) then
			table.insert(tbl, k:EntIndex(), {
				model = k:GetModel(),
				pos = k:GetPos(),
				ang = k:GetAngles()
			})
		else
			magneto_ents[k] = nil 
			continue
		end
	end

	table.insert(Damagelog.Records, tbl)
end)

net.Receive("M_DL_AskDeathScene", function(_, ply)
	local ID = net.ReadUInt(32)
	local ply1 = net.ReadString()
	local ply2 = net.ReadString()
	local scene = Damagelog.Death_Scenes[ID]
	if scene then
		local encoded = util.TableToJSON(scene)
		local compressed = util.Compress(encoded)
		net.Start("M_DL_SendDeathScene")
		net.WriteString(ply1)
		net.WriteString(ply2)
		net.WriteUInt(#compressed, 32)
		net.WriteData(compressed, #compressed)
		net.Send(ply)
	end
end)

hook.Add("Initialize", "DamagelogRecording", function()
	local old_think = GAMEMODE.KeyPress
	function GAMEMODE:KeyPress(ply, key)
		if not (ply.SpectatingLog and (key == IN_ATTACK or key == IN_ATTACK2)) then
			return old_think(self, ply, key)
		end
	end
end)