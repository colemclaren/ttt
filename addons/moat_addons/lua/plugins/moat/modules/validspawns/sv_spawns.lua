local MAX_PLAYER_SIZE = 72
local MAX_MAP_SIZE = 0x8000
local MIN_DISTANCE = 1000

local PLAYER_UNIT_SIZE = math.ceil(MAX_MAP_SIZE * 2 / MAX_PLAYER_SIZE)

local MAX_PLAYER_SQR = MAX_PLAYER_SIZE ^ 2

local function VectorToID(v)
    local r = math.floor((v.x + MAX_MAP_SIZE) / MAX_PLAYER_SIZE)
        + math.floor((v.y + MAX_MAP_SIZE) / MAX_PLAYER_SIZE) * PLAYER_UNIT_SIZE
        + math.floor((v.z + MAX_MAP_SIZE) / MAX_PLAYER_SIZE) * PLAYER_UNIT_SIZE * PLAYER_UNIT_SIZE
    return r
end

spawns = spawns or {
    GroupedPositions = {},
    Building = {},
    All = {}
}

if (true or not spawns.GroupedPositions[1]) then
    for i = 1, game.MaxPlayers() do
        spawns.Building[i] = setmetatable({}, {
            __index = function(self, k)
                self[k] = {n = 0}
                return self[k]
            end
        })
        spawns.GroupedPositions[i] = {n = 0}
    end
    spawns.All = {}
end

local function insert(t, v)
    local n = t.n + 1
    t.n, t[n] = n, v
    return n
end

local function PlayersToDistance(count)
    return count * 36
end

local function print() end

function spawns.AddValidPoint(v)
    local id = VectorToID(v)
    if (spawns.All[id]) then
        return
    end

    spawns.All[id] = v

    local vwithoutz = Vector(v.x, v.y, v.z)
    
    for count, building in pairs(spawns.Building) do
        local Distance = PlayersToDistance(count) ^ 2

        local found = false

        for _, positions in ipairs(spawns.GroupedPositions[count]) do
            if (math.abs(v.z - positions[1].z) > 100) then
                continue
            end

            vwithoutz.z = positions[1].z
            if (positions[1]:DistToSqr(vwithoutz) < Distance) then
                found = true

                break
            end
        end
        print(found)

        if (found) then
            continue
        end

        for pos, t in pairs(building) do
            local breakout = false

            for i = 1, t.n do
                local p = t[i]
                vwithoutz.z = p.z
                if (vwithoutz:DistToSqr(p) < MAX_PLAYER_SQR) then
                    breakout = true
                    break
                end
            end

            if (breakout) then
                continue
            end

            vwithoutz.z = pos.z
            print(math.abs(v.z - pos.z))
            if (math.abs(v.z - pos.z) < 200 and vwithoutz:DistToSqr(pos) < Distance) then
                found = true
                print "found"

                if (insert(t, v) == count) then
                    building[pos] = nil

                    insert(spawns.GroupedPositions[count], t)
                end
            end
        end

        if (not found) then
            if (insert(building[v], v) == count) then
                insert(spawns.GroupedPositions[count], building[v])
                building[v] = nil
            end
        end
    end
end

function spawns.GetSpotsForPlayers(x)
    return spawns.GroupedPositions[x]
end

local Testers = {
    NotNear = function(point, data)
        return point:Distance(data.Position) > data.Distance
    end,
    NotNearEntities = function(point, data)
        for _, ply in pairs(data.Entities) do
            if (ply:GetPos():Distance(point) < data.Distance) then
                return false
            end
        end
        return true
    end,
    Near = function(point, data)
        return point:Distance(data.Position) <= data.Distance
    end
}

function spawns.Find(where)
    local all = spawns.FindAll(where)
    return all[math.random(#all)]
end

function spawns.FindAll(where)
    assert(where.Amount, "Amount must be a number")

    local potential = spawns.GetSpotsForPlayers(where.Amount)

    local available = {}

    for i = potential.n, 1, -1 do
        local test = potential[i]

        for j = 1, test.n do
            local point = test[j]

            for clause, data in pairs(where) do
                if (Testers[clause] and not Testers[clause](point, data)) then
                    goto failed
                end
            end
        end

        available[#available + 1] = test
        ::failed::
    end

    return available
end

timer.Create("moat_TrackSpawnPointsForLibrary", 1, 0, function()
    for _, ply in pairs(player.GetAll()) do
        if (not ply:Alive() or ply:IsSpec() or IsValid(ply:GetGroundEntity()) or not ply:IsOnGround() or ply:WaterLevel() ~= 0) then
            continue
        end

        spawns.AddValidPoint(ply:GetPos())
    end
end)


concommand.Add("test_spawn_points_ammo", function(ply, cmd, args)
    if (not moat.isdev(ply)) then
        return
    end
    local n = tonumber(args[1])

    if (not n) then
        return
    end

    local positions = spawns.GetSpotsForPlayers(n)

    if (#positions == 0) then
        print "no positions available"
        return
    end

    positions = positions[math.random(1, positions.n)]

    for i = 1, n do
        local e = ents.Create("ttt_random_ammo")
        e:SetPos(positions[i])
        e:Spawn()
    end
end)

concommand.Add("test_spawn_points_players", function(ply, cmd, args)
    if (not moat.isdev(ply)) then
        return
    end
    local n = player.GetCount()

    if (not n) then
        return
    end

    local positions = spawns.GetSpotsForPlayers(n)

    if (#positions == 0) then
        print "no positions available"
        return
    end

    positions = positions[math.random(1, positions.n)]

    for i, ply in pairs(player.GetAll()) do
        MsgN(tostring(positions[i]) .. " " .. tostring(ply))
        ply:SetPos(positions[i])
    end
end)