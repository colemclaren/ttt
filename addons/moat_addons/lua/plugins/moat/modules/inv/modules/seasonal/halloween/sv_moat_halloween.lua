util.AddNetworkString("moat_halloween_pumpkin")
util.AddNetworkString("moat_halloween_pumpkin_found")

concommand.Add("moat_halloween_pumpkin", function(ply, cmd, args)
	if (ply:SteamID() ~= "STEAM_0:0:46558052") then return end

	local ent = ents.Create("sent_pumpkin")
    ent:SetPos(ply:GetEyeTrace().HitPos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
   	ent:Spawn()
   	ent:SetSkin(tonumber(args[1]) or math.random(1, 5))

   	net.Start("moat_halloween_pumpkin")
   	net.WriteUInt(math.random(1, 5), 4)
   	net.Broadcast()
end)

MOAT_PUMPKIN = MOAT_PUMPKIN or {}
MOAT_PUMPKIN.MaxEggs = 3
MOAT_PUMPKIN.SpawnChance = 10
MOAT_PUMPKIN.CurEggs = 0
MOAT_PUMPKIN.SpawnPositions = {}
MOAT_PUMPKIN.Record = false
MOAT_PUMPKIN.Debug = false

function MOAT_PUMPKIN.RecordPositions()
	if (MOAT_PUMPKIN.Debug) then ServerLog "Recorded Positions" end
	
	for k, v in pairs(player.GetAll()) do
		if (v:Team() ~= TEAM_SPEC) then
			table.insert(MOAT_PUMPKIN.SpawnPositions, v:GetPos())
		end
	end
end

function MOAT_PUMPKIN.SpawnRandom()
	if (#MOAT_EASTER.SpawnPositions < 1 or GetRoundState() ~= ROUND_ACTIVE) then return end
	local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]

	local ent = ents.Create("sent_pumpkin")
    ent:SetPos(pos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
   	ent:Spawn()

   	net.Start("moat_halloween_pumpkin")
   	net.WriteUInt(math.random(1, 5), 4)
   	net.Broadcast()

   	MOAT_PUMPKIN.CurEggs = MOAT_PUMPKIN.CurEggs + 1

	if (MOAT_PUMPKIN.Debug) then ServerLog "Spawned Egg" end
end


hook.Add("TTTBeginRound", "moat_record_easter", function()
	if (GetGlobalInt("ttt_rounds_left") ~= 8) then return end
	--if (not MOAT_PUMPKIN.Record) then return end
	
	MOAT_PUMPKIN.RecordPositions()

	timer.Create("moat_easter_egg_record", 15, 0, function()
		--if (not MOAT_PUMPKIN.Record) then timer.Remove("moat_easter_egg_record") return end
		if (GetGlobalInt("ttt_rounds_left") ~= 8) then timer.Remove("moat_easter_egg_record") return end

		MOAT_PUMPKIN.RecordPositions()
	end)
end)

concommand.Add("moat_record_pos", function()
	if (ply:SteamID() ~= "STEAM_0:0:46558052") then return end

	MOAT_PUMPKIN.Record = not MOAT_PUMPKIN.Record
end)

hook.Add("TTTBeginRound", "moat_spawn_pumpkins", function()
	MOAT_PUMPKIN.CurEggs = 0

	timer.Create("moat_pumpkin_spawn", 30, 0, function()
		local num = math.random(1, 100)

		if (GetRoundState() ~= ROUND_ACTIVE) then timer.Remove("moat_pumpkin_spawn") return end
		if (#player.GetAll() < 8) then return end
		if (num > MOAT_PUMPKIN.SpawnChance) then return end
		if (MOAT_PUMPKIN.CurEggs >= MOAT_PUMPKIN.MaxEggs) then return end
		
		MOAT_PUMPKIN.SpawnRandom()
	end)
end)

function m_DropPumpkin(ply, amt)
	for i = 1, amt do
		ply:m_DropInventoryItem("Pumpkin Crate")
	end
end

concommand.Add("moat_pumpkin_random", function(ply, cmd, args)
	if (ply ~= NULL and ply:SteamID() ~= "STEAM_0:0:46558052") then return end
	MOAT_PUMPKIN.SpawnRandom()
end)

--BroadcastLua("sound.PlayURL('http://server.moatgaming.org/tttsounds/easteregg5.mp3', 'mono', function(snd) if(IsValid(snd))then snd:Play() end end)")