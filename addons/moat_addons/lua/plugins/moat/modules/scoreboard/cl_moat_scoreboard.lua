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

    pnl:AddColumn("Level", function(ply, label) return ply:GetNW2Int("MOAT_STATS_LVL", 1) end)
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

local function RemoveTTTScoreboard()
	if (IsValid(sboard_panel)) then
		sboard_panel:Remove()
		sboard_panel = nil
	end
end

local MGACommandMenu = {
	Votekick = {"Votekick", "Creates a vote that bans for 30 minutes if successful.", true, {
		{"Drop", "Choose Reason", {"Mic Spamming","Purposeful Mass RDM","Attempted Mass RDM","Chat Spamming","Hateful Conduct"}, "Reason required..."}
	}},
	Ban = {"Ban", "Bans a player or SteamID from the server.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Length", "1"},
			{"Drop", "Time Units", {"Minutes", "Hours", "Days", "Weeks", "Months", "Years"}, "Minutes"},
			{"Entry", "Reason", "Breaking Rules"}
	}},
	Kick = {"Kick", "Kicks a player from the server.", true, {
		{"Entry", "Reason", "Breaking Rules"}
	}},
	PM = {"PM", "Sends a private message to a player.", false, {
			{"Entry", "Message", "Say Something..."}
	}},
	AFK = {"AFK", "Forces a player into spectator mode.", true},
	UnAFK = {"UnAFK", "Forces a player out of spectator mode.", true}
}

local function OpenMGAMenu(cmd, ply)
	if (not IsValid(ply) or not MGACommandMenu[cmd]) then
		return
	end

	RemoveTTTScoreboard()

	MGA.OpenMenu()
	MGA.SelectedPlayer = {Ent = ply, Nick = ply:Nick(), SteamID = ply:SteamID()}
	MGA.HandleCommandPressed(MGACommandMenu[cmd])
end

local function moat_TTTScoreboardMenu(menu)
    local rank = LocalPlayer():GetUserGroup()
    local ply = menu.Player

	local function MenuAdd(txt, icon, func)
		return menu:AddOption(txt, function()
        	if (not IsValid(ply)) then
            	chat.AddText(Color(255, 0, 0), "Couldn't " .. txt .. " because the player left.")

            	return
        	end

        	func(ply)
    	end):SetImage(icon)
	end

	local function MenuPlayers(txt, icon, func, swap)
		if (IsValid(ply) and LocalPlayer() == ply and not swap) then
			return
		elseif (swap and IsValid(ply) and LocalPlayer() ~= ply) then
			return
		end

		return MenuAdd(txt, icon, func)
	end

	local function HandleClose()
		menu:AddSpacer()

		MenuAdd("Copy Name", "icon16/attach.png", function(p)
			SetClipboardText(p:Nick())
		end)

		MenuAdd("Copy ID", "icon16/attach.png", function(p)
			SetClipboardText(p:SteamID())
		end)

		if (rank == "communitylead") then
			MenuAdd("Copy Player", "icon16/application_xp_terminal.png", function(p)
				SetClipboardText("Player(" .. p:UserID() .. ")")
			end)
		end

		hook.Remove("Think", "moat_TTTSCoreboardMenuClose")
		hook.Add("Think", "moat_TTTSCoreboardMenuClose", function()
			if (not input.IsKeyDown(KEY_TAB)) then
				hook.Remove("Think", "moat_TTTSCoreboardMenuClose")

				if (IsValid(menu)) then
					menu:Remove()
				end

				return
			end
		end)
	end

	MenuAdd("Profile", "icon16/vcard.png", function(p)
		open_profile_card(p:SteamID64())
	end)

	MenuAdd("Steam", "icon16/joystick.png", function(p)
		p:ShowProfile()
	end)

	MenuAdd("Message", "icon16/user_comment.png", function(p)
		OpenMGAMenu("PM", p)
	end)

	MenuAdd("Trade Request", "icon16/world.png", function(p)
		net.Start("MOAT_SEND_TRADE_REQ")
        net.WriteDouble(p:EntIndex())
        net.SendToServer()
        surface.PlaySound("UI/buttonclick.wav")
	end)


	if (LocalPlayer():GetNW2Int("MOAT_STATS_LVL", 1) >= 100) then
		menu:AddSpacer()

		MenuPlayers("Edit Level", "icon16/color_wheel.png", MOAT_LEVELS.OpenTitleMenu, true)
	elseif (IsValid(ply) and LocalPlayer() ~= ply) then
		menu:AddSpacer()
	end

	if (cookie.GetNumber("moat_mute" .. ply:SteamID(), 0) == 1) then
		MenuPlayers("Unmute", "icon16/sound_mute.png", function(p)
			cookie.Set("moat_mute" .. p:SteamID(), "0")
			p:SetMuted(false)
		end)
	else
		MenuPlayers("Mute", "icon16/sound.png", function(p)
			cookie.Set("moat_mute" .. p:SteamID(), "1")
			p:SetMuted(true)
		end)
	end

	if (cookie.GetNumber("moat_block" .. ply:SteamID(), 0) == 1) then
		MenuPlayers("Unblock", "icon16/shield_delete.png", function(p)
			RunConsoleCommand("mga","unblock",p:SteamID())
		end)
	else
		MenuPlayers("Block", "icon16/shield_add.png", function(p)
			RunConsoleCommand("mga","block",p:SteamID())
		end)
	end

	if (IsValid(ply) and LocalPlayer() ~= ply and (rank and rank ~= "user")) then
		menu:AddSpacer()

		if (rank == "vip" or rank == "mvp" or rank == "hoodninja") then
			local sub, btn = menu:AddSubMenu "Votekick"
			btn:SetImage("icon16/door_open.png")
			sub:AddOption("Yes I'm sure", function()
				OpenMGAMenu("Votekick", ply)
			end):SetIcon("icon16/tick.png")
			sub:AddOption("Cancel"):SetIcon("icon16/cross.png")

			return HandleClose()
		end

		local afkm, afk = menu:AddSubMenu "AFK"
		afk:SetImage("icon16/user_orange.png")
        afkm:AddOption("Force AFK", function()
			OpenMGAMenu("AFK", ply)
        end):SetIcon("icon16/user_green.png")
		afkm:AddOption("Undo AFK", function()
			OpenMGAMenu("UnAFK", ply)
		end):SetIcon("icon16/user_red.png")

		MenuPlayers("Kick", "icon16/door_in.png", function(p)
			OpenMGAMenu("Kick", p)
		end)

		MenuPlayers("Ban", "icon16/lightning.png", function(p)
			OpenMGAMenu("Ban", p)
		end)

		if (rank == "trialstaff") then
			return HandleClose()
		end

		MenuPlayers("Bring", "icon16/arrow_down.png", function(p)
			RunConsoleCommand("mga","bring",p:SteamID())
		end)

		if (rank == "moderator") then
			return HandleClose()
		end

		MenuPlayers("Teleport", "icon16/eye.png", function(p)
			RunConsoleCommand("mga","tele",p:SteamID())
		end)
	end

	return HandleClose()
end

hook.Add("TTTScoreboardMenu", "moat_TTTScoreboardMenu", moat_TTTScoreboardMenu)

local function moat_UpdateDefaultTTTShit()
    if (not WSWITCH) then return end
    local margin = 10
    local height = 20
    local TryTranslation = LANG.TryTranslation

    function WSWITCH:DrawWeapon(x, y, c, wep)
        if not IsValid(wep) then return false end
        local name = wep.ItemName or wep.PrintName or "..."
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

        if (wep.ItemStats and wep.ItemStats.item and (wep.ItemStats.item.NameColor or wep.ItemStats.item.Rarity)) then
			spec.color = wep.ItemStats.item.NameColor or rarity_names[wep.ItemStats.item.Rarity][2]:Copy()
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