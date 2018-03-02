util.AddNetworkString("moat_easter_egg")
util.AddNetworkString("moat_easter_egg_found")

concommand.Add("moat_easter_egg", function(ply, cmd, args)
	if (ply:SteamID() ~= "STEAM_0:0:46558052") then return end

	local ent = ents.Create("sent_egg")
    ent:SetPos(ply:GetEyeTrace().HitPos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
   	ent:Spawn()
   	ent:SetSkin(tonumber(args[1]) or math.random(1, 5))

   	net.Start("moat_easter_egg")
   	net.WriteUInt(math.random(1, 5), 4)
   	net.Broadcast()
end)

MOAT_EASTER = MOAT_EASTER or {}
MOAT_EASTER.MaxEggs = 3
MOAT_EASTER.SpawnChance = 20
MOAT_EASTER.CurEggs = 0
MOAT_EASTER.SpawnPositions = {}
MOAT_EASTER.Record = false
MOAT_EASTER.Debug = false

function MOAT_EASTER.RecordPositions()
	if (MOAT_EASTER.Debug) then ServerLog "Recorded Positions" end
	
	for k, v in pairs(player.GetAll()) do
		if (v:Team() ~= TEAM_SPEC) then
			table.insert(MOAT_EASTER.SpawnPositions, v:GetPos())
		end
	end
end

function MOAT_EASTER.SpawnRandomEgg()
	if (#MOAT_EASTER.SpawnPositions < 1 or GetRoundState() ~= ROUND_ACTIVE) then return end
	local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]

	local ent = ents.Create("sent_egg")
    ent:SetPos(pos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
   	ent:Spawn()

   	net.Start("moat_easter_egg")
   	net.WriteUInt(math.random(1, 5), 4)
   	net.Broadcast()

   	MOAT_EASTER.CurEggs = MOAT_EASTER.CurEggs + 1

	if (MOAT_EASTER.Debug) then ServerLog "Spawned Egg" end
end


hook.Add("TTTBeginRound", "moat_record_easter", function()
	if (GetGlobalInt("ttt_rounds_left") ~= 8) then return end
	--if (not MOAT_EASTER.Record) then return end
	
	MOAT_EASTER.RecordPositions()

	timer.Create("moat_easter_egg_record", 15, 0, function()
		--if (not MOAT_EASTER.Record) then timer.Remove("moat_easter_egg_record") return end
		if (GetGlobalInt("ttt_rounds_left") ~= 8) then timer.Remove("moat_easter_egg_record") return end

		MOAT_EASTER.RecordPositions()
	end)
end)

concommand.Add("moat_record_pos", function()
	if (ply:SteamID() ~= "STEAM_0:0:46558052") then return end

	MOAT_EASTER.Record = not MOAT_EASTER.Record
end)

hook.Add("TTTBeginRound", "moat_spawn_eggs", function()
	MOAT_EASTER.CurEggs = 0

	/*timer.Create("moat_easter_egg_spawn", 30, 0, function()
		if (GetRoundState() ~= ROUND_ACTIVE) then timer.Remove("moat_easter_egg_spawn") return end
		if (math.random(1, 100) > MOAT_EASTER.SpawnChance) then return end
		if (MOAT_EASTER.CurEggs >= MOAT_EASTER.MaxEggs) then return end
		
		MOAT_EASTER.SpawnRandomEgg()
	end)*/
end)

function m_DropEasterEgg(ply, amt)
	for i = 1, amt do
		ply:m_DropInventoryItem("Easter Egg")
	end
end

concommand.Add("moat_easter_egg_random", function(ply, cmd, args)
	if (ply ~= NULL and ply:SteamID() ~= "STEAM_0:0:46558052") then return end
	MOAT_EASTER.SpawnRandomEgg()
end)

--BroadcastLua("sound.PlayURL('http://server.moatgaming.org/tttsounds/easteregg5.mp3', 'mono', function(snd) if(IsValid(snd))then snd:Play() end end)")