util.AddNetworkString("dlogs.AskDeathScene")
util.AddNetworkString("dlogs.SendDeathScene")
util.AddNetworkString("dlogs.UpdateLogEnt")

dlogs.Records = dlogs.Records or {}
dlogs.Death_Scenes = dlogs.Death_Scenes or {}
dlogs.SceneID = dlogs.SceneID or 0

local magneto_ents = {}

local table = table

hook.Add("TTTBeginRound", "TTTBeginRound_SpecDMRecord", function()
	magneto_ents = {}
	dlogs.Records = {}

	for k,ply in ipairs(player.GetHumans()) do
		ply.SpectatingLog = false
	end
end)

timer.Create("SpecDM_Recording", 0.2, 0, function()

	if not GetRoundState or GetRoundState() != ROUND_ACTIVE then return end

	if #dlogs.Records >= 50 then
		table.remove(dlogs.Records, 1)
	end

	local tbl = {}

	for k,v in pairs(magneto_ents) do
		if v.record and CurTime() - v.last_saw > 15 then
			v.record = false
		end
	end

	for k,v in ipairs(player.GetHumans()) do
		if not v:IsActive() then
			local rag = v.server_ragdoll
			if IsValid(rag) then
				local pos,ang = rag:GetPos(), rag:GetAngles()
				tbl[v:GetdlogsID()] = {
					corpse = true,
					pos = pos,
					ang = ang,
					found = CORPSE.GetFound(rag, false)
				}
			end
		else
			local wep = v:GetActiveWeapon()
			tbl[v:GetdlogsID()] = {
				pos = v:GetPos(),
				ang = v:GetAngles(),
				sequence = v:GetSequence(),
				hp = v:Health(),
				wep = IsValid(wep) and wep:GetClass() or "<no wep>",
				role = v:GetRole()
			}
			if IsValid(wep) and wep:GetClass() == "weapon_zm_carry" and IsValid(wep.EntHolding) then
				local found = false
				for k,v in pairs(magneto_ents) do
					if v.ent == wep.EntHolding then
						found = k
						break
					end
				end
				if found then
					magneto_ents[found].last_saw = CurTime()
					magneto_ents[found].record = true
				else
					table.insert(magneto_ents, {
						ent = wep.EntHolding,
						record = true,
						last_saw = CurTime()
					})
				end
			end
		end
	end

	for k,v in pairs(magneto_ents) do
		if v.record and IsValid(v.ent) then
			table.insert(tbl, v.ent:EntIndex(), {
				prop = true,
				model = v.ent:GetModel(),
				pos = v.ent:GetPos(),
				ang = v.ent:GetAngles()
			})
		end
	end

	table.insert(dlogs.Records, tbl)

end)

net.Receive("dlogs.AskDeathScene", function(_, ply)
	local ID = net.ReadUInt(32)
	local ply1 = net.ReadUInt(32)
	local ply2 = net.ReadUInt(32)
	local scene = dlogs.Death_Scenes[ID]
	local roles = dlogs.Roles[dlogs.SceneRounds[ID]]
	if scene and roles then
		local sceneString = util.TableToJSON(scene)
		sceneString = util.Compress(sceneString)
		net.Start("dlogs.SendDeathScene")
			net.WriteUInt(ply1, 32)
			net.WriteUInt(ply2, 32)
			net.WriteTable(roles)
			net.WriteUInt(#sceneString, 32)
			net.WriteData(sceneString, #sceneString)
		net.Send(ply)
	end
end)

hook.Add("Initialize", "dlogsRecording", function()
	local old_think = GAMEMODE.KeyPress
	function GAMEMODE:KeyPress(ply, key)
		if not (ply.SpectatingLog and (key == IN_ATTACK or key == IN_ATTACK2)) then
			return old_think(self, ply, key)
		end
	end
end)
