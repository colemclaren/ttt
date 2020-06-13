EASTER = EASTER or {}

EASTER.Disabled = true
EASTER.BossChance = 0.05
EASTER.GoldenChance = 0.01

EASTER.TimeBetweenChances = 30
EASTER.EggSpawnChance = 0.25
EASTER.MaxSpawnPerRound = 2
EASTER.ChancesPerRound = 3

EASTER.ProtectAmount = 10

local function GetEggPositions()
    return spawns.FindAll {
        Amount = EASTER.ProtectAmount
    }
end

-- EASTER.EggSpawns = {pos, ...}

function EASTER.FindPlayerSpawns(amt)
    return spawns.FindAll {
        NotNear = {
            Position = EASTER.EggSpawns[1],
            Distance = 1000
        },
        Amount = amt or game.MaxPlayers() - 1
    }
end

function EASTER.FindRandomSpawns(amt)
    local r = EASTER.FindPlayerSpawns(amt)
    return r[math.random(#r)]
end

EASTER.HAS_DONE_BOSS = false

function EASTER.CanDoBoss()
    if (EASTER.HAS_DONE_BOSS or GetGlobal "ttt_rounds_left" <= 2) then
        return false
    end

    for _, eggpos in RandomPairs(GetEggPositions()) do
        EASTER.EggSpawns = eggpos
        local spawnpositions = EASTER.FindPlayerSpawns()

        if (#spawnpositions > 2) then
            return true
        end
    end
end

function EASTER.ReadyBoss(ply)
    if (not EASTER.CanDoBoss()) then
        print "cannot do boss"
        return
    end
    EASTER.HAS_DONE_BOSS = true
    ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You begin to feel funny..." )]])
    hook.Add("TTTPrepareRound", "moat_StartEasterBoss", function()
        hook.Remove("TTTPrepareRound", "moat_StartEasterBoss")
        if (not IsValid(ply)) then
            return
        end
        EASTER.StartEggStealer(ply, eggs)
    end)
end

function EASTER.SpawnEgg(pos)
    local egg = ents.Create("sent_egg_basket_adv")
    egg:SetPos(pos + Vector(0,0,22))
    egg:Spawn()
    
    cdn.PlayURL("https://static.moat.gg/servers/tttsounds/easter.mp3")
end
function EASTER.SpawnRandomEgg()
    EASTER.SpawnEgg(spawns.Find {
        Amount = 1
    }[1])
end

if (EASTER.Disabled) then
    return
end

hook.Add("TTTBeginRound", "moat_spawn_easter_basket", function()
	MOAT_EASTER.CurEggs = 0

    local spawned = 0
	timer.Create("moat_easter_egg_spawn_2019", EASTER.TimeBetweenChances, EASTER.ChancesPerRound, function()
		if (player.GetCount() < 8) then return end
        if (spawned > EASTER.MaxSpawnPerRound or GetRoundState() ~= ROUND_ACTIVE or GetGlobal("MOAT_MINIGAME_ACTIVE")) then
            timer.Remove("moat_easter_egg_spawn_2019")
            return
        end
		if (math.random() > EASTER.EggSpawnChance) then return end
		if (MOAT_EASTER.CurEggs >= 1) then return end
        if (MOAT_EASTER.MapEggs >= MOAT_EASTER.MaxEggs) then return end
        
        spawned = spawned + 1

        EASTER.SpawnRandomEgg()
	end)
end)

