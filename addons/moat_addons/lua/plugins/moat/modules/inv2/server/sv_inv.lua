print("Server Loaded")

util.AddNetworkString("MOAT_SEND_SLOTS")
util.AddNetworkString("MOAT_SEND_INV_ITEM")
util.AddNetworkString("MOAT_ADD_INV_ITEM")
util.AddNetworkString("MOAT_REM_INV_ITEM")
util.AddNetworkString "MOAT_REM_INV_ITEMS"
util.AddNetworkString("MOAT_LOCK_INV_ITEM")
util.AddNetworkString("MOAT_SWP_INV_ITEM")
util.AddNetworkString("MOAT_SEND_TRADE_REQ")
util.AddNetworkString("MOAT_INV_CAT")
util.AddNetworkString("MOAT_RESPOND_TRADE_REQ")
util.AddNetworkString("MOAT_INIT_TRADE")
util.AddNetworkString("MOAT_RESPOND_TRADE")
util.AddNetworkString("MOAT_SEND_CREDITS")
util.AddNetworkString("MOAT_TRADE_MESSAGE")
util.AddNetworkString("MOAT_TRADE_CREDITS")
util.AddNetworkString("MOAT_TRADE_CAT")
util.AddNetworkString("MOAT_TRADE_ADD")
util.AddNetworkString("MOAT_TRADE_REM")
util.AddNetworkString("MOAT_TRADE_SWAP")
util.AddNetworkString("MOAT_TRADE_STATUS")
util.AddNetworkString("MOAT_TRADE_FAIL")
util.AddNetworkString("MOAT_UPDATE_EXP")
util.AddNetworkString("MOAT_GET_ROLL_ITEMS")
util.AddNetworkString("MOAT_APPLY_MODELS")
util.AddNetworkString("MOAT_VERIFY_CRATE")
util.AddNetworkString("MOAT_INIT_CRATE")
util.AddNetworkString("MOAT_CRATE_OPEN")
util.AddNetworkString("MOAT_CRATE_DONE")
util.AddNetworkString("MOAT_ITEMS_CRATE")
util.AddNetworkString("MOAT_LINK_ITEM")
util.AddNetworkString("MOAT_OBTAIN_ITEM")
util.AddNetworkString("MOAT_ITEM_OBTAINED")
util.AddNetworkString("MOAT_MAX_SLOTS")
util.AddNetworkString("MOAT_GET_SHOP")
util.AddNetworkString("MOAT_BUY_ITEM")
util.AddNetworkString("MOAT_CHAT_LINK_ITEM")
util.AddNetworkString("MOAT_USE_USABLE")
util.AddNetworkString("MOAT_INIT_USABLE")
util.AddNetworkString("MOAT_END_USABLE")
util.AddNetworkString("MOAT_USE_NAME_MUTATOR")
util.AddNetworkString("MOAT_REM_NAME_MUTATOR")
util.AddNetworkString("MOAT_DECON_NOTIFY")
util.AddNetworkString("MOAT_DECON_MUTATOR")
util.AddNetworkString("MOAT_CRATE_PREVIEW")
util.AddNetworkString "MOAT_REM_TINT"
util.AddNetworkString "MOAT_REM_PAINT"
util.AddNetworkString "MOAT_REM_TEXTURE"
util.AddNetworkString "MOAT_UPDATE_MODEL_POS"

MOAT_TRADES = MOAT_TRADES or {}
local meta = FindMetaTable("Player")

function meta:m_getInvCat()
    return self.CurrentInvCat
end

function meta:m_isTrading()
    return self:GetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
end

MOAT_MAX_SLOTS = MOAT_MAX_SLOTS or {}
function meta:SetMaxSlots(num)
	MOAT_MAX_SLOTS[self] = num
	net.Start("MOAT_MAX_SLOTS")
    net.WriteDouble(self:GetMaxSlots())
    net.Send(self)

    return self:SetNW2Int("MOAT_MAX_INVENTORY_SLOTS", num)
end

function meta:GetMaxSlots()
    return MOAT_MAX_SLOTS[self] or self:GetNW2Int("MOAT_MAX_INVENTORY_SLOTS", 40)
end

function meta:UpgradeMaxSlots()
    local new_slots = self:GetMaxSlots() + 5
	MOAT_MAX_SLOTS[self] = new_slots
    self:SetNW2Int("MOAT_MAX_INVENTORY_SLOTS", new_slots)
    m_SaveMaxSlots(self)

	return new_slots
end

concommand.Add("moat_reload", function(pl)
	if (not moat.isdev(pl)) then return end

	crate_cache = {}
	item_cache = {}
	talent_cache = {}
	item_cache2 = {}
	talent_cache2 = {}

	m_InitializeItems()
	m_InitializeTalents()
end)

local rarity_text = {
	[0] = { "a Stock" }, 
	[1] = { "a Worn", 13421823 }, 
	[2] = { "a Standard" }, 
	[3] = { "a Specialized" }, 
	[4] = { "a Superior" }, 
	[5] = { "a High-End" }, 
	[6] = { "an Ascended", 16769792 }, 
	[7] = { "a Cosmic", 130847 }, 
	[8] = { "an Extinct", 16747008 }, 
	[9] = { "a Planetary", 65535 }
}

local stats_full = {}
stats_full["d"] = "DMG"
stats_full["f"] = "RPM"
stats_full["m"] = "MAG"
stats_full["a"] = "Accuracy"
stats_full["k"] = "Kick"
stats_full["r"] = "Range"
stats_full["w"] = "Weight"
stats_full["x"] = "XP"
stats_full["l"] = "Level"
stats_full["p"] = "Push Delay"
stats_full["v"] = "Push Force"
stats_full["y"] = "Reload"
stats_full["z"] = "Draw"
stats_full["c"] = "Charging Speed"
local function addstats(itemtbl,embed)
    local wpntbl = weapons.Get(itemtbl.w)
    local stat_sign = "+"
    local stat_color = m_color_green
    local wpn_dmg = math.Round(wpntbl.Primary.Damage, 1)
    local wpn_rpm = math.Round(60 * (1 / wpntbl.Primary.Delay))
    local wpn_mag = math.ceil(wpntbl.Primary.ClipSize)

    if (itemtbl.s) then
        if (itemtbl.s.d) then
            wpn_dmg = math.Round(wpntbl.Primary.Damage * (1 + ((itemtbl.item.Stats.Damage.min + ((itemtbl.item.Stats.Damage.max - itemtbl.item.Stats.Damage.min) * itemtbl.s.d)) / 100)), 1)
        end

        if (itemtbl.s.f) then
            local firerate_mult = 1 - (itemtbl.item.Stats.Firerate.min + (itemtbl.item.Stats.Firerate.max - itemtbl.item.Stats.Firerate.min) * itemtbl.s.f) / 100
            wpn_rpm = math.Round(60 / (firerate_mult * wpntbl.Primary.Delay))
        end

        if (itemtbl.s.m) then
            wpn_mag = math.ceil(wpntbl.Primary.ClipSize * (1 + ((itemtbl.item.Stats.Magazine.min + ((itemtbl.item.Stats.Magazine.max - itemtbl.item.Stats.Magazine.min) * itemtbl.s.m)) / 100)))
        end
    end

    local stat_num = 0
    local small_y = 0
    local stats_y_add = 40
    local stats_y_multi = 25

    if (wpntbl.Primary.NumShots and wpntbl.Primary.NumShots > 1) then
        wpn_dmg = wpn_dmg .. "*" .. wpntbl.Primary.NumShots -- ×
    end

    if (wpn_mag < 1) then
        wpn_mag = "∞"
    end

    local default_stats = {"DMG", "RPM", "MAG"}
    local level_stats = {"XP", "Level"}
    local dmg_,rpm_,mag_ = "","",""
    for k, v in SortedPairs(default_stats) do
        if (v == "DMG") then

            if (itemtbl.s.d) then
                stat_min, stat_max = m_GetStatMinMax("d", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.d), 1)
                stat_sign = "+ "

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                end

                dmg_ = stat_sign .. stat_num .. "%" 

            else
                dmg_ = "+-0%"
            end
        elseif (v == "RPM") then

            if (itemtbl.s.f) then
                stat_min, stat_max = m_GetStatMinMax("f", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.f), 1)
                stat_sign = "+ "

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                end


                rpm_ = stat_sign .. stat_num .. "%"

            else
                rpm_ = "+-0%"
            end
        elseif (v == "MAG") then

            if (itemtbl.s.m) then
                stat_min, stat_max = m_GetStatMinMax("m", itemtbl)
                stat_num = math.Round(stat_min + ((stat_max - stat_min) * itemtbl.s.m), 1)
                stat_sign = "+ "

                if (string.StartWith(tostring(stat_num), "-")) then
                    stat_sign = ""
                end

                stat_num = wpn_mag - wpntbl.Primary.ClipSize

                mag_ = stat_sign .. stat_num
            else
                mag_ = "+-0"
            end
        end
    end

    embed.fields = {
        {
            name = "**DMG: " .. wpn_dmg .. "**",
            value = "```diff\n" .. dmg_ .. "```",
            inline = true
        },
        {
            name = "**RPM: " .. wpn_rpm .. "**",
            value = "```diff\n" .. rpm_ .. "```",
            inline = true
        },
        {
            name = "**MAG: " .. wpn_mag .. "**",
            value = "```diff\n" .. mag_ .. "```",
            inline = true
        }
    }
    local i = 0
    for k, v in SortedPairs(itemtbl.s) do
        local stat_min, stat_max = m_GetStatMinMax(k, itemtbl)
        local stat_num = math.Round(stat_min + ((stat_max - stat_min) * v), 1)
        stat_sign = "+"

        if (string.StartWith(tostring(stat_num), "-")) then
            stat_sign = ""
        end
        
        local stat_str = stats_full[tostring(k)]
        local plus = math.Round(math.Remap(stat_num,stat_min,stat_max,1,20)) or 1

        if (not table.HasValue(default_stats, stat_str) and not table.HasValue(level_stats, stat_str)) then
            table.insert(embed.fields,{
                name = stat_str .. ": " .. stat_sign .. stat_num .. "% `(" .. stat_min .. " to " .. stat_max .. ")`",
                value = ("[▰](http://moat.gg)"):rep(plus) .. ("▱"):rep(20 - plus)  ,
                inline = false
            })
        end
    end
    if (itemtbl.t) then
        local talents_s = "s"
        local num_talents = table.Count(itemtbl.t)

        if (num_talents == 1) then
            talents_s = ""
        end

        table.insert(embed.fields,{
            name = "\\_\\_\\_\\_\\_\\_\\_\\_\\_\\_",
            value = "**" .. num_talents .. " Talent" .. talents_s .. "**"
        })

        local talent_name = ""
        local talent_desc = ""
        local talent_level = 0

        for k, v in ipairs(itemtbl.t) do
            talent_name = itemtbl.Talents[k].Name
            talent_desc = itemtbl.Talents[k].Description
            talent_level = v.l

            local talent_desctbl = string.Explode("^", talent_desc)

            for i = 1, table.Count(v.m) do
                local mod_num = "[" .. math.Round(itemtbl.Talents[k].Modifications[i].min + ((itemtbl.Talents[k].Modifications[i].max - itemtbl.Talents[k].Modifications[i].min) * math.min(1, v.m[i])), 1) .. "](http://moat.gg)"
                talent_desctbl[i] = string.format(talent_desctbl[i], tostring(mod_num))
            end

            talent_desc = string.Implode("", talent_desctbl)
            talent_desc = string.Replace(talent_desc, "_", "%")
            table.insert(embed.fields,{
                name = talent_name .. " | Level " .. talent_level,
                value = talent_desc
            })
        end
    end

    

end

local function getiteminfo(ITEM_HOVERED,embed)
    local m_LoadoutTypes = {}
    m_LoadoutTypes[1] = "Melee"
    m_LoadoutTypes[2] = "Secondary"
    m_LoadoutTypes[3] = "Primary"
    local ITEM_NAME_FULL = GetItemName(ITEM_HOVERED)
    if (ITEM_HOVERED and ITEM_HOVERED.c) then

        if (ITEM_HOVERED.item.Kind == "tier") then
            local ITEM_NAME = util.GetWeaponName(ITEM_HOVERED.w) or wpnstr

            if (string.EndsWith(ITEM_NAME, "_name")) then
                ITEM_NAME = string.sub(ITEM_NAME, 1, ITEM_NAME:len() - 5)
                ITEM_NAME = string.upper(string.sub(ITEM_NAME, 1, 1)) .. string.sub(ITEM_NAME, 2, ITEM_NAME:len())
            end

            ITEM_NAME_FULL = ITEM_HOVERED.item.Name .. " " .. ITEM_NAME

            if (ITEM_HOVERED.item.Rarity == 0) then
                ITEM_NAME_FULL = ITEM_NAME
            end
        else
            ITEM_NAME_FULL = ITEM_HOVERED.item.Name
        end
        ITEM_NAME_FULL = "**" .. ITEM_NAME_FULL .. "**"
        ITEM_NAME_FULL = string.format(ITEM_NAME_FULL, "@", "#")
    end

    if (ITEM_HOVERED.s and ITEM_HOVERED.s.l) then
        -- item_str = item_str .. " - LVL **" .. ITEM_HOVERED.s.l .. "** - XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100)
        ITEM_NAME_FULL = ITEM_NAME_FULL .. " - LVL **" .. ITEM_HOVERED.s.l .. "** - XP: " .. ITEM_HOVERED.s.x .. "/" .. (ITEM_HOVERED.s.l * 100)
    end

    local RARITY_TEXT = ""

    if (ITEM_HOVERED.item.Kind ~= "tier") then
        RARITY_TEXT = rarity_text[ITEM_HOVERED.item.Rarity][1] .. " " .. ITEM_HOVERED.item.Kind
    else
        RARITY_TEXT = rarity_text[ITEM_HOVERED.item.Rarity][1] .. " " .. m_LoadoutTypes[weapons.Get(ITEM_HOVERED.w).Kind]
    end

    embed.author.name = embed.author.name .. " has obtained " .. RARITY_TEXT .. "!"

    embed.description = ITEM_NAME_FULL

    if ITEM_HOVERED.item.Image then
        embed.thumbnail = {
            url = ITEM_HOVERED.item.Image
        }
    end

    if (ITEM_HOVERED.s and (ITEM_HOVERED.item.Kind == "tier" or ITEM_HOVERED.item.Kind == "Unique" or ITEM_HOVERED.item.Kind == "Melee")) then
        addstats(ITEM_HOVERED,embed)
    else
        local item_desc = ITEM_HOVERED.item.Description

        if (ITEM_HOVERED.s) then
            for i = 1, #ITEM_HOVERED.s do
                local item_stat = ITEM_HOVERED.item.Stats[i].min + ((ITEM_HOVERED.item.Stats[i].max - ITEM_HOVERED.item.Stats[i].min) * math.min(1, ITEM_HOVERED.s[i]))
                item_desc = string.format(item_desc, math.Round(item_stat, 2))
            end
        end

        item_desc = string.Replace(item_desc, "_", "%")

        embed.description = ITEM_NAME_FULL .. "\n" .. item_desc .. ""
    end
    embed.footer = {
        text = "From the " .. ITEM_HOVERED.item.Collection .. ""
    }
    embed.author.name = string.format(embed.author.name,"@","#")
    embed.timestamp = os.date("!%Y-%m-%dT%H:%M:%S.000Z",os.time())
    embed.color = rarity_text[ITEM_HOVERED.item.Rarity][2] or 0
    return embed
end

local function discord_post(ply,item,image,gift)
    local embed = {
        author = {
            name = ply:Nick() .. " (" .. ply:SteamID() .. ") (lvl" .. ply:GetNW2Int("MOAT_STATS_LVL", 1)..")",
            icon_url = image,
            url = "https://steamcommunity.com/profiles/" .. ply:SteamID64()
        },
        fields = {}
    }
    if not gift then
        embed = getiteminfo(item,embed)
    end

    discord.Embed("Drop",embed)
end

local function discord_drop(ply,item,gift)
    http.Fetch("https://api.steampowered.com/ISteamUser/GetPlayerSummaries/v2/?key=13E8032658377F036842094BDD9E7000&steamids=" .. ply:SteamID64() .. "&format=json", function(body, size, headers, code)
        local response = util.JSONToTable(body).response
        local plyInfo
        local image
        if istable(response) then
            if response.players[1] then
                plyInfo = response.players[1]
                image = plyInfo.avatarfull
            end
        end

        discord_post(ply,item,image or false,gift)
    end,function(error) -- steam down
        discord_post(ply,item,false,gift)
    end)
end

function meta:m_AddInventoryItem(tbl, delay_saving, no_chat, gift)
    local ply_inv = table.Copy(MOAT_INVS[self])
    local slot_found, upgrade = 0, false

    for i = 1, self:GetMaxSlots() do
        if (ply_inv["slot" .. i].c) then
            continue
        else
            slot_found = i
            break
        end
    end

    if (slot_found == 0) then
        slot_found = self:GetMaxSlots() + 1
        self:UpgradeMaxSlots()

		if (delay_saving and type(delay_saving) == "boolean") then
        	net.Start("MOAT_MAX_SLOTS")
        	net.WriteDouble(self:GetMaxSlots())
        	net.Send(self)
		end

        local max_slots = self:GetMaxSlots()
        local max_slots_old = max_slots - 4

        for i = max_slots_old, max_slots do
            MOAT_INVS[self]["slot" .. i] = {}
        end

		upgrade = true
    end

    MOAT_INVS[self]["slot" .. slot_found] = tbl

    if (delay_saving and type(delay_saving) == "boolean") then return end

	-- self.NetDelay = self.NetDelay or 1
    -- timer.Simple(self.NetDelay * 0.01, function()
		if (IsValid(self)) then
			net.Start("MOAT_ADD_INV_ITEM")
			net.WriteUInt(slot_found, 16)
			local tbl2 = table.Copy(MOAT_INVS[self]["slot" .. slot_found])
			-- tbl2.item = GetItemFromEnum(tbl2.u)
			-- tbl2.Talents = GetItemTalents(tbl2)

			-- net.WriteTable(tbl2)
			m_WriteWeaponToNet(tbl2)
			net.WriteBool(no_chat or false)
			net.WriteBool(upgrade)
			if (upgrade) then net.WriteUInt(self:GetMaxSlots(), 16) end
			net.Send(self)


			net.Start("MOAT_OBTAIN_ITEM")
			net.WriteBool(no_chat or false)
			net.WriteDouble(self:EntIndex())
			-- net.WriteTable(tbl2)
			m_WriteWeaponToNet(tbl2)
			net.WriteBool(gift or false)
			if (not no_chat) then
				net.Broadcast()
				net.Start("MOAT_ITEM_OBTAINED")
				-- net.WriteTable(tbl2)
				m_WriteWeaponToNet(tbl2)
				net.Send(self)

				tbl2.item = GetItemFromEnum(tbl2.u)
				tbl2.Talents = GetItemTalents(tbl2)
				if ((tbl2.item and tbl2.item.Rarity) and tbl2.item.Rarity > 5 and (not gift) and not tbl2.item.IgnoreDiscord) then
					discord_drop(self,tbl2,gift)
				end
			else
				net.Send(self)
			end

			-- self.NetDelay = math.max(0, self.NetDelay - 1)
		end
	-- end)

    if (delay_saving == nil) then
        m_SaveInventory(self)
    end

	-- self.NetDelay = self.NetDelay + 1
end

-- concommand.Add("m_testdrop",function()
--     discord_drop(Entity(1),test_memetable,false)
-- end)

function meta:m_GetIC()
    return math.floor(tonumber(MOAT_INVS[self]["credits"].c))
end

function meta:m_SetIC(num_credits)
    MOAT_INVS[self]["credits"].c = math.floor(num_credits)
    m_SaveCredits(self)
end

function meta:m_GiveIC(num_credits)
    local current_credits = MOAT_INVS[self]["credits"].c
    MOAT_INVS[self]["credits"].c = current_credits + num_credits
    m_SaveCredits(self)
end

function meta:m_TakeIC(num_credits, dont_save)
    local current_credits = MOAT_INVS[self]["credits"].c

    if (current_credits - num_credits < 0) then
        MOAT_INVS[self]["credits"].c = 0
    else
        MOAT_INVS[self]["credits"].c = current_credits - num_credits
    end

    if (dont_save) then return end

    m_SaveCredits(self)
end

function meta:m_HasIC(num_credits)
    if num_credits ~= num_credits then return end
    local current_credits = MOAT_INVS[self]["credits"].c
    local can_afford = true

    if (current_credits - num_credits < 0) then
        can_afford = false
    end

    return can_afford
end

concommand.Add("moat_ic", function(ply, cmd, args)
    if (moat.isdev(ply)) then
        local pl = ply
        if (args[3]) then
            pl = player.GetBySteamID(args[3])
        end
        local cmd2tbl = {
            ["give"] = function()
                pl:m_GiveIC(args[2])
            end,
            ["take"] = function()
                pl:m_TakeIC(args[2])
            end,
            ["set"] = function()
                pl:m_SetIC(args[2])
            end
        }

        cmd2tbl[args[1]]()
    end
end)

function m_SendInventorySwapFail(ply)
    net.Start("MOAT_SWP_INV_ITEM")
    net.WriteBool(false)
    net.Send(ply)
end

local m_LoadoutLabels = {"Primary", "Secondary", "Melee", "Power-Up", "Special", "Head", "Mask", "Body", "Effect", "Model"}
local m_SlotToLoadout = {}
m_SlotToLoadout[1] = "Melee"
m_SlotToLoadout[2] = "Secondary"
m_SlotToLoadout[3] = "Primary"

--[[ WEAPON TYPES (CAN ONLY CARRY ONE OF EACH)
WEAPON_MELEE  = 1
WEAPON_PISTOL = 2
WEAPON_HEAVY  = 3
WEAPON_NADE   = 4
WEAPON_CARRY  = 5
WEAPON_EQUIP1 = 6
WEAPON_EQUIP2 = 7
WEAPON_ROLE   = 8
]]
function m_CanSwapLoadout(ITEM_TBL, DRAG_SLOT)
    if (ITEM_TBL.c == nil) then return true end

    if (ITEM_TBL.item.Kind == "Power-Up") then
        return DRAG_SLOT == 4
    elseif (ITEM_TBL.item.Kind == "Special") then
        return DRAG_SLOT == 5
    elseif (ITEM_TBL.item.Kind == "Hat") then
        return DRAG_SLOT == 6
    elseif (ITEM_TBL.item.Kind == "Mask") then
        return DRAG_SLOT == 7
    elseif (ITEM_TBL.item.Kind == "Body") then
        return DRAG_SLOT == 8
    elseif (ITEM_TBL.item.Kind == "Effect") then
        return DRAG_SLOT == 9
    elseif (ITEM_TBL.item.Kind == "Model") then
        return DRAG_SLOT == 10
    elseif (ITEM_TBL.item.Kind == "tier" or ITEM_TBL.item.Kind == "Unique" or ITEM_TBL.item.Kind == "Melee") then
        local weapon_slot = weapons.Get(ITEM_TBL.w).Kind

        return m_SlotToLoadout[weapon_slot] == m_LoadoutLabels[DRAG_SLOT]
    end

    return false
end

local REEQUIP_TBL = {}

hook.Add("TTTPrepareRound", "moat_RefreshReequipTable", function()
    REEQUIP_TBL = {}
end)

function m_ReEquipLoadout(ply, slot1, slot2)
    if (ply:IsSpec() or GetRoundState() ~= ROUND_PREP) then return end

    /* Disabled to see if it fixes something or allows a problem
	if (GetGlobal("ttt_round_end") - CurTime() > 27) then
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "Re-Equipping too early! Please try again!" )]])

        return
    end
	*/

    local load_slot = slot1

    if (string.StartWith(slot2, "l")) then
        load_slot = slot2
    end

    local slot_num = tonumber(string.sub(load_slot, 7, #load_slot))
    if (slot_num > 5) then return end
    local pri_wep, sec_wep, melee_wep, powerup, tactical = m_GetLoadout(ply)
    local load_tbl = {pri_wep, sec_wep, melee_wep, powerup, tactical}
    local load_tbl_num = 0

    for i = 1, 5 do
        if (i == slot_num) then
            load_tbl_num = i
            continue
        end

        load_tbl[i] = {}
    end

    if (slot_num <= 2) then
        if (not REEQUIP_TBL[ply]) then
            REEQUIP_TBL[ply] = {}
        end

        if (load_tbl[load_tbl_num] and load_tbl[load_tbl_num].c and REEQUIP_TBL[ply][load_tbl[load_tbl_num].c]) then
            return
        elseif (load_tbl[load_tbl_num] and load_tbl[load_tbl_num].c) then
            REEQUIP_TBL[ply][load_tbl[load_tbl_num].c] = true
        end
    end

    m_GivePlayerLoadout(ply, load_tbl[1], load_tbl[2], load_tbl[3], load_tbl[4], load_tbl[5], true)
end

net.Receive("MOAT_SWP_INV_ITEM", function(len, ply)
    local slot1 = net.ReadString()
    local slot2 = net.ReadString()
    local slot1_c = tostring(net.ReadLong())
    local slot2_c = tostring(net.ReadLong())

    local inv_slot1 = table.Copy(MOAT_INVS[ply][slot1])
    local inv_slot2 = table.Copy(MOAT_INVS[ply][slot2])
	local inv_slot1_i = table.Copy(inv_slot1)
	local inv_slot2_i = table.Copy(inv_slot2)

	if (not inv_slot1_i or not inv_slot2_i) then
        m_SendInventorySwapFail(ply)
        return
	end

    inv_slot1_i.item = GetItemFromEnum(inv_slot1_i.u)
    inv_slot2_i.item = GetItemFromEnum(inv_slot2_i.u)

    if (inv_slot1 and inv_slot1.c and inv_slot1.c ~= slot1_c and not ply:m_isTrading()) then
        m_SendInventorySwapFail(ply)
        return
    end

    if (inv_slot2 and inv_slot2.c and inv_slot2.c ~= slot2_c and not ply:m_isTrading()) then
        m_SendInventorySwapFail(ply)
        return
    end


    if (string.StartWith(slot2, "l") and not string.StartWith(slot1, "l")) then
        local DRAG_SLOT = tonumber(string.sub(slot2, 7, #slot2))

        if (not m_CanSwapLoadout(inv_slot1_i, DRAG_SLOT)) then
            ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You cannot equip that item there!" )]])

            return
        end
    elseif (not string.StartWith(slot2, "l") and string.StartWith(slot1, "l")) then
        local HVRD_SLOT = tonumber(string.sub(slot1, 7, #slot1))

        if (not m_CanSwapLoadout(inv_slot2_i, HVRD_SLOT)) then
            ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You cannot equip that item there!" )]])

            return
        end
    elseif (string.StartWith(slot2, "l") and string.StartWith(slot1, "l")) then
        local HVRD_SLOT = tonumber(string.sub(slot1, 7, #slot1))
        local DRAG_SLOT = tonumber(string.sub(slot2, 7, #slot2))

        if (not m_CanSwapLoadout(inv_slot1_i, DRAG_SLOT)) then
            ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You cannot equip that item there!" )]])

            return
        end

        if (not m_CanSwapLoadout(inv_slot2_i, HVRD_SLOT)) then
            ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You cannot equip that item there!" )]])

            return
        end
    end

    net.Start("MOAT_SWP_INV_ITEM")
    net.WriteBool(true)
    net.WriteString(slot1)
    net.WriteString(slot2)
    net.Send(ply)

    MOAT_INVS[ply][slot1] = inv_slot2
    MOAT_INVS[ply][slot2] = inv_slot1

    if (string.StartWith(slot2, "l") or string.StartWith(slot1, "l")) then
		m_ReEquipLoadout(ply, slot1, slot2)
		m_SaveInventory(ply)
    end
end)

function m_RemoveInventoryItem(ply, slot, class, crate, save)
    local ply_inv = MOAT_INVS[ply]
    local item_enum = 0
    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            item_enum = MOAT_INVS[ply][k].u
            MOAT_INVS[ply][k] = {}
            net.Start("MOAT_REM_INV_ITEM")
			local s = string.gsub(k, "slot", "")
            net.WriteDouble(tonumber(s))
            net.WriteDouble(class)
            net.Send(ply)
            items_found = items_found + 1

			if (save == nil or save == true) then
				m_SaveInventory(ply)
			end

			if (crate and crate == 1) then
				break
			end

			if (items_found == 1) then
				hook.Run("PlayerDeconstructedItem", ply, item_enum)
			end
        end
    end
end

net.ReceiveNoLimit("MOAT_REM_INV_ITEM", function(len, ply)
    local slot = net.ReadDouble()
    local class = net.ReadDouble()
    local crate = net.ReadDouble()

    if (crate and crate == 3) then ply.Deconing = true end
    if (crate and crate == 2) then ply.Deconing = false end

    m_RemoveInventoryItem(ply, slot, class, crate)
end)

net.ReceiveNoLimit("MOAT_REM_INV_ITEMS", function(len, ply)
	local decon = net.ReadUInt(16) or 1
	for i = 1, decon do
		local slot = net.ReadDouble()
		if (not slot) then continue end
		local class = net.ReadDouble()
		if (not class) then continue end
		local crate = net.ReadDouble()
		if (not crate) then continue end
	
		if (crate and crate == 3) then ply.Deconing = true end
		if (crate and crate == 2) then ply.Deconing = false end

		m_RemoveInventoryItem(ply, slot, class, crate, i == decon)
	end
end)

local function m_SendTradeReq(ply, otherply)
    local other_ply = otherply
    local ent = Entity(otherply)
    
    if (not IsValid(ent) or not ent:IsPlayer()) then return end

    if (ply.IsTradeBanned or ent.IsTradeBanned) then
		D3A.Chat.SendToPlayer2(ply, Color(200, 0, 0), "Currently trade banned")
        return
    end

    if (ent:m_isTrading() or ent.UsingUsable) then
        net.Start("MOAT_SEND_TRADE_REQ")
        net.WriteBool(false)
        net.WriteBool(false)
        net.WriteDouble(other_ply)
        net.Send(ply)

        return
    end
    ent.PendingResponse = true
    net.Start("MOAT_SEND_TRADE_REQ")
    net.WriteBool(true)
    net.WriteBool(true)
    net.WriteDouble(other_ply)
    net.Send(ply)
    net.Start("MOAT_SEND_TRADE_REQ")
    net.WriteBool(true)
    net.WriteBool(false)
    net.WriteDouble(ply:EntIndex())
    net.Send(ent)
end


net.Receive("MOAT_SEND_TRADE_REQ", function(len, ply)
    local otherply = net.ReadDouble()

    local _otherply = Entity(otherply)
    if (not IsValid(_otherply) or _otherply:IsActive()) then
        return
    end

	if (_otherply == ply) then
		return
	end

    if (ply.trade_spam and ply.trade_spam > CurTime()) then
        return
    end

    m_SendTradeReq(ply, otherply)
    ply.trade_spam = CurTime() + 10
end)

local trade_key_stored = 1

function m_InitializeTrade(ply1, ply2)
    if ply1 == ply2 then return end
    ply1:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", true)
    ply2:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", true)
    trade_key_stored = trade_key_stored + 1
    local trade_key = trade_key_stored

    MOAT_TRADES[trade_key] = {
        player1 = {
            index = ply1:EntIndex(),
            accept = 0,
            empty_slots = 0,
            offers = {ic = 0, items = {}}
        },
        player2 = {
            index = ply2:EntIndex(),
            accept = 0,
            empty_slots = 0,
            offers = {ic = 0, items = {}}
        }
    }

    for i = 1, 10 do
        MOAT_TRADES[trade_key].player1.offers.items["slot" .. i] = {}
        MOAT_TRADES[trade_key].player2.offers.items["slot" .. i] = {}
    end

    net.Start("MOAT_INIT_TRADE")
    net.WriteDouble(ply2:EntIndex())
    net.WriteDouble(trade_key)
    net.Send(ply1)
    if (ply1 == ply2) then return end
    net.Start("MOAT_INIT_TRADE")
    net.WriteDouble(ply1:EntIndex())
    net.WriteDouble(trade_key)
    net.Send(ply2)
end

net.Receive("MOAT_RESPOND_TRADE_REQ", function(len, ply)
    local accepted = net.ReadBool()
    local other_ply = net.ReadDouble()
    if not ply.PendingResponse then return end
    ply.PendingResponse = false
    if (ply:m_isTrading()) then
        return
    end

    if (ply.UsingUsable) then
        net.Start("moat.comp.chat")
        net.WriteString("You cannot trade while using a usable item!")
        net.WriteBool(true)
        net.Send(ply)

        return
    end

	if (not IsValid(Entity(other_ply))) then
        net.Start("moat.comp.chat")
        net.WriteString("The other player for the trade left or something.")
        net.WriteBool(true)
        net.Send(ply)

		return
	end

    if (Entity(other_ply):m_isTrading()) then
        net.Start("MOAT_SEND_TRADE_REQ")
        net.WriteBool(false)
        net.WriteBool(false)
        net.WriteDouble(other_ply)
        net.Send(ply)

        return
    end

    if (not accepted) then
        net.Start("MOAT_RESPOND_TRADE_REQ")
        net.WriteBool(false)
        net.WriteDouble(ply:EntIndex())
        net.Send(Entity(other_ply))

        return
    else
        if (Entity(other_ply).UsingUsable) then
            net.Start("moat.comp.chat")
            net.WriteString("Unable to accept trade, other player is using a usable item!")
            net.WriteBool(true)
            net.Send(ply)

            return
        end

        net.Start("MOAT_RESPOND_TRADE_REQ")
        net.WriteBool(true)
        net.WriteDouble(ply:EntIndex())
        net.Send(Entity(other_ply))
        m_InitializeTrade(Entity(other_ply), ply)
    end
end)

net.Receive("MOAT_INV_CAT", function(len, ply)
    local inv_cat = net.ReadDouble()
    net.Start("MOAT_INV_CAT")
    net.WriteDouble(inv_cat)
    net.WriteBool(ply:m_isTrading())
    net.Send(ply)

    if (ply:Team() ~= TEAM_SPEC) then
        net.Start("moat_InventoryCatChange")
        net.WriteUInt(inv_cat, 4)
        net.WriteEntity(ply)
        net.Broadcast()
    end

    if (ply:m_isTrading()) then
        for k, v in pairs(MOAT_TRADES) do
            if (ply:EntIndex() == v.player1.index or ply:EntIndex() == v.player2.index) then
                net.Start("MOAT_TRADE_CAT")
                net.WriteDouble(tonumber(k))
                net.WriteDouble(inv_cat)

                if (ply:EntIndex() ~= v.player1.index) then
                    net.Send(Entity(v.player1.index))
                else
                    net.Send(Entity(v.player2.index))
                end
            end
        end
    end
end)

net.Receive("MOAT_RESPOND_TRADE", function(len, ply)
    local accepted = net.ReadBool()
    local ply_int = net.ReadDouble()
    local other_ply = Entity(ply_int)
    local trade_id = net.ReadDouble()

    if (not accepted) then
        local t = MOAT_TRADES[trade_id]
        if (not t) then return end
        
        Entity(t.player1.index):SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
        Entity(t.player2.index):SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)

        net.Start("MOAT_RESPOND_TRADE")
        net.WriteBool(false)
        net.WriteDouble(ply:EntIndex())
        net.Send(other_ply)

		net.Start("MOAT_RESPOND_TRADE")
        net.WriteBool(false)
        net.WriteDouble(ply:EntIndex())
        net.Send(ply)
    end

    /*
        for k, v in pairs(MOAT_TRADES) do
            if (tostring(k) == tostring(trade_id)) then
                local ply1 = Entity(v.player1.index)
                local ply2 = Entity(v.player2.index)
                ply1:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
                ply2:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
                net.Start("MOAT_RESPOND_TRADE")
                net.WriteBool(false)
                net.WriteDouble(ply:EntIndex())
                net.Send(other_ply)
            end
        end
    end*/
end)

net.Receive("MOAT_TRADE_MESSAGE", function(len, ply)
    local ply_int = net.ReadDouble()
    local trade_id = net.ReadDouble()
    local message = net.ReadString()

    local t = MOAT_TRADES[trade_id]
    if (not t) then return end
    if (not t.ChatLog) then t.ChatLog = {} end
    if (#t.ChatLog > 49) then
        table.remove(t.ChatLog, 1)
    end

    table.insert(t.ChatLog, ply:Nick() .. ": " .. message:gsub("\n", ""))



    net.Start("MOAT_TRADE_MESSAGE")
    net.WriteString(message)
    net.WriteDouble(trade_id)
    net.WriteDouble(ply:EntIndex())
    net.Send(Entity(t.player1.index))

    if (t.player2.index ~= t.player1.index) then
        net.Start("MOAT_TRADE_MESSAGE")
        net.WriteString(message)
        net.WriteDouble(trade_id)
        net.WriteDouble(ply:EntIndex())
        net.Send(Entity(t.player2.index))
    end

    /*
    for k, v in pairs(MOAT_TRADES) do
        if (tostring(k) == tostring(trade_id)) then
            if (not v.ChatLog) then
                MOAT_TRADES[k].ChatLog = {}
            end
            if (#MOAT_TRADES[k].ChatLog > 49) then
                table.remove(MOAT_TRADES[k].ChatLog, 1)
            end

            table.insert(MOAT_TRADES[k].ChatLog, ply:Nick() .. ": " .. message:gsub("\n", ""))



            net.Start("MOAT_TRADE_MESSAGE")
            net.WriteString(message)
            net.WriteDouble(trade_id)
            net.WriteDouble(ply:EntIndex())
            net.Send(Entity(v.player1.index))

            if (v.player2.index ~= v.player1.index) then
                net.Start("MOAT_TRADE_MESSAGE")
                net.WriteString(message)
                net.WriteDouble(trade_id)
                net.WriteDouble(ply:EntIndex())
                net.Send(Entity(v.player2.index))
            end
        end
    end*/
end)

local trade_processing = {}
util.AddNetworkString("MOAT_TRADED_ITEMS")
function m_InitTradeAccept(trade_id)
    local trade_tbl = MOAT_TRADES[trade_id]
    if (not trade_tbl) then return end
    if (trade_processing[trade_id]) then return end
    trade_processing[trade_id] = true

    local offer_table1_classes = {}
    local offer_table1_items = table.Copy(trade_tbl.player1.offers.items)
    local offer_table1_ic = trade_tbl.player1.offers.ic or 0
    local offer_player1 = Entity(trade_tbl.player1.index)

    for k, v in pairs(offer_table1_items) do
        if (v.c) then
            table.insert(offer_table1_classes, v.c)
        end
    end

    local offer_table2_classes = {}
    local offer_table2_items = table.Copy(trade_tbl.player2.offers.items)
    local offer_table2_ic = trade_tbl.player2.offers.ic or 0
    local offer_player2 = Entity(trade_tbl.player2.index)

    for k, v in pairs(offer_table2_items) do
        if (v.c) then
            table.insert(offer_table2_classes, v.c)
        end
    end
    if not trade_tbl.ChatLog then trade_tbl.ChatLog = {} end

    if (not offer_player1:m_HasIC(offer_table1_ic)) then 
        offer_player1:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
        offer_player2:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
        net.Start("MOAT_RESPOND_TRADE")
        net.WriteBool(false)
        net.WriteDouble(offer_player2:EntIndex())
        net.Send(offer_player1)
        net.Start("MOAT_RESPOND_TRADE")
        net.WriteBool(false)
        net.WriteDouble(offer_player1:EntIndex())
        net.Send(offer_player2)

        trade_tbl = nil

        discord.Send("Trade", "Hey, " .. offer_player1:SteamID() .. " tried to trade IC they don't have with " .. offer_player2:SteamID() .. "! <@207612500450082816>")
        MOAT_TRADES[trade_id] = nil
        return
    end

    if (not offer_player2:m_HasIC(offer_table2_ic)) then
        offer_player1:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
        offer_player2:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
        net.Start("MOAT_RESPOND_TRADE")
        net.WriteBool(false)
        net.WriteDouble(offer_player2:EntIndex())
        net.Send(offer_player1)
        net.Start("MOAT_RESPOND_TRADE")
        net.WriteBool(false)
        net.WriteDouble(offer_player1:EntIndex())
        net.Send(offer_player2)

        trade_tbl = nil

        discord.Send("Trade", "Hey, " .. offer_player2:SteamID() .. " tried to trade IC they don't have with " .. offer_player1:SteamID() .. "! <@207612500450082816>")
        MOAT_TRADES[trade_id] = nil
        return
    end

    local trade = {
        my_offer_items = offer_table1_items,
        my_offer_ic = offer_table1_ic,
        their_offer_items = offer_table2_items,
        their_offer_ic = offer_table2_ic,
        chat = util.TableToJSON(trade_tbl.ChatLog)
    }
    m_saveTrade(offer_player1:SteamID64() or 807, offer_player1:Nick(), offer_player2:SteamID64() or 807, offer_player2:Nick(), trade)

    -- Take inventory items from player 1
    for i = 1, offer_player1:GetMaxSlots() do
        if (MOAT_INVS[offer_player1]["slot" .. i] and MOAT_INVS[offer_player1]["slot" .. i].c) then
            if (table.HasValue(offer_table1_classes, MOAT_INVS[offer_player1]["slot" .. i].c)) then
                MOAT_INVS[offer_player1]["slot" .. i] = {}
            end
        end
    end

    for i = 1, 10 do
        if (MOAT_INVS[offer_player1]["l_slot" .. i] and MOAT_INVS[offer_player1]["l_slot" .. i].c) then
            if (table.HasValue(offer_table1_classes, MOAT_INVS[offer_player1]["l_slot" .. i].c)) then
                MOAT_INVS[offer_player1]["l_slot" .. i] = {}
            end
        end
    end

    -- Take inventory items from player 2
    for i = 1, offer_player2:GetMaxSlots() do
        if (MOAT_INVS[offer_player2]["slot" .. i] and MOAT_INVS[offer_player2]["slot" .. i].c) then
            if (table.HasValue(offer_table2_classes, MOAT_INVS[offer_player2]["slot" .. i].c)) then
                MOAT_INVS[offer_player2]["slot" .. i] = {}
            end
        end
    end

    for i = 1, 10 do
        if (MOAT_INVS[offer_player2]["l_slot" .. i] and MOAT_INVS[offer_player2]["l_slot" .. i].c) then
            if (table.HasValue(offer_table2_classes, MOAT_INVS[offer_player2]["l_slot" .. i].c)) then
                MOAT_INVS[offer_player2]["l_slot" .. i] = {}
            end
        end
    end
    -- meme1337
    -- Give items to player 2

    for k, v in pairs(offer_table1_items) do
        if (v.c) then
            offer_player2:m_AddInventoryItem(v, true, true)
        end
    end

    -- Give items to player 1
    for k, v in pairs(offer_table2_items) do
        if (v.c) then
            offer_player1:m_AddInventoryItem(v, true, true)
        end
    end

    m_SaveInventory(offer_player1)
    m_SaveInventory(offer_player2)
    -- Take points from player 1
    offer_player1:m_TakeIC(offer_table1_ic, true)
    -- Take points from player 2
    offer_player2:m_TakeIC(offer_table2_ic, true)
    -- Give points to player 1
    offer_player1:m_GiveIC(offer_table2_ic)
    -- Give points to player 2
    offer_player2:m_GiveIC(offer_table1_ic)
    offer_player1:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
    offer_player2:SetNW2Bool("MOAT_IS_CURRENTLY_TRADING", false)
    net.Start("MOAT_RESPOND_TRADE")
    net.WriteBool(true)
    net.WriteDouble(offer_player2:EntIndex())
    net.Send(offer_player1)
    net.Start("MOAT_RESPOND_TRADE")
    net.WriteBool(true)
    net.WriteDouble(offer_player1:EntIndex())
    net.Send(offer_player2)

    trade_tbl = nil

    local t = {}
    for k,v in pairs(offer_table1_items) do
        v.item = GetItemFromEnum(v.u)
        v.Talents = GetItemTalents(v)
        t[#t+1] = v
    end
    if (not offer_player2.ChatMuted) then
        net.Start("MOAT_TRADED_ITEMS")
        net.WriteEntity(offer_player2)
        net.WriteInt(offer_table1_ic,32)
        net.WriteTable(t or {})
        net.Broadcast()
    end

    local t = {}
    for k,v in pairs(offer_table2_items) do
        v.item = GetItemFromEnum(v.u)
        v.Talents = GetItemTalents(v)
        t[#t+1] = v
    end
    if (not offer_player1.ChatMuted) then
        net.Start("MOAT_TRADED_ITEMS")
        net.WriteEntity(offer_player1)
        net.WriteInt(offer_table2_ic,32)
        net.WriteTable(offer_table2_items or {})
        net.Broadcast()
    end


    if (MOAT_TRADE_BANNED and (MOAT_TRADE_BANNED[offer_player1:SteamID()] or MOAT_TRADE_BANNED[offer_player2:SteamID()])) then
        if (MOAT_TRADE_BANNED[offer_player1:SteamID()]) then
            discord.Send("Trade", "Hey, " .. offer_player1:SteamID() .. " traded with " .. offer_player2:SteamID() .. " when they're not supposed to! <@207612500450082816>")
        else
            discord.Send("Trade", "Hey, " .. offer_player2:SteamID() .. " traded with " .. offer_player1:SteamID() .. " when they're not supposed to! <@207612500450082816>")
        end
    end

    MOAT_TRADES[trade_id] = nil
    if offer_player1.alt_data and offer_player2.alt_data then
        -- if (tostring(offer_player1.alt_data[1]) == tostring(offer_player2.alt_data[1])) then
        -- if (tostring(offer_player1.alt_data[2]) == tostring(offer_player2:SteamID64())) then
        -- if (tostring(offer_player1.alt_data[3]) == tostring(offer_player2:SteamID64())) then
        -- if (tostring(offer_player2.alt_data[2]) == tostring(offer_player1:SteamID64())) then
        -- if (tostring(offer_player2.alt_data[3]) == tostring(offer_player1:SteamID64())) then
        if (tostring(offer_player1.alt_data[1]) == tostring(offer_player2.alt_data[1])) or (tostring(offer_player1.alt_data[2]) == tostring(offer_player2:SteamID64())) or (tostring(offer_player1.alt_data[3]) == tostring(offer_player2:SteamID64())) or (tostring(offer_player2.alt_data[2]) == tostring(offer_player1:SteamID64())) or (tostring(offer_player2.alt_data[3]) == tostring(offer_player1:SteamID64())) or (tostring(offer_player1.alt_data[2]) == tostring(offer_player2.alt_data[2])) or (tostring(offer_player1.alt_data[2]) == tostring(offer_player2.alt_data[3])) then
            discord.Send("Error Report SV",offer_player1:Nick() .. " (" .. offer_player1:SteamID() .. ") traded with alt of themselves: " .. offer_player2:Nick() .. " (" .. offer_player2:SteamID() .. ")")
        end
    end
end

function m_VerifyTradeSlots(player_1, player_2, trade_id, empty_slots)
    --[[local trade_tbl = {}

    for k, v in pairs( MOAT_TRADES ) do
        
        if ( tostring( k ) == trade_id ) then
            
            trade_tbl = table.Copy( v )

        end

    end

    local offer_table1_classes = {}

    local offer_table1_items = table.Copy( trade_tbl.player1.offers.items )

    for k, v in pairs( offer_table1_items ) do
        
        if ( v.c ) then
            
            table.insert( offer_table1_classes, v.c )

        end

    end


    local offer_table2_classes = {}

    local offer_table2_items = table.Copy( trade_tbl.player2.offers.items )

    for k, v in pairs( offer_table2_items ) do
        
        if ( v.c ) then
            
            table.insert( offer_table2_classes, v.c )
            
        end

    end

    local player_1_actual_empty_slots = trade_tbl.player1.empty_slots or 0

    local player_2_actual_empty_slots = trade_tbl.player2.empty_slots or 0

    local player_1_slots_needed = table.Count( offer_table2_classes )

    local player_2_slots_needed = table.Count( offer_table1_classes )


    if ( player_1_actual_empty_slots < player_1_slots_needed ) then

        local fail_message = player_1:Nick() .. " doesn't have enough inventory slots to accept this trade. Please cancel and re-accept once they have enough space."
        
        net.Start( "MOAT_TRADE_FAIL" )

        net.WriteDouble( tonumber( trade_id ) )

        net.WriteString( fail_message )

        net.Send( player_1 )

        net.Start( "MOAT_TRADE_FAIL" )

        net.WriteDouble( tonumber( trade_id ) )

        net.WriteString( fail_message )

        net.Send( player_2 )

        return

    end


    if ( player_2_actual_empty_slots < player_2_slots_needed ) then

        local fail_message = player_2:Nick() .. " doesn't have enough inventory slots to accept this trade. Please cancel and re-accept once they have enough space."
        
        net.Start( "MOAT_TRADE_FAIL" )

        net.WriteDouble( tonumber( trade_id ) )

        net.WriteString( fail_message )

        net.Send( player_1 )

        net.Start( "MOAT_TRADE_FAIL" )

        net.WriteDouble( tonumber( trade_id ) )

        net.WriteString( fail_message )

        net.Send( player_2 )

        return

    end]]
    m_InitTradeAccept(trade_id)
end

function m_UpdateTradeAcceptNum(ply, num, trade_id, empty_slots1)
    local accept_num = num
    local player_2 = nil
    local trade_accept = 0
    local player1_accept = 0
    local player2_accept = 0

    for k, v in pairs(MOAT_TRADES) do
        if (v.player1.index == ply:EntIndex() or v.player2.index == ply:EntIndex()) then
            if (tostring(k) == tostring(trade_id)) then
                if (v.player1.index == ply:EntIndex()) then
                    v.player1.accept = accept_num
                    v.player1.empty_slots = empty_slots1
                    player_2 = Entity(v.player2.index)
                else
                    v.player2.accept = accept_num
                    v.player2.empty_slots = empty_slots1
                    player_2 = Entity(v.player1.index)
                end
            end
        end
    end

    if (player_2) then
        net.Start("MOAT_TRADE_STATUS")
        net.WriteDouble(accept_num)
        net.Send(player_2)
    end

    local t = MOAT_TRADES[trade_id]
    if (not t) then return end
    if (t.player1.accept == 2 and t.player2.accept == 2) then
        m_VerifyTradeSlots(Entity(t.player1.index), Entity(t.player2.index), trade_id)
    end

    /*
    for k, v in pairs(MOAT_TRADES) do
        if (tostring(k) == tostring(trade_id)) then
            if (v.player1.accept == 2 and v.player2.accept == 2) then
                m_VerifyTradeSlots(Entity(v.player1.index), Entity(v.player2.index), tostring(k))
            end
        end
    end*/
end

net.Receive("MOAT_TRADE_CREDITS", function(len, ply)
    local trade_id = net.ReadDouble()
    local credits = net.ReadDouble()

    if (credits ~= credits) or (trade_id ~= trade_id) then
        local msg = ply:Nick() .. " (" .. ply:SteamID() .. ") Tried to add nan IC to trade. <@150809682318065664> <@135912347389788160>"
		discord.Send("Trade", msg)
		RunConsoleCommand("mga", "ban", att:SteamID(), "0", "minutes", "6Omega")
        return
    end
    local ver_credits = credits

    if (ver_credits > ply:m_GetIC()) then
        ver_credits = ply:m_GetIC()
    elseif (ver_credits < 0) then
        ver_credits = 0
    end

    local t = MOAT_TRADES[trade_id]
    if (not t) then return end

    if (t.player1.index == ply:EntIndex()) then
        t.player1.offers.ic = ver_credits
    elseif (t.player2.index == ply:EntIndex()) then
        t.player2.offers.ic = ver_credits
    else return end

    net.Start("MOAT_TRADE_CREDITS")
    net.WriteDouble(ver_credits)
    net.WriteDouble(trade_id)
    net.WriteDouble(ply:EntIndex())
    net.Send(Entity(t.player1.index))

    if (t.player1.index ~= t.player2.index) then
        net.Start("MOAT_TRADE_CREDITS")
        net.WriteDouble(ver_credits)
        net.WriteDouble(trade_id)
        net.WriteDouble(ply:EntIndex())
        net.Send(Entity(t.player2.index))
    end

    /*
    for k, v in pairs(MOAT_TRADES) do
        if (tostring(k) == tostring(trade_id)) then
            if (v.player1.index == ply:EntIndex()) then
                v.player1.offers.ic = ver_credits
            end

            if (v.player2.index == ply:EntIndex()) then
                v.player2.offers.ic = ver_credits
            end

            net.Start("MOAT_TRADE_CREDITS")
            net.WriteDouble(ver_credits)
            net.WriteDouble(trade_id)
            net.WriteDouble(ply:EntIndex())
            net.Send(Entity(v.player1.index))

            if (v.player1.index ~= v.player2.index) then
                net.Start("MOAT_TRADE_CREDITS")
                net.WriteDouble(ver_credits)
                net.WriteDouble(trade_id)
                net.WriteDouble(ply:EntIndex())
                net.Send(Entity(v.player2.index))
            end
        end
    end*/
end)

net.Receive("MOAT_TRADE_ADD", function(len, ply)
    local trade_slot_num = net.ReadDouble()
    local inv_slot_num = net.ReadDouble()
    local slot1_c = net.ReadString()
    local slot2_c = net.ReadString()
    local trade_id = net.ReadDouble()

    local trade_table = {}
    local player_2 = nil

    for k, v in pairs(MOAT_TRADES) do
        if (v.player1.index == ply:EntIndex() or v.player2.index == ply:EntIndex()) then
            if (tostring(k) == tostring(trade_id)) then
                if (v.player1.index == ply:EntIndex()) then
                    trade_table = v.player1.offers.items
                    player_2 = Entity(v.player2.index)
                else
                    trade_table = v.player2.offers.items
                    player_2 = Entity(v.player1.index)
                end
            end
        end
    end

    for k,v in pairs(trade_table) do
        if v.c then
            if v.c == slot2_c then return end
        end
    end

    local inv_slot1 = {}

    for i = 1, ply:GetMaxSlots() do
        if (MOAT_INVS[ply]["slot" .. i] and MOAT_INVS[ply]["slot" .. i].c) then
            if (MOAT_INVS[ply]["slot" .. i].c == slot2_c) then
                inv_slot1 = table.Copy(MOAT_INVS[ply]["slot" .. i])
                break
            end
        end
    end

    for i = 1, 10 do
        if (MOAT_INVS[ply]["l_slot" .. i] and MOAT_INVS[ply]["l_slot" .. i].c) then
            if (MOAT_INVS[ply]["l_slot" .. i].c == slot2_c) then
                inv_slot1 = table.Copy(MOAT_INVS[ply]["l_slot" .. i])
                break
            end
        end
    end


    -- for k, v in pairs(MOAT_TRADES) do
    --     if (v.player1.index == ply:EntIndex() or v.player2.index == ply:EntIndex()) then
    --         if (tostring(k) == tostring(trade_id)) then
    --             if (v.player1.index == ply:EntIndex()) then
    --                 trade_table = v.player1.offers.items
    --                 player_2 = Entity(v.player2.index)
    --             else
    --                 trade_table = v.player2.offers.items
    --                 player_2 = Entity(v.player1.index)
    --             end
    --         end
    --     end
    -- end

    local trade_slot = table.Copy(trade_table["slot" .. trade_slot_num])

    if (trade_slot and trade_slot.c) then
        if (trade_slot.c ~= slot1_c) then
            m_SendInventorySwapFail(ply)

            return
        end
    end

    local item = GetItemFromEnum(inv_slot1.u)
    if (item.NotTradeable or inv_slot1.nt) then
        net.Start("MOAT_TRADE_FAIL")
            net.WriteDouble(tonumber(trade_id))
            net.WriteString("This item is untradeable")
        net.Send(ply)

        return
    end

    net.Start("MOAT_SWP_INV_ITEM")
    net.WriteBool(true)
    net.WriteString("t_slot" .. trade_slot_num)
    net.WriteString("slot" .. inv_slot_num)
    net.Send(ply)
    trade_table["slot" .. trade_slot_num] = inv_slot1
    local tbl2 = table.Copy(trade_table["slot" .. trade_slot_num])
    tbl2.item = GetItemFromEnum(tbl2.u)
	tbl2.Talents = GetItemTalents(tbl2)

    if (player_2) then
        net.Start("MOAT_TRADE_SWAP")
        net.WriteDouble(trade_slot_num + 10)
        net.WriteTable(tbl2)
        net.Send(player_2)
    end
end)

net.Receive("MOAT_TRADE_REM", function(len, ply)
    local inv_slot_num = net.ReadDouble()
    local trade_slot_num = net.ReadDouble()
    local slot2_c = net.ReadString()
    local slot1_c = net.ReadString()
    local trade_id = net.ReadDouble()
    local inv_slot1 = {}

    for i = 1, ply:GetMaxSlots() do
        if (MOAT_INVS[ply]["slot" .. i] and MOAT_INVS[ply]["slot" .. i].c) then
            if (MOAT_INVS[ply]["slot" .. i].c == slot2_c) then
                inv_slot1 = table.Copy(MOAT_INVS[ply]["slot" .. i])
                break
            end
        end
    end

    for i = 1, 10 do
        if (MOAT_INVS[ply]["l_slot" .. i] and MOAT_INVS[ply]["l_slot" .. i].c) then
            if (MOAT_INVS[ply]["l_slot" .. i].c == slot2_c) then
                inv_slot1 = table.Copy(MOAT_INVS[ply]["l_slot" .. i])
                break
            end
        end
    end

    local trade_table = {}
    local player_2 = nil

    for k, v in pairs(MOAT_TRADES) do
        if (v.player1.index == ply:EntIndex() or v.player2.index == ply:EntIndex()) then
            if (tostring(k) == tostring(trade_id)) then
                if (v.player1.index == ply:EntIndex()) then
                    trade_table = v.player1.offers.items
                    player_2 = Entity(v.player2.index)
                else
                    trade_table = v.player2.offers.items
                    player_2 = Entity(v.player1.index)
                end
            end
        end
    end

    local trade_slot = table.Copy(trade_table["slot" .. trade_slot_num])

    if (trade_slot and trade_slot.c) then
        if (trade_slot.c ~= slot1_c) then
            m_SendInventorySwapFail(ply)

            return
        end
    end

	local item = GetItemFromEnum(inv_slot1.u)
    if (item.NotTradeable or inv_slot1.nt) then
        net.Start("MOAT_TRADE_FAIL")
            net.WriteDouble(tonumber(trade_id))
            net.WriteString("This item is untradeable")
        net.Send(ply)

        return
    end

    net.Start("MOAT_SWP_INV_ITEM")
    net.WriteBool(true)
    net.WriteString("slot" .. inv_slot_num)
    net.WriteString("t_slot" .. trade_slot_num)
    net.Send(ply)
    trade_table["slot" .. trade_slot_num] = inv_slot1
    local tbl2 = table.Copy(trade_table["slot" .. trade_slot_num])
    tbl2.item = GetItemFromEnum(tbl2.u)
	tbl2.Talents = GetItemTalents(tbl2)

    if (player_2) then
        net.Start("MOAT_TRADE_SWAP")
        net.WriteDouble(trade_slot_num + 10)
        net.WriteTable(tbl2)
        net.Send(player_2)
    end
end)

net.Receive("MOAT_TRADE_SWAP", function(len, ply)
    local trade_slot_num1 = net.ReadDouble()
    local trade_slot_num2 = net.ReadDouble()
    local slot1_c = net.ReadString()
    local slot2_c = net.ReadString()
    local trade_id = net.ReadDouble()
    local trade_table = {}
    local player_2 = nil

    for k, v in pairs(MOAT_TRADES) do
        if (v.player1.index == ply:EntIndex() or v.player2.index == ply:EntIndex()) then
            if (tostring(k) == tostring(trade_id)) then
                if (v.player1.index == ply:EntIndex()) then
                    trade_table = v.player1.offers.items
                    player_2 = Entity(v.player2.index)
                else
                    trade_table = v.player2.offers.items
                    player_2 = Entity(v.player1.index)
                end
            end
        end
    end

    for k,v in pairs(trade_table) do
        if v.c then
            if v.c == slot2_c then print("Bad move2") return end
        end
    end

    local trade_slot = {}

    for i = 1, 10 do
        if (trade_table["slot" .. i] and trade_table["slot" .. i].c) then
            if (trade_table["slot" .. i].c == slot1_c) then
                trade_slot = table.Copy(trade_table["slot" .. i])
                break
            end
        end
    end

    local trade_slot2 = {}

    for i = 1, 10 do
        if (trade_table["slot" .. i] and trade_table["slot" .. i].c) then
            if (trade_table["slot" .. i].c == slot2_c) then
                trade_slot2 = table.Copy(trade_table["slot" .. i])
                break
            end
        end
    end

    if (trade_slot and trade_slot.c) then
        if (trade_slot.c ~= slot1_c) then
            m_SendInventorySwapFail(ply)

            return
        end
    end

    if (trade_slot2 and trade_slot2.c) then
        if (trade_slot2.c ~= slot2_c) then
            m_SendInventorySwapFail(ply)

            return
        end
    end

    net.Start("MOAT_SWP_INV_ITEM")
    net.WriteBool(true)
    net.WriteString("t_slot" .. trade_slot_num1)
    net.WriteString("t_slot" .. trade_slot_num2)
    net.Send(ply)
    trade_table["slot" .. trade_slot_num1] = trade_slot2
    trade_table["slot" .. trade_slot_num2] = trade_slot
    local tbl2 = {}

    for i = 1, 10 do
        if (trade_table["slot" .. i] and trade_table["slot" .. i].c) then
            if (trade_table["slot" .. i].c == slot2_c) then
                tbl2 = table.Copy(trade_table["slot" .. i])
                break
            end
        end
    end

    tbl2.item = GetItemFromEnum(tbl2.u)
	tbl2.Talents = GetItemTalents(tbl2)

    local tbl3 = {}

    for i = 1, 10 do
        if (trade_table["slot" .. i] and trade_table["slot" .. i].c) then
            if (trade_table["slot" .. i].c == slot1_c) then
                tbl3 = table.Copy(trade_table["slot" .. i])
                break
            end
        end
    end

    tbl3.item = GetItemFromEnum(tbl3.u)
	tbl3.Talents = GetItemTalents(tbl3)

    if (player_2) then
        net.Start("MOAT_TRADE_SWAP")
        net.WriteDouble(trade_slot_num1 + 10)
        net.WriteTable(tbl2)
        net.Send(player_2)
        net.Start("MOAT_TRADE_SWAP")
        net.WriteDouble(trade_slot_num2 + 10)
        net.WriteTable(tbl3)
        net.Send(player_2)
    end
end)

net.Receive("MOAT_TRADE_STATUS", function(len, ply)
    local accept_num = net.ReadDouble()
    local trade_id = net.ReadDouble()
    local empty_slots = net.ReadDouble()
    if (accept_num < 0 or accept_num > 2) then
        accept_num = 0
    end

    m_UpdateTradeAcceptNum(ply, accept_num, trade_id, empty_slots)
end)

local moat_link_cooldowns = {}

net.Receive("MOAT_LINK_ITEM", function(len, ply)
    if (ply.netlinkitemcool or 0) > CurTime() then return end
    ply.netlinkitemcool = CurTime() + 1
    local num = net.ReadDouble() 
    local ldt = net.ReadBool()
    local wpnstr = net.ReadString()
    local slotstr = "slot" .. num

    if (ldt) then
        slotstr = "l_" .. slotstr
    end

    local tbl = table.Copy(MOAT_INVS[ply][slotstr])
    tbl.item = GetItemFromEnum(tbl.u)
	tbl.Talents = GetItemTalents(tbl)

    net.Start("MOAT_LINK_ITEM")
    net.WriteDouble(ply:EntIndex())
    net.WriteTable(tbl)
    net.Broadcast()
end)

local chatlinks = {"primary", "secondary", "melee", "powerup", "special", "head", "mask", "body", "effect", "model"}

local function containsItemLink(str)
    if (str:len() <= 5) then return false end
    str = str:lower()

    for k, v in pairs(chatlinks) do
        if (str:find("{" .. v .. "}") or string.match(str, "{slot") or string.match(str,"{loadout")) then return true end
    end

    return false
end

local function getItemFromLink(str, ply)
    local estr = str:sub(2, #str - 1)
    local slotstr = "slot" .. 1

    if (string.StartWith(estr, "slot")) then
        slotstr = "slot" .. estr:sub(5, #estr)
    else
        slotstr = "l_slot"

        for i = 1, 10 do
            if (chatlinks[i] == estr:lower()) then
                slotstr = slotstr .. i
                break
            end
        end
    end

    local tbl = table.Copy(MOAT_INVS[ply][slotstr])
    if (tbl == {} or not tbl.c) then return "null" end
    tbl.item = GetItemFromEnum(tbl.u)
	tbl.Talents = GetItemTalents(tbl)

    return tbl
end

local chat_link_cooldowns = {}

local function initiateItemMessage(ply, str, public)
    if (public) then
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You may only link items in public chat. You sent one in team chat!")]])

        return
    end

    if (chat_link_cooldowns[ply] and chat_link_cooldowns[ply] > CurTime()) then
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You're sending chat links too fast!")]])

        return
    end

    local amt = 0
    local item_table = {}
    local loadout = str:lower():match("%{loadout%}")
    local s = ""
    if loadout then
        for k,v in pairs(chatlinks) do
            local t = getItemFromLink("{" .. v .. "}",ply)
            if isstring(t) then continue end
            s = s .. "{" .. v .. "} | "
        end
    end

    str = str:lower():gsub("%{loadout%}",s)
    local fstr = string.Explode("{", str)

    for k, v in ipairs(fstr) do
        local tbl = string.Explode("}", v)

        if (tbl[1] and tbl[2] and containsItemLink("{" .. tbl[1] .. "}")) then
            fstr[k] = "{" .. tbl[1] .. "}"
            amt = amt + 1
            table.insert(fstr, k + 1, tbl[2])
        end
    end

    if (amt > 10) then
        ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "Woah there! You're only able to send 10 item links at a time, sorry!")]])

        return
    end

    local item_table = {}

    for k, v in ipairs(fstr) do
        if (string.StartWith(v, "{") and string.EndsWith(v, "}")) then
            local item = getItemFromLink(v, ply)

            if (isstring(item)) then
                ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "A slot you're trying to link doesn't have an item in it! It needs an item, sorry!")]])

                return
            end

            item.id = v
            table.insert(item_table, item)
        end
    end

    net.Start("MOAT_CHAT_LINK_ITEM")
    net.WriteEntity(ply)
    net.WriteTable(fstr)
    net.WriteUInt(amt, 4)

    for i = 1, amt do
        net.WriteTable(item_table[i])
    end

    net.Broadcast()
    chat_link_cooldowns[ply] = CurTime() + 10
end

hook.Add("PlayerSay", "moat_ReplaceChatLinks", function(ply, text, public)
    if (containsItemLink(text)) then
		initiateItemMessage(ply, text, public)

        return ""
    end
end)

local function IsNameMatch(ply, str)
    if (string.match(str, "STEAM_[0-5]:[0-9]:[0-9]+")) then
        return ply:SteamID() == str
    elseif (string.Left(str, 1) == "\"" and string.Right(str, 1) == "\"") then
        return (ply:Nick() == string.sub(str, 2, #str - 1))
    else
        return (string.lower(ply:Nick()) == string.lower(str) or string.find(string.lower(ply:Nick()), string.lower(str), nil, true))
    end
end

local function FindPlayer(name)
    local matches = {}

    if (type(name) ~= "table") then
        name = {name}
    end

    local name2 = table.Copy(name)

    for _, ply in ipairs(player.GetAll()) do
        if (ply:Team() ~= TEAM_SPEC) then continue end

        for _, pm in ipairs(name2) do
            if (IsNameMatch(ply, pm) and not table.HasValue(matches, ply)) then
                table.insert(matches, ply)
            end
        end
    end

    return matches
end

hook.Add("PlayerSay", "moat_TradeCommand", function(ply, text, public)
    local txt = text:lower()

    if (txt:sub(1, 7) == "!trade " or txt:sub(1, 7) == "/trade ") then
        if (ply:Team() ~= TEAM_SPEC and GetRoundState() == ROUND_ACTIVE) then
            ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "You can't trade while alive in an active round!" )]])

            return
        end

        local pl = txt:sub(8, #txt):Trim()
        local players = FindPlayer(txt:sub(8, #txt))

        if (#pl < 1 or #players < 1) then
            ply:SendLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 0, 0 ), "Couldn't find a player to send trade to!" )]])
        else
            m_SendTradeReq(ply, players[1]:EntIndex())
        end

        return ""
    end
end)

function m_LockInventoryItem(ply, slot, class)
    local ply_inv = MOAT_INVS[ply]
    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            if (MOAT_INVS[ply][k].l) then
                if (MOAT_INVS[ply][k].l == 1) then
                    MOAT_INVS[ply][k].l = 0
                else
                    MOAT_INVS[ply][k].l = 1
                end
            else
                MOAT_INVS[ply][k].l = 1
            end
            net.Start("MOAT_LOCK_INV_ITEM")
            net.WriteDouble(tonumber(k:sub(5, #k)))
            net.WriteBool(MOAT_INVS[ply][k].l == 1)
            net.Send(ply)

            items_found = items_found + 1
            m_SaveInventory(ply)
        end
    end

    if (items_found > 1) then
        -- RunConsoleCommand("mga", "perma", ply:SteamID(), "[Automated] Item Exploiting Detected!")
    end
end

net.Receive("MOAT_LOCK_INV_ITEM", function(len, ply)
    local slot = net.ReadDouble()
    local class = net.ReadDouble()

    m_LockInventoryItem(ply, slot, class, lock)
end)

function m_FinishUsableItem(pl, item)
    net.Start("MOAT_END_USABLE")
    net.Send(pl)

    net.Start("moat.comp.chat")
    net.WriteString("Successfully used " .. item.Name .. "!")
    net.WriteBool(false)
    net.Send(pl)

    pl.UsingUsable = false
end

function m_UseUsableItem(pl, slot, class, wep_slot, wep_class, str)
    local ply_inv = MOAT_INVS[pl]

    if (not ply_inv) then return end
    if (not ply_inv["slot" .. slot] or not ply_inv["slot" .. slot].c) then return end
    if (tonumber(ply_inv["slot" .. slot].c) ~= class) then return end

    if (wep_slot ~= nil and wep_class ~= nil) then
        if (not ply_inv["slot" .. wep_slot] or not ply_inv["slot" .. wep_slot].c) then return end
        if (tonumber(ply_inv["slot" .. wep_slot].c) ~= wep_class) then return end
    end

    local item = GetItemFromEnumWithFunctions(ply_inv["slot" .. slot].u)
    if (not item) then return end

    local item_chosen = nil

    if (item.ItemCheck) then
        if (not wep_slot or not wep_class) then return end

        item_chosen = table.Copy(ply_inv["slot" .. wep_slot])
		item_chosen.item = GetItemFromEnumWithFunctions(ply_inv["slot" .. wep_slot].u)
        if (not item_chosen) then return end

        if (MOAT_ITEM_CHECK and MOAT_ITEM_CHECK[item.ItemCheck]) then
            if (not MOAT_ITEM_CHECK[item.ItemCheck][1](item_chosen, pl)) then return end
        end
    end

	if (item.SafetyCheck) then
        if (not wep_slot or not wep_class) then return end
        if (MOAT_ITEM_CHECK and MOAT_ITEM_CHECK[item.SafetyCheck] and not MOAT_ITEM_CHECK[item.SafetyCheck][1](item, pl)) then
			return
        end
    end

    if (item.ID == 4001) then
        if (not str) then return end

        item.ItemUsed(pl, wep_slot, item_chosen, str)
    else
        if (item.PaintVer) then
            item.ItemUsed(item, pl, wep_slot, item_chosen)
        elseif (item.ID == 7820) then
            if (not item_chosen) then return end
            
            if (item.ItemUsed(pl, slot, item, wep_slot, item_chosen)) then
                m_FinishUsableItem(pl, item)
            end
            return
        elseif (item.ID == 7821) then
            item.ItemUsed(pl, slot, class)
        else
            item.ItemUsed(pl, wep_slot, item_chosen)
        end
    end

    m_RemoveInventoryItem(pl, slot, class, 1)
    m_FinishUsableItem(pl, item)
end

net.Receive("MOAT_USE_USABLE", function(l, pl)
    local slot = net.ReadDouble()
    local class = net.ReadDouble()
    local wep_slot = net.ReadDouble()
    local wep_class = net.ReadDouble()

    if (not pl.UsingUsable) then 
        net.Start("moat.comp.chat")
        net.WriteString("Something went wrong while using that item!")
        net.WriteBool(true)
        net.Send(pl)

        return
    end

    m_UseUsableItem(pl, slot, class, wep_slot ~= 0 and wep_slot or nil, wep_class ~= 0 and wep_class or nil)
end)

local l_wl = {"a", "b", "c", "d", "e", "f", "g", 
"h", "i", "j", "k", "l", "m", "n", "o", "p", "q", 
"r", "s", "t", "u", "v", "w", "x", "y", "z", "0", 
"1", "2", "3", "4", "5", "6", "7", "8", "9", "-", 
"=", "`", "[", "]", "\\", ";", ":", ",", ".", "/",
"~", "!", "@", "#", "$", "%", "^", "&", "*", "(",
")", "_", "+", "{", "}", "|", ":", "?", " ", "'"}

net.Receive("MOAT_USE_NAME_MUTATOR", function(l, pl)
    if (pl.MutatorCooldown and pl.MutatorCooldown > CurTime()) then return end
    pl.MutatorCooldown = CurTime() + 3

    local slot = net.ReadDouble()
    local class = net.ReadDouble()
    local wep_slot = net.ReadDouble()
    local wep_class = net.ReadDouble()
    local str = net.ReadString()

    if (not pl.UsingUsable) then 
        net.Start("moat.comp.chat")
        net.WriteString("Something went wrong while using that item!")
        net.WriteBool(true)
        net.Send(pl)

        return
    end

    if (not str) then return end
    if (#str < 3 or #str > 30) then return end

    local stramt = 0

    local stre = string.Explode("", str)
    for i = 1, #stre do
        if (not table.HasValue(l_wl, stre[i]:lower())) then return end

        stramt = stramt + 1
    end

    if (stramt > 30) then return end

    m_UseUsableItem(pl, slot, class, wep_slot ~= 0 and wep_slot or nil, wep_class ~= 0 and wep_class or nil, str)
end)

net.Receive("MOAT_REM_NAME_MUTATOR", function(l, pl)
    if (pl.MutatorCooldown and pl.MutatorCooldown > CurTime()) then return end
    pl.MutatorCooldown = CurTime() + 3

    local slot = net.ReadDouble()
    local class = net.ReadDouble()

    if (not slot or not class) then return end
    if (not MOAT_INVS[pl]) then return end
    if (not MOAT_INVS[pl]["slot" .. slot]) then return end
    if (not MOAT_INVS[pl]["slot" .. slot].c == class) then return end
    if (not MOAT_INVS[pl]["slot" .. slot].u == 4001) then return end
    
    local ply_inv = MOAT_INVS[pl]
    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            items_found = items_found + 1

            if (v.n and k == "slot" .. slot) then
                MOAT_INVS[pl][k].n = nil
                m_SendInvItem(pl, slot)
            end
        end
    end

    if (items_found > 1) then
        -- RunConsoleCommand("mga", "perma", pl:SteamID(), "[Automated] Item Exploiting Detected!")
    end

    m_SaveInventory(pl)
end)

net.Receive("MOAT_INIT_USABLE", function(l, pl)
    local slot = net.ReadDouble()
    local class = net.ReadDouble()
    local ply_inv = MOAT_INVS[pl]

    if (pl:m_isTrading()) then
        net.Start("moat.comp.chat")
        net.WriteString("You cannot use a usable while trading!")
        net.WriteBool(true)
        net.Send(pl)

        return
    end

    if (not ply_inv) then return end
    if (not ply_inv["slot" .. slot] or not ply_inv["slot" .. slot].c) then return end
    if (tonumber(ply_inv["slot" .. slot].c) ~= class) then return end

    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            items_found = items_found + 1
        end
    end

    if (items_found > 1) then
        -- RunConsoleCommand("mga", "perma", pl:SteamID(), "[Automated] Item Exploiting Detected!")
        -- return
    end

    net.Start("MOAT_INIT_USABLE")
    net.WriteDouble(class)
    net.Send(pl)

    pl.UsingUsable = true
end)

net.Receive("MOAT_END_USABLE", function(l, pl)
    pl.UsingUsable = false
end)

function m_SendInvItem(pl, s, l)
	-- pl.NetDelay = pl.NetDelay or 1
    -- timer.Simple(pl.NetDelay * 0.01, function()
		local slot_text = "slot"
		if (l) then slot_text = "l_slot" end
		
		if (IsValid(pl)) then
			net.Start("MOAT_SEND_INV_ITEM")
			net.WriteString(s)

			local tbl = table.Copy(MOAT_INVS[pl][slot_text .. s])
			-- tbl.item = GetItemFromEnum(tbl.u, tbl)
			-- tbl.Talents = GetItemTalents(tbl)
		
			-- net.WriteTable(tbl)
			m_WriteWeaponToNet(tbl)
			net.Send(pl)

			-- pl.NetDelay = math.max(0, pl.NetDelay - 1)
		end
	-- end)

	-- pl.NetDelay = pl.NetDelay + 1
end

local mutator_rar = {
    [5] = "High-End",
    [6] = "Ascended",
    [7] = "Cosmic",
    [9] = "Planetary"
}

function m_DropTalentMutator(pl, r)
    pl:m_DropInventoryItem(mutator_rar[r] .. " Talent Mutator")

    net.Start("MOAT_DECON_MUTATOR")
    net.Send(pl)
end

function m_DropStatMutator(pl, r)
    pl:m_DropInventoryItem(mutator_rar[r] .. " Stat Mutator")

    net.Start("MOAT_DECON_MUTATOR")
    net.Send(pl)
end

-- Deconstruct Mutators
hook.Add("PlayerDeconstructedItem", "moat_deconstruct_items", function(pl, enum)
    local item_tbl = GetItemFromEnum(enum)
    if (not item_tbl) then return end

    pl:m_ModifyStatType("MOAT_STATS_DECONSTRUCTS", "r", 1)

    local item_rarity = item_tbl.Rarity or 1
    local drop_mutator = math.random(1, 3)

    if (item_rarity == 7) then
        drop_mutator = math.random(1, 5)
    elseif (item_rarity == 6) then
        drop_mutator = math.random(1, 10)
    elseif (item_rarity == 5) then
        drop_mutator = math.random(1, 15)
    elseif (item_rarity < 5) then
        drop_mutator = 0
    end

    if (item_rarity > 4 and item_rarity ~= 8 and drop_mutator == 1 and item_tbl.Stats) then
        local fifty = math.random(1, 100)

        if (fifty < 50 and item_tbl.Talents) then
            m_DropTalentMutator(pl, item_rarity)
        else
            m_DropStatMutator(pl, item_rarity)
        end

        if (not pl.Deconing and pl.DeconNumber) then
            net.Start("MOAT_DECON_NOTIFY")
            net.WriteUInt(pl.DeconNumber, 32)
            net.WriteBool(true)
            net.Send(pl)

            pl.DeconNumber = nil
        end

        return
    end

    local deconstruct_tbl = {
        min = 0,
        max = 0
    }

    if (MOAT_RARITIES[item_rarity]) then
        deconstruct_tbl = table.Copy(MOAT_RARITIES[item_rarity].Deconstruct)
    end

	local dec_min = math.Round(deconstruct_tbl.min)
    local dec_max = math.Round(deconstruct_tbl.max)
	local multiplier = 1

	if (string.find(string.lower(pl:Nick()), "moat.gg")) then
		multiplier = multiplier + .25
	end

    if (table.HasValue(MOAT_VIP, pl:GetUserGroup())) then
		multiplier = multiplier + .5
    end

	dec_min = math.floor(dec_min * multiplier)
	dec_max = math.floor(dec_max * multiplier)

    local deconstruct_creds = math.random(dec_min, dec_max)

    pl:m_GiveIC(deconstruct_creds)

    if (not pl.Deconing and pl.DeconNumber) then
        pl.DeconNumber = pl.DeconNumber + deconstruct_creds

        net.Start("MOAT_DECON_NOTIFY")
        net.WriteUInt(pl.DeconNumber, 32)
        net.WriteBool(true)
        net.Send(pl)

        pl.DeconNumber = nil
    elseif (pl.Deconing) then
        if (not pl.DeconNumber) then pl.DeconNumber = 0 end
        
        pl.DeconNumber = pl.DeconNumber + deconstruct_creds
    else
        net.Start("MOAT_DECON_NOTIFY")
        net.WriteUInt(deconstruct_creds, 32)
        net.Send(pl)
    end
end)

net.Receive("MOAT_CRATE_PREVIEW", function(l, pl)
    if (pl.CrateCooldown and pl.CrateCooldown > CurTime()) then return end
    pl.CrateCooldown = CurTime() + 3

    local crate_id = net.ReadUInt(32)
    local crate_tbl = GetItemFromEnum(crate_id)
    if (not crate_tbl) then return end
    if (crate_tbl.Kind ~= "Crate") then return end

    net.Start("MOAT_CRATE_PREVIEW")
    net.WriteTable(crate_tbl)
    net.Send(pl)
end)


net.Receive("MOAT_REM_TINT", function(l, pl)
    if (pl.PaintCooldown and pl.PaintCooldown > CurTime()) then return end
    pl.PaintCooldown = CurTime() + 1

    local slot = net.ReadDouble()
    local class = net.ReadDouble()

    if (not MOAT_INVS[pl]) then return end
    if (not MOAT_INVS[pl]["slot" .. slot]) then return end
    if (MOAT_INVS[pl]["slot" .. slot].c ~= tostring(class)) then return end
    
    local ply_inv = MOAT_INVS[pl]
    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            items_found = items_found + 1

            if (v.p and k == "slot" .. slot) then
                MOAT_INVS[pl][k].p = nil
                m_SendInvItem(pl, slot)
            end
        end
    end

    if (items_found > 1) then
        -- RunConsoleCommand("mga", "perma", pl:SteamID(), "[Automated] Item Exploiting Detected!")
    end

    m_SaveInventory(pl)
end)

net.Receive("MOAT_REM_PAINT", function(l, pl)
    if (pl.PaintCooldown and pl.PaintCooldown > CurTime()) then return end
    pl.PaintCooldown = CurTime() + 1

    local slot = net.ReadDouble()
    local class = net.ReadDouble()

    if (not MOAT_INVS[pl]) then return end
    if (not MOAT_INVS[pl]["slot" .. slot]) then return end
    if (MOAT_INVS[pl]["slot" .. slot].c ~= tostring(class)) then return end
    
    local ply_inv = MOAT_INVS[pl]
    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            items_found = items_found + 1

            if (v.p2 and k == "slot" .. slot) then
                MOAT_INVS[pl][k].p2 = nil
                m_SendInvItem(pl, slot)
            end
        end
    end

    if (items_found > 1) then
        -- RunConsoleCommand("mga", "perma", pl:SteamID(), "[Automated] Item Exploiting Detected!")
    end

    m_SaveInventory(pl)
end)

net.Receive("MOAT_REM_TEXTURE", function(l, pl)
    if (pl.PaintCooldown and pl.PaintCooldown > CurTime()) then return end
    pl.PaintCooldown = CurTime() + 1

    local slot = net.ReadDouble()
    local class = net.ReadDouble()

    if (not MOAT_INVS[pl]) then return end
    if (not MOAT_INVS[pl]["slot" .. slot]) then return end
    if (MOAT_INVS[pl]["slot" .. slot].c ~= tostring(class)) then return end
    
    local ply_inv = MOAT_INVS[pl]
    local items_found = 0

    for k, v in pairs(ply_inv) do
        if (v.c == tostring(class)) then
            items_found = items_found + 1

            if (v.p3 and k == "slot" .. slot) then
                MOAT_INVS[pl][k].p3 = nil
                m_SendInvItem(pl, slot)
            end
        end
    end

    if (items_found > 1) then
        -- RunConsoleCommand("mga", "perma", pl:SteamID(), "[Automated] Item Exploiting Detected!")
    end

    m_SaveInventory(pl)
end)

game.ConsoleCommand("sv_friction 8\n")

--m_DropInventoryItem(cmd_item, cmd_class, drop_cosmetics, delay_le_saving, hide_chat, dev_talent_tbl)