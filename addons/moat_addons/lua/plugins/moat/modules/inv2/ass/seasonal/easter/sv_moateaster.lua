util.AddNetworkString("moat_easter_egg")
util.AddNetworkString("moat_easter_egg_found")
util.AddNetworkString("moat_easter_basket_found")

concommand.Add("moat_easter_egg", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	local ent = ents.Create("sent_egg")
    ent:SetPos(ply:GetEyeTrace().HitPos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
   	ent:Spawn()
   	ent:SetSkin(tonumber(args[1]) or math.random(1, 5))

   	-- net.Start("moat_easter_egg")
   	-- net.WriteUInt(math.random(1, 5), 4)
   	-- net.Broadcast()
end)


concommand.Add("moat_easter_basket", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	local ent = ents.Create("sent_egg_basket")
    ent:SetPos(ply:GetEyeTrace().HitPos + Vector(math.random(-48, 48), math.random(-48, 48), 16))
   	ent:Spawn()
   	ent:SetSkin(tonumber(args[1]) or math.random(1, 5))
end)

MOAT_EASTER = MOAT_EASTER or {}
MOAT_EASTER.MaxEggs = math.random(1, 5)
MOAT_EASTER.SpawnChance = 5
MOAT_EASTER.CurEggs = 0
MOAT_EASTER.MapEggs = 0

MOAT_EASTER.SpawnPositions = {}
MOAT_EASTER.Record = false
MOAT_EASTER.Debug = false

function MOAT_EASTER.RecordPositions()
	if (MOAT_EASTER.Debug) then ServerLog "Recorded Positions" end
	
	for k, v in ipairs(player.GetAll()) do
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

   	-- net.Start("moat_easter_egg")
   	-- net.WriteUInt(math.random(1, 5), 4)
   	-- net.Broadcast()

	MOAT_EASTER.MapEggs = MOAT_EASTER.MapEggs + 1
   	MOAT_EASTER.CurEggs = MOAT_EASTER.CurEggs + 1

	if (MOAT_EASTER.Debug) then ServerLog "Spawned Egg" end
end

function MOAT_EASTER.SpawnRandomEasterBasket()
	if (#MOAT_EASTER.SpawnPositions < 1 or GetRoundState() ~= ROUND_ACTIVE) then return end
	local pos = MOAT_EASTER.SpawnPositions[math.random(1, #MOAT_EASTER.SpawnPositions)]

	local ent = ents.Create("sent_egg_basket_adv")
    ent:SetPos(pos + Vector(0, 0, 16))
   	ent:Spawn()

	-- net.Start("moat_easter_egg")
   	-- net.WriteUInt(math.random(1, 5), 4)
   	-- net.Broadcast()

   	MOAT_EASTER.MapEggs = MOAT_EASTER.MapEggs + 1
   	MOAT_EASTER.CurEggs = MOAT_EASTER.CurEggs + 1

	if (MOAT_EASTER.Debug) then ServerLog "Spawned Egg" end
end

local max_rounds = GetConVarNumber("ttt_round_limit")

hook.Add("TTTBeginRound", "moat_record_easter", function()
	if (GetGlobal("ttt_rounds_left") ~= (max_rounds - 2)) then return end
	--if (not MOAT_EASTER.Record) then return end

	MOAT_EASTER.RecordPositions()

	timer.Create("moat_easter_egg_record", 15, 0, function()
		--if (not MOAT_EASTER.Record) then timer.Remove("moat_easter_egg_record") return end
		if (GetGlobal("ttt_rounds_left") ~= (max_rounds - 2)) then timer.Remove("moat_easter_egg_record") return end

		MOAT_EASTER.RecordPositions()
	end)
end)

concommand.Add("moat_record_pos", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end

	MOAT_EASTER.Record = not MOAT_EASTER.Record
end)

-- hook.Add("TTTBeginRound", "moat_spawn_easter_basket", function()
-- 	MOAT_EASTER.CurEggs = 0

-- 	timer.Create("moat_easter_egg_spawn", 60, 0, function()
-- 		if (player.GetCount() < 8) then return end
-- 		if (GetRoundState() ~= ROUND_ACTIVE or GetGlobal("MOAT_MINIGAME_ACTIVE")) then timer.Remove("moat_easter_egg_spawn") return end
-- 		if (math.random(1, 100) <= MOAT_EASTER.SpawnChance) then return end
-- 		if (MOAT_EASTER.CurEggs >= 1) then return end
-- 		if (MOAT_EASTER.MapEggs >= MOAT_EASTER.MaxEggs) then return end

-- 		if (math.random(2) == 2) then
-- 			MOAT_EASTER.SpawnRandomEasterBasket()
-- 		else
-- 			MOAT_EASTER.SpawnRandomEgg()
-- 		end
-- 	end)
-- end)

hook.Add("TTTEndRound", function()
	timer.Remove("moat_easter_egg_spawn")
end)

function m_DropEasterBasket(ply, amt)
	for i = 1, amt do
		timer.Simple(i, function() ply:m_DropInventoryItem("Easter Basket", "hide_chat_obtained") end)
	end
end

function m_DropEasterEgg(ply, amt)
	for i = 1, amt do
		timer.Simple(i, function() ply:m_DropInventoryItem("Easter Egg", "hide_chat_obtained") end)
	end
end

concommand.Add("moat_easter_egg_random", function(ply, cmd, args)
	if (not moat.isdev(ply)) then return end
	MOAT_EASTER.SpawnRandomEgg()
end)

--BroadcastLua("sound.PlayURL('http://server.moatgaming.org/tttsounds/easteregg5.mp3', 'mono', function(snd) if(IsValid(snd))then snd:Play() end end)")