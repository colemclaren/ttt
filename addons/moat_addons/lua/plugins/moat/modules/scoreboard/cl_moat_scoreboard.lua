local PLAYER = FindMetaTable "Player"
function PLAYER:GetScoreboardGroup()
	local r, id = self:GetUserGroup(), self:SteamID64()
	if (id and OPERATION_LEADS[id]) then r = "operationslead" end
	if (id and TECH_LEADS[id]) then r = "techlead" end

	return MOAT_RANKS[r] or MOAT_RANKS["user"]
end

hook.Add("TTTScoreboardColumns", "moat_AddGroupLevel", function(pnl)
    pnl:AddColumn("Rank", function(ply, label)
		local rank_info = ply:GetScoreboardGroup()

        label:SetTextColor(rank_info[2] or Color(255, 255, 255))
        return rank_info[1] or ""
    end, 150)

    pnl:AddColumn("Level", function(ply, label) return ply:GetNWInt("MOAT_STATS_LVL", 1) end)
end)

hook.Add("ScoreboardShow", "moat_ScoreboardShow", function()
    if (IsValid(sboard_panel)) then
        sboard_panel:SetDrawOnTop(true)
    end
end)

hook.Add("TTTScoreboardColorForPlayer", "moat_TTTScoreboardColor", function(ply)
	local rank_info = ply:GetScoreboardGroup()
	return rank_info[2] or Color(255, 255, 255)
end)

local MOAT_SCOREBOARD_MENU = {
    {
        1,
        "Copy SteamID",
        "icon16/tag_blue.png",
        function(ply)
            SetClipboardText(ply:SteamID())
        end
    },
    {
        1,
        "Copy Name",
        "icon16/user_edit.png",
        function(ply)
            SetClipboardText(ply:Nick())
        end
    },
    {
        1,
        "View Profile",
        "icon16/world.png",
        function(ply)
            ply:ShowProfile()
        end
    },
	{
        1,
        "Profile Card",
        "icon16/information.png",
        function(ply)
            open_profile_card(ply:SteamID64())
        end
    },
    {
        1,
        "Block",
        "icon16/delete.png",
        function(ply)
            RunConsoleCommand("mga", "block", ply:SteamID())
        end
    },
    {
        1,
        "Unblock",
        "icon16/accept.png",
        function(ply)
            RunConsoleCommand("mga", "unblock", ply:SteamID())
        end
    },
    {
        2,
        "Votekick",
        "icon16/door_in.png",
        function(ply)
            RunConsoleCommand("mga", "votekick", ply:SteamID())
        end
    },
    {
        3,
        "AFK",
        "icon16/user_delete.png",
        function(ply)
            RunConsoleCommand("mga", "afk", ply:SteamID())
        end
    },
    {
        3,
        "Mute/UnMute",
        "icon16/sound_delete.png",
        function(ply)
            RunConsoleCommand("mga", "mute", ply:SteamID())
        end
    },
    {
        3,
        "Gag/UnGag",
        "icon16/transmit_delete.png",
        function(ply)
            RunConsoleCommand("mga", "gag", ply:SteamID())
        end
    },
    {
        3,
        "Bring",
        "icon16/arrow_undo.png",
        function(ply)
            RunConsoleCommand("mga", "bring", ply:SteamID())
        end
    }
}

local function moat_TTTScoreboardMenu(menu)
    local rank = LocalPlayer():GetUserGroup()
    local ply = menu.Player

	if (menu.Player == LocalPlayer() and LocalPlayer():GetNWInt("MOAT_STATS_LVL", 1) >= 100) then
		menu:AddOption("Change Level", MOAT_LEVELS.OpenTitleMenu):SetIcon("icon16/color_wheel.png")
		menu:AddSpacer()
	end

    for k, v in ipairs(MOAT_SCOREBOARD_MENU) do
        if (MOAT_RANKS[rank][2 + v[1]]) then
            local old_tbl = MOAT_SCOREBOARD_MENU[k - 1]

            if (old_tbl and old_tbl[1] ~= v[1]) then
                menu:AddSpacer()
            end

            if (v[2] == "Votekick") then
                local submenu, parent = menu:AddSubMenu(v[2])
                parent:SetImage(v[3])

                submenu:AddOption("Yes I'm sure.", function()
                    if (not IsValid(ply)) then
                        chat.AddText(Color(255, 0, 0), "Couldn't " .. v[2] .. " because the player left.")

                        return
                    end

                    v[4](ply)
                end):SetIcon("icon16/tick.png")

                submenu:AddOption("Cancel."):SetIcon("icon16/cross.png")
                continue
            end

            menu:AddOption(v[2], function()
                if (not IsValid(ply)) then
                    chat.AddText(Color(255, 0, 0), "Couldn't " .. v[2] .. " because the player left.")

                    return
                end

                v[4](ply)
            end):SetImage(v[3])
        end
    end
	
	hook.Remove("Think", "moat_TTTSCoreboardMenuClose")
    hook.Add("Think", "moat_TTTSCoreboardMenuClose", function()
        if (not input.IsKeyDown(KEY_TAB)) then
            hook.Remove("Think", "moat_TTTSCoreboardMenuClose")
            menu:Remove()

            return
        end
    end)
end

hook.Add("TTTScoreboardMenu", "moat_TTTScoreboardMenu", moat_TTTScoreboardMenu)

local function moat_UpdateDefaultTTTShit()
    if (not WSWITCH) then return end
    local margin = 10
    local height = 20
    local TryTranslation = LANG.TryTranslation

    function WSWITCH:DrawWeapon(x, y, c, wep)
        if not IsValid(wep) then return false end
        local name = TryTranslation(wep.PrintName or wep:GetPrintName() or "...")
        local cl1, am1 = wep:Clip1(), wep:Ammo1()
        local ammo = false

        -- Clip1 will be -1 if a melee weapon
        -- Ammo1 will be false if weapon has no owner (was just dropped)
        if cl1 ~= -1 and am1 ~= false then
            ammo = Format("%i + %02i", cl1, am1)
        end

        -- Slot
        local spec = {
            text = wep.Slot + 1,
            font = "Trebuchet22",
            pos = {x + 4, y},
            yalign = TEXT_ALIGN_CENTER,
            color = c.text
        }

        draw.TextShadow(spec, 1, c.shadow)
        -- Name
        surface.SetFont("TimeLeft")
        local namew = surface.GetTextSize(name)
        spec.font = "TimeLeft"

        if (namew > 230) then
            spec.font = "TimeLeftSmall"
        end

        spec.text = name

        if (wep.ItemStats) then
            spec.color = wep.ItemStats.item.NameColor or rarity_names[wep.ItemStats.item.Rarity][2]
        end

        spec.pos[1] = x + 10 + height
        draw.Text(spec)

        --draw.DrawText( spec.text, spec.font, spec.pos[1], spec.pos[2], spec.color )
        if ammo then
            local col = c.text

            if wep:Clip1() == 0 and wep:Ammo1() == 0 then
                col = c.text_empty
            end

            -- Ammo
            spec.text = ammo
            spec.font = "TimeLeft"
            spec.pos[1] = ScrW() - margin * 3
            spec.xalign = TEXT_ALIGN_RIGHT
            spec.color = col
            draw.Text(spec)
        end

        return true
    end
end

timer.Simple(0, function()
    moat_UpdateDefaultTTTShit()
end)

net.Receive("MoatSendLua", function()
    RunString(net.ReadString())
end)