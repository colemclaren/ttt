local a={}local b={lineinfo=true}local c={parent=true,ast=true}local function d(e,f,g)local h=type(e)=='string'and e:match'^[%a_][%w_]*$'and e or'['..a.dumpstring(e,f,g)..']'return h end;local function i(j,k)if type(j)=='number'and type(k)=='number'then return j<k elseif type(j)=='number'then return false elseif type(k)=='number'then return true elseif type(j)=='string'and type(k)=='string'then return j<k else return tostring(j)<tostring(k)end end;function a.dumpstring(l,f,m,n)f=f or{}m=m or''if type(l)=='table'then if f[l]or c[n]then return(type(l.tag)=='string'and'`'..l.tag..':'or'')..tostring(l)else f[l]=true end;local o={}local p=l.tag;local q='{'if type(l.tag)=='string'then q='`'..p..q;o['tag']=true end;local g=m..''local h={}for e in pairs(l)do h[#h+1]=e end;table.sort(h,i)local r;for e in pairs(l)do if type(e)=='number'and type(l[e])=='table'then r=true end end;for s,e in ipairs(h)do if o[e]then elseif b[e]then o[e]=true elseif(type(e)~='number'or not r)and type(e)~='table'and(type(l[e])~='table'or c[e])then q=q..d(e,f,g)..'='..a.dumpstring(l[e],f,g,e)..','o[e]=true end end;local t;for s,e in ipairs(h)do if not o[e]then if not t then q=q..''t=true end;q=q..g..d(e,f)..'='..a.dumpstring(l[e],f,g,e)..','end end;q=q:gsub(',(%s*)$','%1')q=q..(t and m or'')..'}'return q elseif type(l)=='string'then return string.format('%q',l)else return tostring(l)end end
--https://github.com/davidm/lua-inspect/blob/master/lib/luainspect/dump.lua
--used for generating examples so that we don't have to network so much shit

local function xp_needed(lvl)
    local mult = math.max(0, lvl - 20)

    return mult * 175 + 1250
end

local release_date = 1561708800
local function auth(ply)
    return true
    -- return moat.isdev(ply)
end

file.Write("dumpmeme.txt","")
local cached_droptable
util.AddNetworkString("BP.ItemExample")
util.AddNetworkString("BP.Chat")
function generate_bpexample(itemid,ply)
    local dropped_item = {}
    if not cached_droptable then
        cached_droptable = table.Copy(MOAT_DROPTABLE)
    end
    local item_to_drop = table.Copy(cached_droptable[itemid])
    dropped_item.u = itemid

        if (item_to_drop.Kind == "tier" or item_to_drop.Kind == "Unique") then
            dropped_item.s = {}
            local stats_to_apply = 0

            if (item_to_drop.MinStats and item_to_drop.MaxStats) then
                stats_to_apply = math.random(item_to_drop.MinStats, item_to_drop.MaxStats)
            end

            local stats_chosen = 0

            for k, v in RandomPairs(item_to_drop.Stats) do
                if (tostring(k) == "Damage") then
                    dropped_item.s.d = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Accuracy") then
                    dropped_item.s.a = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Kick") then
                    dropped_item.s.k = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Firerate") then
                    dropped_item.s.f = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Magazine") then
                    dropped_item.s.m = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Range") then
                    dropped_item.s.r = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Weight") then
                    dropped_item.s.w = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Reloadrate") then
                    dropped_item.s.y = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Deployrate") then
                    dropped_item.s.z = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Chargerate") then
                	dropped_item.s.c = math.Round(math.Rand(0, 1), 3)
            	end

                if (stats_to_apply > 0) then
                    stats_chosen = stats_chosen + 1
                    if (stats_chosen >= stats_to_apply) then break end
                end
            end

            dropped_item.w = ""

            if (item_to_drop.Collection == "Pumpkin Collection" or item_to_drop.Collection == "Omega Collection" or item_to_drop.Collection == "Holiday Collection" or item_to_drop.Collection == "New Years Collection") then
                for k, v in RandomPairs(weapons.GetList()) do
                    if (v.Base == "weapon_tttbase" and (v.ClassName:StartWith("weapon_ttt_te_") or v.AutoSpawnable)) then
                        dropped_item.w = v.ClassName
                        break
                    end
                end
            else
                for k, v in RandomPairs(weapons.GetList()) do
                    if (v.AutoSpawnable and v.Base == "weapon_tttbase" and ((item_to_drop.ID == 912 and not v.ViewModelFlip) or item_to_drop.ID ~= 912)) then
                        dropped_item.w = v.ClassName
                        break
                    end
                end
            end

            if (cmd_class and cmd_class ~= "endrounddrop") then
                local weapon_class_found = ""

                for k, v in RandomPairs(weapons.GetList()) do
                    if (v.AutoSpawnable and v.Base == "weapon_tttbase") then
                        weapon_class_found = v.ClassName
                    end

                    if (v.ClassName == cmd_class) then
                        weapon_class_found = v.ClassName
                        break
                    end
                end

                dropped_item.w = weapon_class_found
            end

            if (item_to_drop.Kind == "Unique" and item_to_drop.WeaponClass) then
                dropped_item.w = item_to_drop.WeaponClass
            end

            if (item_to_drop.MinTalents and item_to_drop.MaxTalents and item_to_drop.Talents) then
                dropped_item.s.l = 1
                dropped_item.s.x = 0
                dropped_item.t = {}
                local talents_chosen = {}
                local talents_to_loop = dev_talent_tbl or item_to_drop.Talents

                for k, v in ipairs(talents_to_loop) do
                    talents_chosen[k] = m_GetRandomTalent(k, v, false)
                end

                for i = 1, table.Count(talents_chosen) do
                    local talent_tbl = talents_chosen[i]
                    dropped_item.t[i] = {}
                    dropped_item.t[i].e = talent_tbl.ID
                    dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
                    dropped_item.t[i].m = {}

                    for k, v in ipairs(talent_tbl.Modifications) do
                        dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
                    end
                end
            end
        elseif (item_to_drop.Kind == "Melee") then
            dropped_item.s = {}
            local stats_to_apply = 0

            if (item_to_drop.MinStats and item_to_drop.MaxStats) then
                stats_to_apply = math.random(item_to_drop.MinStats, item_to_drop.MaxStats)
            end

            local stats_chosen = 0

            for k, v in RandomPairs(item_to_drop.Stats) do
                if (tostring(k) == "Damage") then
                    dropped_item.s.d = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Firerate") then
                    dropped_item.s.f = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Pushrate") then
                    dropped_item.s.p = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Force") then
                    dropped_item.s.v = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Weight") then
                    dropped_item.s.w = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Reloadrate") then
                    dropped_item.s.y = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Deployrate") then
                    dropped_item.s.z = math.Round(math.Rand(0, 1), 3)
                elseif (tostring(k) == "Chargerate") then
                	dropped_item.s.c = math.Round(math.Rand(0, 1), 3)
            	end

                if (stats_to_apply > 0) then
                    stats_chosen = stats_chosen + 1
                    if (stats_chosen >= stats_to_apply) then break end
                end
            end

            dropped_item.w = ""

            if (item_to_drop.WeaponClass) then
                dropped_item.w = item_to_drop.WeaponClass
            end

            if (math.random(2) == 1) then
                dropped_item.s.l = 1
                dropped_item.s.x = 0
                dropped_item.t = {}
                local talents_chosen = {}
                local talents_to_loop = {"random"}
				
				if (math.random(3) == 1) then
					table.insert(talents_to_loop, "random")
					if (math.random(5) == 1) then
						table.insert(talents_to_loop, "random")
					end
				end

				if (dev_talent_tbl) then
					talents_to_loop = dev_talent_tbl
				end

                for k, v in ipairs(talents_to_loop) do
                    talents_chosen[k] = m_GetRandomTalent(k, v, true)
                end

                for i = 1, table.Count(talents_chosen) do
                    local talent_tbl = talents_chosen[i]
                    dropped_item.t[i] = {}
                    dropped_item.t[i].e = talent_tbl.ID
                    dropped_item.t[i].l = math.random(talent_tbl.LevelRequired.min, talent_tbl.LevelRequired.max)
                    dropped_item.t[i].m = {}

                    for k, v in ipairs(talent_tbl.Modifications) do
                        dropped_item.t[i].m[k] = math.Round(math.Rand(0, 1), 2)
                    end
                end
            end
        elseif ((item_to_drop.Kind == "Power-Up" or item_to_drop.Kind == "Special" or item_to_drop.Kind == "Usable") and item_to_drop.Stats) then
            dropped_item.s = {}

            for i = 1, #item_to_drop.Stats do
                dropped_item.s[i] = math.Round(math.Rand(0, 1), 3)
            end
        end

        dropped_item.c = util.CRC(os.time() .. SysTime())
        dropped_item.item = {}
        dropped_item.item = m_GetItemFromEnum(itemid)
        if (dropped_item.t) then
            dropped_item.Talents = {}

            for k, v in ipairs(dropped_item.t) do
                dropped_item.Talents[k] = m_GetTalentFromEnum(v.e)
            end
        end
        if (not isbool(ply)) and IsValid(ply) then
            net.Start("BP.ItemExample")
            net.WriteInt(itemid,16)
            net.WriteTable(dropped_item)
            net.Send(ply)
        else
            return ("MOAT_BP.AddExample(" .. itemid .. "," .. a.dumpstring(dropped_item):gsub("\n","n") .. ")\n")
        end
end

function bp_randomdump()
    local tbl = table.Copy(MOAT_DROPTABLE)
    local s_id = ""
    local s_ex = ""
    for i = 1,100 do
        local r,id = table.Random(MOAT_DROPTABLE)
        local e = r.NameEffect
        if not e then e = "" end
        local name = r.Name
        if r.Kind == "tier" then
            name = "A " .. name .. " Weapon"
        end
        s_id = s_id .. "add_tier_item([[" .. name .. "]]," .. r.Rarity .. ",[[" .. (r.Image and r.Image or r.Model and r.Model or r.WeaponClass and r.WeaponClass or "tier") .. "]]," .. id .. ",[[" .. (e) .. "]])\n"
        s_ex = s_ex .. generate_bpexample(id,true)
        file.Write("Dumpmeme.txt",s_id .. "\n\n\n" .. s_ex)
    end
    print("Wrote 100 random tiers + examples to data/dumpmeme.txt")
end

function bp_exportexamples()
    local s = ""
    for k,v in pairs(MOAT_BP.tiers) do
        if not MOAT_DROPTABLE[v.ID] then continue end
        s = s .. generate_bpexample(v.ID,true)
    end
    file.Write("dumpmeme.txt",s)
    print("Exported examples to data/dumpmeme.txt")
end



net.Receive("BP.ItemExample",function(l,ply)
    if not auth(ply) then return end
    if (ply.BPItemCool or 0) > CurTime() then return end
    ply.BPItemCool = CurTime() + 4.8
    local itemid = net.ReadInt(16)
    if not MOAT_BP.Examples[itemid] then return end -- requested item not in battlepass
    generate_bpexample(itemid,ply)
end)

local function c()
    return MINVENTORY_MYSQL and MINVENTORY_MYSQL:status() == mysqloo.DATABASE_CONNECTED
end
util.AddNetworkString("BP.StatUpdate")
function bp_sql()
    local db = MINVENTORY_MYSQL
    db:query("CREATE TABLE IF NOT EXISTS `moat_battlepass` (`steamid` varchar(32), `tier` INT, `xp` INT, PRIMARY KEY (steamid) );"):start()


    function bp_loadplayer(ply)
        if not auth(ply) then return end
        local q = db:query("SELECT * FROM moat_battlepass WHERE steamid = '" .. ply:SteamID64() .. "';")
        function q:onSuccess(d)
            if #d < 1 then
                ply.bp = {
                    xp = 0,
                    tier = 0
                }
            else
                ply.bp = {
                    xp = d[1].xp,
                    tier = d[1].tier
                }
            end
            net.Start("BP.StatUpdate")
            net.WriteInt(ply.bp.tier,16)
            net.WriteInt(ply.bp.xp,32)
            net.Send(ply)
        end
        q:start()
    end

    hook.Add("PlayerInitialSpawn","BattlePass",function(ply)
        if not auth(ply) then return end
        bp_loadplayer(ply)
    end)

    function bp_save(ply,fun)
        if not auth(ply) then return end
        if not ply.bp then return end
        print("Saving",ply,ply.bp.xp,ply.bp.tier)
        local q = db:query("INSERT INTO moat_battlepass (steamid,tier,xp) VALUES ('" .. ply:SteamID64() .. "', '" .. ply.bp.tier .. "', '" .. ply.bp.xp .. "') ON DUPLICATE KEY UPDATE xp = '" .. ply.bp.xp .. "', tier = '" .. ply.bp.tier .. "';")
        net.Start("BP.StatUpdate")
        net.WriteInt(ply.bp.tier,16)
        net.WriteInt(ply.bp.xp,32)
        net.Send(ply)
        function q:onSuccess()
            if fun then fun() end
        end
        q:start()
    end

    local ext = {
        [1] = "st",
        [2] = "nd",
        [3] = "rd"
    }

    local function extension(num)
        return ext[num % 10] or "th"
    end

    function bp_checkstats(lowest_tier)
        lowest_tier = lowest_tier or 1
        local values = {}
        for _, dev in pairs(Devs) do
            values[#values + 1] = db:escape(dev.SteamID64)
        end

        local q = db:query("SELECT tier, count(*) as players FROM `moat_battlepass` WHERE steamid NOT IN (" .. table.concat(values, ", ") .. ") and tier >= \"" .. db:escape(tostring(lowest_tier)) .. "\" group by tier order by tier desc")
        function q:onSuccess()
            local data = q:getData()
            local players = 0
            for _, d in pairs(data) do
                players = players + d.players
            end

            local cur = 0
            for _, d in ipairs(data) do
                cur = cur + d.players
                local percentile = math.Round(100 - (cur - 1) / players * 100)
                print(string.format("Tier %2i - (%3i%s percentile) - %3i player%s", d.tier, percentile, extension(percentile), d.players, d.players == 1 and "" or "s"))
            end
        end
        q:start()
    end

    function bp_checkhighest(ply)
        -- check if tier is noteworthy
        if (ply.bp.tier % 5 ~= 0 and ply.bp.tier < 75) then
            return
        end

        local values = {}
        for _, dev in pairs(Devs) do
            values[#values + 1] = db:escape(dev.SteamID64)
        end


        local q = db:query("SELECT tier as highest_tier, count(*) as players FROM `moat_battlepass` WHERE steamid NOT IN (" .. table.concat(values, ", ") .. ") group by tier order by highest_tier desc")
        function q:onSuccess()
            local data = q:getData()
            if (data and data[1] and data[1].highest_tier == ply.bp.tier and data[1].players == 1) then
                local msg = string(
                    string.rep("<:winner:299563022752546817>", 16),
                    style.NewLine "<:winner:299563022752546817> The first person to tier <:wow:392153478266355712> " .. style.Bold(tonumber(ply.bp.tier)) .. " <:wow:392153478266355712> is...",
                    style.NewLine "<:winner:299563022752546817>  " .. style.Bold(ply:Nick()) .. style.Dot(style.Code(ply:SteamID())) .. style.Dot(ply:SteamURL()),
                    string.NewLine(string.rep("<:winner:299563022752546817>", 16))
                )
                discord.Send("Event", msg)
            end
        end

        function q:onError(e)
            print(e)
        end
        q:start()
    end

    local custom_rewards = {
        [-1] = function(ply)
            ply:m_GiveIC(5000)
        end,
        [-2] = function(ply)
            ply:m_GiveIC(10000)
        end,
        [-3] = function(ply)
            local crates = m_GetActiveCrates()
            for i = 1, 5 do
                ply:m_DropInventoryItem(crates[math.random(1, #crates)].Name, "hide_chat_obtained", false, false)
            end
        end,
        [-4] = function(ply)
            local crates = m_GetActiveCrates()
            for i = 1, 10 do
                ply:m_DropInventoryItem(crates[math.random(1, #crates)].Name, "hide_chat_obtained", false, false)
            end
        end,
        [-5] = function(ply)

        end
    }
    function bp_reward(ply,tier)
        if not auth(ply) then return end
        net.Start("BP.Chat")
        net.WriteBool(true)
        net.WriteInt(tier,32)
        net.Send(ply)
        local tier = MOAT_BP.tiers[tier]
        if custom_rewards[tier.ID] then
            custom_rewards[tier.ID](ply)
        else
            ply:m_DropInventoryItem(MOAT_DROPTABLE[tier.ID].Name)
        end
    end

    function bp_processxp(ply,xp)
        if not auth(ply) then return end
        if not Server.IsDev and player.GetCount() < 5 then return end
        if not ply.bp then
            bp_loadplayer(ply) 
            return
        end
        local tier = ply.bp.tier
        if tier == 100 then return end -- over!
        local plyxp = ply.bp.xp
        print("Processing ",xp,"xp for",ply)
        if (xp + plyxp) >= xp_needed(tier + 1) then
            bp_reward(ply,tier + 1)
            ply.bp.xp = (plyxp + xp) - xp_needed(tier + 1)
            ply.bp.tier = tier + 1
            print("Rewarded ",ply,"for tier",tier,"new xp:",ply.bp.xp)
            if ply.bp.xp > xp_needed(tier + 2) then
                print("Player has more levels, repeating")
                bp_processxp(ply,0) -- recursive
            else
                bp_save(ply)
                bp_checkhighest(ply)
                print("No more levels, saving",ply,xp)
            end
        else
            ply.bp.xp = plyxp + xp
            print("New xp, no reward: ",ply.bp.xp)
            bp_save(ply)
            net.Start("BP.Chat")
            net.WriteBool(false)
            net.WriteInt(ply.bp.tier,32)
            net.WriteInt(ply.bp.xp,32)
            net.Send(ply)
        end
    end

    hook.Add("PlayerEarnedXP","Add BattlePass XP",function(ply,xp)
        if not auth(ply) then return end
        if xp < 0 then return end
        print("EARNED XP",MG_cur_event,xp)
        if MG_cur_event == "Quadra XP" then 
            xp = xp
        end
        xp = xp * 2
        print("XP TO PROCESS",xp)
        bp_processxp(ply,xp)
    end)

end

if MINVENTORY_MYSQL then
    if c() then
        bp_sql()
    end
end

hook.Add("InitPostEntity","BattlePassSQL",function()
    if not c() then 
        timer.Create("CheckBattlePass",1,0,function()
            if c() then
                bp_sql()
                timer.Destroy("CheckBattlePass")
            end
        end)
    else
        bp_sql()
    end

end)