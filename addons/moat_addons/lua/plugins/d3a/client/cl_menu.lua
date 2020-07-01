D3A.Menu = {}

if (MGA and IsValid(MGA.Frame)) then
	MGA.Frame:Remove()
end

MGA = {
	FrameConf = {
		w = 601,
		h = 500,
		x = (ScrW()/2) - (601/2),
		y = (ScrH()/2) - (500/2)
	},
	CmdConf = {
		w = 187,
		h = 407,
		x = 10, 
		y = 52
	},
	PlyConf = {
		w = 197,
		h = 407,
		x = 202, 
		y = 52	
	},
	SubConf = {
		w = 187,
		h = 407,
		x = 404, 
		y = 52	
	}
}

local math 				= math
local table 			= table
local draw 				= draw
local team 				= team
local IsValid 			= IsValid
local CurTime 			= CurTime
local draw_SimpleText = draw.SimpleText
local draw_SimpleTextOutlined = draw.SimpleTextOutlined
local surface_SetFont = surface.SetFont
local surface_DrawRect = surface.DrawRect
local surface_DrawLine = surface.DrawLine
local surface_GetTextSize = surface.GetTextSize
local surface_DrawTexturedRect = surface.DrawTexturedRect
local surface_DrawOutlinedRect = surface.DrawOutlinedRect
local surface_SetDrawColor = surface.SetDrawColor
local surface_SetMaterial = surface.SetMaterial
local blur = Material("pp/blurscreen")
local gradient_u = Material("vgui/gradient-u")

local function DrawBlur(panel, amount, disable)
	if (disable) then return end
	
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface_SetDrawColor(255, 255, 255)
    surface_SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface_DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end

surface.CreateFont("DermaLargeSmall", {
	font = "DermaLarge",
	size = 18
})

surface.CreateFont("DermaLargeSmall2", {
	font = "DermaLarge",
	size = 16
})

surface.CreateFont("DermaLargeSmall3", {
	font = "DermaLarge",
	size = 12
})

--{Rank Weight Required, Rank Name, Rank Color in Menu, Commands}
--Commands: {Command Name, Description, Ignore Higher Players, Arguments}

MGA.CommandList = {
	{0, "User", Color(125, 125, 125, 255), {
		{"Block", "Blocks a player in game.", false},
		{"Map", "Changes the map of the server.", "None", {
			{"Drop", "Choose Map", {"Loading Maps...", "Loading Maps...", "Loading Maps..."}, "No Map Choosen"}
		}},
		{"MOTD", "Opens the MOTD.", "None"},
		{"Playtime", "Prints a player's playtime to your chat.", false},
		{"PM", "Sends a private message to a player.", false, {
			{"Entry", "Message", "Say Something..."}
		}},
		{"UnBlock", "Unblocks a player in game.", false},
	}},
	{10, "VIP & MVP", Color(1, 255, 31, 255), {
		{"Boost", "Boosts a map for the next map vote.", "None", {
			{"Drop", "Choose Map", {"Loading Maps...", "Loading Maps...", "Loading Maps..."}, "No Map Choosen"}
		}},
		{"Votekick", "Creates a vote that bans for 30 minutes if successful.", true, {
			{"Drop", "Choose Reason", {
				"Map Exploiting",
				"Attempted Mass RDM",
				"Mass RDM",
				"Meta Gaming",
				"Harassment",
				"Crashing The Server"
			}, "Reason required..."}
		}}
	}},
	{40, "Trial Staff", Color(41, 194, 245, 255), {
		{"AdminMode", "Rank is private.", "None"},
		{"ForceMOTD", "Forces a player to open the MOTD.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Length", "1"},
			{"Drop", "Time Units", {"Minutes", "Hours", "Days", "Weeks", "Months", "Years"}, "Minutes"}
		}},
		{"CloseMOTD", "Closes the MOTD for a player.", true},
		{"AFK", "Forces a player into spectator mode.", true},
		{"UnAFK", "Forces a player out of spectator mode.", true},
		{"ASlay", "Marks a player to be slain next round.", true, {
			{"Entry", "Rounds", "1"},
			{"Entry", "Reason", "Breaking Rules"}
		}},
		{"ASlayID", "Marks a SteamID to be slain next round.", "SteamID", {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Rounds", "1"},
			{"Entry", "Reason", "Breaking Rules"}
		}},
		{"RemoveSlays", "Removes the autoslays from a player.", true},
		{"Mute", "Mutes a player's text chat.", true},
		{"Gag", "Mutes a player's voice chat.", true},
		{"Kick", "Kicks a player from the server.", true, {
			{"Entry", "Reason", "Breaking Rules"}
		}},
		{"PO", "Prints any past offences (bans) that the player has.", false, {
			{"Entry", "SteamID", "STEAM_0:0:"},
		}},
		{"Ban", "Bans a player or SteamID from the server.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Length", "1"},
			{"Drop", "Time Units", {"Minutes", "Hours", "Days", "Weeks", "Months", "Years"}, "Minutes"},
			{"Entry", "Reason", "Breaking Rules"}
		}},
		{"Warn", "Warns a Player or SteamID next time they're online.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Reason", "Welcome! Press F3 to read rules ;) x"}
		}},
		{"PA", "Announces a message to the entire server.", "None", {
			{"Entry", "Message", "Testing..."}
		}}
	}},
	{50, "Moderator", Color(0, 102, 0, 255),  {
		{"VoiceBattery", "Enables the voice battery serverwide.", "None"},
		{"Bring", "Brings a player to your location.", true},
		{"Slay", "Slays a player immediately.", true},
		{"ClearDecals", "Clears the decals on the map.", "None"},
		{"Ban", "Bans a player or SteamID from the server.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Length", "1"},
			{"Drop", "Time Units", {"Minutes", "Hours", "Days", "Weeks", "Months", "Years"}, "Minutes"},
			{"Entry", "Reason", "Breaking Rules"}
		}},
	}},
	{60, "Administrator", Color(102, 0, 204, 255), {
		{"NoInvis", "Fixes any invisible players.", "None"},
		{"NoLag", "Freezes all physics objects on the server.", "None"},
		{"Tele", "Teleports a player to where you are looking.", true},
		{"Goto", "Teleports you to a player.", true},
		{"Perma", "Bans a player PERMANENTLY from the server.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Reason", "Breaking Rules"}
		}},
		{"Reconnect", "Forces a player to reconnect.", true},
		{"StopSounds", "Runs stopsound on every player.", "None"},
	}},
	{70, "Senior Administrator", Color(102, 0, 102, 255),  {
		{"Unban", "Unbans a SteamID from the server.", "SteamID", {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Reason", "Breaking Rules"}
		}},
		{"Map", "Changes the map.", "None", {
			{"Entry", "Map Name", "ttt_clue_se"}
		}},
		{"Reload", "Forces the map to reload.", "None"},
		{"Return", "Returns a player to their position before being teleported.", false}
	}},
	{80, "Head Administrator", Color(51, 0, 51, 255), {
		{"SetGroup", "Sets the group of a player.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Drop", "Group", {}, "user"}
		}},
		{"Wipe", "Wipes a player", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
		}},
		{"TradeBan", "Trade Bans a player", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Entry", "Length", "1"},
			{"Drop", "Time Units", {"Minutes", "Hours", "Days", "Weeks", "Months", "Years"}, "Minutes"},
			{"Entry", "Reason", "Breaking Rules"},
		}},
	}},
	{100, "Community Lead", Color(255, 0, 0, 255), {
		{"CrashBan", "Crash bans a user and permanently bans them.", false, {
			{"Entry", "Reason", "Can't function here."}
		}},
		{"Freeze", "Freezes a player.", false},
		{"Respawn", "Respawns a player.", false},
		{"Lua", "Runs Lua serverside.", "None", {
			{"Entry", "The Lua", "print 'test'"}
		}},
		{"LuaCL", "Runs clientside Lua on a player.", false, {
			{"Entry", "The Lua", "print 'test'"}
		}},
		{"RCON", "Runs a command through RCON.", "None", {
			{"Entry", "The Lua", "sv_friction 5"}
		}}
	}},
}

MGA.Colors = {
	Shadow = Color(0, 0, 0, 35),
	White = Color(255, 255, 255, 255),
	MGABlue = Color(30, 130, 255, 255),
	Red = Color(255, 0, 0, 255),
	Yellow = Color(255, 255, 0, 255),
	Gray = Color(183, 183, 183, 255)
}
MGA.CLP = {}
MGA.SelectedCommand = "None"
MGA.SelectedPlayer = {
	Ent = nil,
	Nick = "None",
	SteamID = "None"
}
MGA.StoredArguments = {}

-- Just for smooth scrolling :>
function MGA.PaintVBar(sbar)
    sbar.LerpTarget = 0

    function sbar:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()
        dlta = dlta * 75
        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll != self:GetScroll()
    end

    sbar.Think = function(s)
        local frac = FrameTime() * 5
        if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize/10)) then frac = FrameTime() * 2 end
        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        newpos = math.Clamp(newpos, 0, s.CanvasSize)
        s:SetScroll(newpos)
        if (s.LerpTarget < 0 and s:GetScroll() == 0) then
            s.LerpTarget = 0
        end
        if (s.LerpTarget > s.CanvasSize and s:GetScroll() == s.CanvasSize) then
            s.LerpTarget = s.CanvasSize
        end
    end
end

function MGA.HandleCommandPressed(cmd)
	if (MGA.SelectedCommand == cmd[1]) then
		MGA.SelectedCommand = "None"
		MGA.RebuildPlayerList()
		MGA.RebuildCommandArguments()
	else
		MGA.SelectedCommand = cmd[1]
		MGA.RebuildPlayerList(nil, cmd[3])
		MGA.RebuildCommandArguments(nil, cmd or {})
	end
end

function MGA.HandlePlayerPressed(pl)
	if (not IsValid(pl) or (IsValid(MGA2.SelectedPlayer.Ent) and MGA2.SelectedPlayer.Ent == pl)) then
		MGA.SelectedPlayer = {
			Ent = nil,
			Nick = "None",
			SteamID = "None"
		}
	else
		MGA.SelectedPlayer = {
			Ent = pl,
			Nick = pl:Nick(),
			SteamID = pl:SteamID()
		}
	end
end

function MGA.InsertCommandList(index, pnl)
	local cmdtitle = MGA.CommandList[index][2]
	local listcolor = MGA.CommandList[index][3]
	local cmdlist = MGA.CommandList[index][4]

	MGA.CLP[index] = {}

	local MGAL = MGA.CLP[index]

	MGAL.ListBtn = pnl:Add("DButton")
	MGAL.ListBtn:SetSize(MGA.CmdConf.w, 16)
	MGAL.ListBtn:SetText("")
	MGAL.ListBtn.Paint = function(s, w, h)
		surface_SetDrawColor(listcolor)
		surface_DrawRect(0, 0, w, h)

		draw_SimpleTextOutlined(cmdtitle, "DermaLargeSmall", w/2, h/2, MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
	end
	MGAL.ListBtn.AnimationActive = false
	MGAL.ListBtn.Closed = false
	MGAL.ListBtn.WasClosed = false
	MGAL.ListBtn.Think = function(s)
		if (s.WasClosed ~= s.Closed) then
			s.AnimationActive = true
		end

		if (s.AnimationActive) then
			pnl:Layout()
			local lp = MGAL.ListPnl

			if (s.Closed) then
				lp.CurrentHeight = Lerp(FrameTime() * 15, lp.CurrentHeight, 0)

				if (lp.CurrentHeight <= 0.5) then
					lp.CurrentHeight = 0
					s.AnimationActive = false
				end
			else
				lp.CurrentHeight = Lerp(FrameTime() * 15, lp.CurrentHeight, lp.FullHeight)

				if (lp.CurrentHeight >= lp.FullHeight - 0.5) then
					lp.CurrentHeight = lp.FullHeight
					s.AnimationActive = false
				end
			end

			lp:SetTall(lp.CurrentHeight)
		end

		s.WasClosed = s.Closed
	end
	MGAL.ListBtn.DoClick = function(s)
		if (s.AnimationActive) then return end
		s.Closed = not s.Closed
	end

	MGAL.ListPnl = pnl:Add("DPanel")
	MGAL.ListPnl:SetSize(MGA.CmdConf.w, #cmdlist * 16)
	MGAL.ListPnl:SetText("")
	MGAL.ListPnl.CurrentHeight = #cmdlist * 16
	MGAL.ListPnl.FullHeight = #cmdlist * 16
	MGAL.ListPnl.Paint = function(s, w, h)
		surface_SetDrawColor(listcolor.r, listcolor.g, listcolor.b, 20)
		surface_DrawRect(0, 0, w, h)
	end

	for i = 1, #cmdlist do
		local btn = vgui.Create("DButton", MGAL.ListPnl)
		btn:SetSize(MGA.CmdConf.w, 16)
		btn:SetPos(0, (i - 1) * 16)
		btn:SetText("")
		btn:SetTooltip(cmdlist[i][2])
		btn.Cmd = cmdlist[i][1]
		btn.LerpNum = 0

		if (i % 2 == 0) then
			btn.SweetLine = true
		end

		btn.Paint = function(s, w, h)
			if (s:IsHovered() or MGA.SelectedCommand == s.Cmd) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, ((btn.SweetLine and 125) or 50) + (50 * s.LerpNum))
			surface_DrawRect(0, 0, w, h)

			draw_SimpleTextOutlined(s.Cmd, "DermaLargeSmall2", w/2, h/2, MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")
			if cmdlist[i][1] == "Votekick" then
				Derma_Message("Make sure to CALL FOR STAFF IN DISCORD FIRST.\nAbuse of votekick will result in a ban from the servers.","Warning", "Ok")
			end
			MGA.HandleCommandPressed(cmdlist[i])
		end
	end
end

function MGA.RebuildPlayerList(pnl, ignore)
	if (not pnl) then
		if (not MGA or (MGA and not MGA.PlyPanel)) then return end
		
		pnl = MGA.PlyPanel
	end

	if (MGA.PlayerList) then
		for i = 1, #MGA.PlayerList do
			MGA.PlayerList[i]:Remove()
		end
	end

	MGA.PlayerList = {}
	MGA.StoredArguments = {}

	if (isstring(ignore)) then
		local btn = pnl:Add("DPanel")
		btn:SetSize(MGA.PlyConf.w, 20)
		if (ignore == "SteamID") then
			btn.Paint = function(s, w, h)
				draw_SimpleTextOutlined("Use SteamID", "DermaLargeSmall2", w/2, h/2, MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
			end
		else
			btn.Paint = function(s, w, h)
				draw_SimpleTextOutlined("No Player Needed", "DermaLargeSmall2", w/2, h/2, MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
			end
		end

		MGA.SelectedPlayer = {
			Ent = nil,
			Nick = "None",
			SteamID = "None"
		}

		table.insert(MGA.PlayerList, btn)
		return
	end

	local minimilist = GetConVar("moat_mga_playerlist"):GetInt() == 1
	local SortedPlayers = table.Copy(player.GetAll())

	table.sort(SortedPlayers, function(a, b) return a:GetNW2Int("MOAT_STATS_LVL", 1) < b:GetNW2Int("MOAT_STATS_LVL", 1) end)

	for k, v in ipairs(SortedPlayers) do
		if (ignore and v:GetGroupWeight() > LocalPlayer():GetGroupWeight()) then
			continue
		end

		local btn = pnl:Add("DButton")
		btn:SetSize(MGA.PlyConf.w, 24)

		if (minimilist) then
			btn:SetSize(MGA.PlyConf.w, 16)
		end

		btn:SetText("")
		btn.LerpNum = 0

		btn.PlayerInfo = {
			Nick = v:Nick(),
			SteamID = v:SteamID(),
			Rank = v:GetUserGroup(),
			Ent = v
		}

		if (k % 2 == 0) then
			btn.SweetLine = true
		end

		btn.Paint = function(s, w, h)
			if (s:IsHovered() or (MGA.SelectedPlayer.Ent and MGA.SelectedPlayer.Ent:IsValid() and IsValid(MGA.SelectedPlayer.Ent) and MGA.SelectedPlayer.Ent == s.PlayerInfo.Ent)) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface_SetDrawColor(50 + (1 * s.LerpNum), 50 + (103 * s.LerpNum), 50 + (205 * s.LerpNum), ((btn.SweetLine and 100 * s.LerpNum) or 100) + (50 * s.LerpNum))
			surface_DrawRect(0, 0, w, h)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")

			MGA.HandlePlayerPressed(v)
		end

		local ava = vgui.Create("AvatarImage", btn)
		ava:SetSize(20, 20)
		ava:SetPos(2, 2)
		if (minimilist) then
			ava:SetSize(16, 16)
			ava:SetPos(0, 0)
		end
		ava:SetPlayer(v, 32)
		ava.OnMousePressed = function(s)
			btn.DoClick()
		end
		
		local lbl1 = vgui.Create("DLabel", btn)
		lbl1:SetSize(MGA.PlyConf.w - 26, 10)
		lbl1:SetPos(24, 2)
		lbl1:SetTextColor(Color(255, 255, 255))
		lbl1:SetFont("DermaLargeSmall2")
		lbl1:SetText(btn.PlayerInfo.Nick)

		local lbl2 = vgui.Create("DLabel", btn)
		lbl2:SetSize(MGA.PlyConf.w - 26, 12)
		lbl2:SetPos(24, 11)
		lbl2:SetTextColor(Color(150, 150, 150))
		lbl2:SetFont("DermaLargeSmall3")
		lbl2:SetText(btn.PlayerInfo.SteamID)

		if (minimilist) then
			lbl2:SetSize(MGA.PlyConf.w - 26, 0)
		end

		table.insert(MGA.PlayerList, btn)
	end
end

function MGA.RebuildCommandArguments(pnl, cmdd)
	if (not pnl) then
		if (not MGA or (MGA and not MGA.ArgPanel)) then return end
		
		pnl = MGA.ArgPanel
	end

	local cmd = {}

	if (cmdd and cmdd[4]) then
		cmd = cmdd[4]
	end

	if (MGA.ArgumentList) then
		for i = 1, #MGA.ArgumentList do
			MGA.ArgumentList[i]:Remove()
		end
	end

	if (MGA.ArgumentListLabels) then
		for i = 1, #MGA.ArgumentListLabels do
			MGA.ArgumentListLabels[i]:Remove()
		end
	end

	MGA.ArgumentListLabels = {}
	MGA.ArgumentList = {}
	MGA.StoredArguments = {}

	if (MGA.SelectedCommand == "None") then return end

	for i = 1, #cmd do
		local lbl = pnl:Add("DLabel")
		lbl:SetSize(MGA.SubConf.w - 10, 16)
		lbl:SetFont("DermaLargeSmall2")
		lbl:SetTextColor(MGA.Colors.White)
		lbl:SetText(cmd[i][2] .. ":")
		table.insert(MGA.ArgumentListLabels, lbl)

		if (cmd[i][1] == "Entry") then
			local entry = pnl:Add("DTextEntry")
			entry:SetWide(MGA.SubConf.w - 10)
			entry:SetText("")
			entry.label = cmd[i][2]
			entry.OnGetFocus = function(s)
				MGA.Frame:SetKeyboardInputEnabled(true)
			end
			entry.OnLoseFocus = function(s)
				MGA.Frame:SetKeyboardInputEnabled(false)
			end
            entry:SetFont("DermaLargeSmall2")
            entry:SetTextColor(Color(255, 255, 255))
            entry:SetCursorColor(Color(255, 255, 255))
            entry:SetEnterAllowed(true)
            entry:SetTabbingDisabled(true)
            entry:SetDrawBackground(false)
            entry:SetMultiline(false)
            entry.ExampleColor = 50
            entry.DefaultEntry = cmd[i][3]
            entry.BorderColor = MGA.Colors.MGABlue
            entry.Think = function(s)
                if (s:GetValue() == "") then
                    s.ExampleColor = 50
                else
                    s.ExampleColor = 0
                end

                if (entry.label == "SteamID" and MGA.SelectedPlayer.Ent and MGA.SelectedPlayer.Ent:IsValid() and IsValid(MGA.SelectedPlayer.Ent)) then
                	s:SetDisabled(true)
                	s.BorderColor = MGA.Colors.Gray
                	s.ExampleOverride = MGA.SelectedPlayer.Nick
                else
                	s:SetDisabled(false)
                	s.ExampleOverride = nil
                	s.BorderColor = MGA.Colors.MGABlue
                end
            end
            entry.Paint = function(s, w, h)
				surface_SetDrawColor(0, 0, 0, 150)
				surface_DrawRect(0, 0, w, h)

				surface_SetDrawColor(s.BorderColor)
				surface_DrawOutlinedRect(0, 0, w, h)

				if (s.ExampleOverride) then
					draw_SimpleText(s.ExampleOverride, "DermaLargeSmall2", 3, 2, Color(255, 255, 255, s.ExampleColor))
				else
					draw_SimpleText(s.DefaultEntry, "DermaLargeSmall2", 3, 2, Color(255, 255, 255, s.ExampleColor))
				end

				s:DrawTextEntryText(MGA.Colors.White, Color(30, 130, 255), MGA.Colors.White)
			end
            entry.MaxChars = 192

            if (cmd[i][2] and cmd[i][2] == "The Lua") then
            	entry.MaxChars = 9999	
            end

            entry.OnTextChanged = function(s)
                local txt = s:GetValue()
                local amt = txt:len()

                if (amt > s.MaxChars or string.sub(tostring(txt), #txt, #txt) == "#") then
                    if (s.OldText == nil) then
                        s:SetText("")
                        s:SetValue("")
                        s:SetCaretPos(string.len(""))
                    else
                        s:SetText(s.OldText)
                        s:SetValue(s.OldText)
                        s:SetCaretPos(string.len(s.OldText))
                    end
                else
                    s.OldText = txt
                end
            end

			table.insert(MGA.ArgumentList, entry)
		elseif (cmd[i][1] == "Drop") then
			if (cmd[i][2] == "Group") then
				cmd[i][3] = moat.Ranks.Table()
			end

			if (cmd[i][2] == "Choose Map") then
				cmd[i][3] = MGA.Maps or {}
			end

			local combo = pnl:Add("DComboBox")
			combo:SetWide(MGA.SubConf.w - 10)
			combo:SetValue(cmd[i][4])
			combo.label = cmd[i][2]
			combo.DefaultEntry = cmd[i][4]
			for k, v in ipairs(cmd[i][3]) do
				combo:AddChoice(cmd[i][3][k])
			end

			table.insert(MGA.ArgumentList, combo)
		end
	end

	if (#cmd == 0) then
		local lbl = pnl:Add("DLabel")
		lbl:SetSize(MGA.SubConf.w - 10, 16)
		lbl:SetFont("DermaLargeSmall2")
		lbl:SetTextColor(MGA.Colors.White)
		lbl:SetText("No Arguments Needed")
		lbl:SetContentAlignment(5)
		table.insert(MGA.ArgumentListLabels, lbl)
	end

	local sub = pnl:Add("DButton")
	sub:SetSize(MGA.SubConf.w - 10, 24)
	sub:SetText("")
	sub.LerpNum = 0
	sub.Paint = function(s, w, h)
		if (s:IsHovered()) then
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
		else
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
		end

		surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		draw_SimpleTextOutlined(cmdd[1], "DermaLargeSmall", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
	end
	sub.OnCursorEntered = function(s)
		surface.PlaySound("ui/buttonrollover.wav")
	end
	sub.DoClick = function(s)
		surface.PlaySound("ui/buttonclickrelease.wav")
		local args = {}

		for i = 1, #MGA.ArgumentList do
			local ar = MGA.ArgumentList[i]

			if (ar.GetText and #ar:GetText() ~= 0) then
				table.insert(args, {ar:GetText(), ar.label == "SteamID"})
			elseif (ar.GetValue and #ar:GetValue() ~= 0) then
				table.insert(args, {ar:GetValue(), ar.label == "SteamID"})
			elseif (ar.GetSelected) then
				table.insert(args, {ar:GetSelected(), ar.label == "SteamID"})
			elseif (MGA.ArgumentList[i].DefaultEntry ~= "STEAM_0:0:") then
				table.insert(args, {MGA.ArgumentList[i].DefaultEntry, ar.label == "SteamID"})
			end
		end

		local targ = MGA.SelectedPlayer.SteamID

		--This weird fuckery because BOT's are weird and have no SteamID
		if (targ == "None" and args[1] and args[1][2] and cmdd[3] ~= "None") then
			targ = args[1][1]
			table.remove(args, 1)
		elseif (targ == "NULL" and args[1] and args[1][2]) then
			targ = MGA.SelectedPlayer.Nick
			table.remove(args, 1)
		elseif (targ == "NULL" and ((args[1] and not args[1][2]) or not args[1])) then
			targ = MGA.SelectedPlayer.Nick
		end

		local acargs = {}

		for i = 1, #args do
			table.insert(acargs, args[i][1])
		end

		if (cmdd[3] ~= "None") then
			RunConsoleCommand("mga", cmdd[1], targ, unpack(acargs))
		else
			RunConsoleCommand("mga", cmdd[1], unpack(acargs))
		end

		MGA.Frame:SetKeyboardInputEnabled(false)
	end

	table.insert(MGA.ArgumentListLabels, sub)
end

-- Make command red and caps when selected
MGA.WarnCommands = {
	["Kick"] = true,
	["Votekick"] = true,
	["Ban"] = true,
	["Slay"] = true,
	["Perma"] = true,
	["SetGroup"] = true,
}

function MGA.OpenMenu()
	local shouldanimate = GetConVar("moat_mga_animation"):GetInt() == 1

	if (IsValid(MGA.Frame)) then
		if (shouldanimate) then
			MGA.Frame:MoveTo(MGA.FrameConf.x, MGA.FrameConf.y - 10, 0.2, 0, -1, function(a, p)
				p:MoveTo(MGA.FrameConf.x, ScrH(), 0.1, 0, -1, function(a, p)
					p:Remove()
				end)
			end)
		else
			MGA.Frame:Remove()
		end

		return
	end

	local LocalRank = LocalPlayer():GetUserGroup()
	local LocalRankWeight = LocalPlayer():GetGroupWeight()
	local LocalNick = LocalPlayer():Nick()

	MGA.Frame = vgui.Create("DFrame")
	MGA.Frame:SetTitle("")

	if (shouldanimate) then
		MGA.Frame:SetPos(MGA.FrameConf.x, ScrH())
	else
		MGA.Frame:SetPos(MGA.FrameConf.x, MGA.FrameConf.y)
	end

	MGA.Frame:SetSize(MGA.FrameConf.w, MGA.FrameConf.h)
	MGA.Frame.Think = function(s) end
	MGA.Frame:MakePopup()
	MGA.Frame:SetKeyboardInputEnabled(false)
	MGA.Frame:ShowCloseButton(false)
	MGA.Frame.Paint = function(s, w, h)
		surface_SetDrawColor(183, 183, 183)
		surface_DrawLine(0, 25, w, 25)
		surface_DrawLine(0, h - 1, w, h - 1)

		surface_SetFont("DermaLarge")

		local tw = surface_GetTextSize("MGA Command Menu")
		local tw2 = draw_SimpleTextOutlined("M", "DermaLarge", (w/2) - (tw/2), -4, MGA.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA.Colors.Shadow)
		local tw3 = draw_SimpleTextOutlined("G", "DermaLarge", (w/2) - (tw/2) + tw2, -4, MGA.Colors.MGABlue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA.Colors.Shadow)
		local tw4 = draw_SimpleTextOutlined("A Command Menu", "DermaLarge", (w/2) - (tw/2) + tw2 + tw3, -4, MGA.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA.Colors.Shadow)
	end

	if (shouldanimate) then
		MGA.Frame:MoveTo(MGA.FrameConf.x, MGA.FrameConf.y - 10, 0.2, 0, -1, function(a, p)
			p:MoveTo(MGA.FrameConf.x, MGA.FrameConf.y, 0.1, 0, -1, function(a, p)
			end)
		end)
	end

	MGA.CloseButton = vgui.Create("DButton", MGA.Frame)
	MGA.CloseButton:SetPos(MGA.FrameConf.w - 20, 0)
	MGA.CloseButton:SetSize(20, 20)
	MGA.CloseButton:SetText("")
	MGA.CloseButton.Paint = function(s, w, h)
		draw_SimpleTextOutlined("r", "marlett", w/2, h/2, s:IsHovered() and MGA.Colors.Red or MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
	end
	MGA.CloseButton.DoClick = function(s)
		MGA.Frame:Remove()
	end

	local shoulddisableblur = GetConVar("moat_mga_lowend"):GetInt() == 1

	MGA.BGPanel = vgui.Create("DPanel", MGA.Frame)
	MGA.BGPanel:SetPos(0, 3 + 25)
	MGA.BGPanel:SetSize(MGA.FrameConf.w, MGA.FrameConf.h - 6 - 25)
	MGA.BGPanel.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 150)
		surface_DrawRect(0, 0, w, h)
		DrawBlur(s, 2, shoulddisableblur)

		draw_SimpleTextOutlined(LocalNick, "DermaLargeSmall", 52, 8, MGA.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)
		draw_SimpleTextOutlined(moat.Ranks.Get(LocalRank, "Name"), "DermaLargeSmall", 52, 24, moat.Ranks.Get(LocalRank, "Color"), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)

		surface_SetFont("DermaLargeSmall")

		local cmdup = (MGA.WarnCommands[MGA.SelectedCommand] and MGA.SelectedCommand:upper()) or MGA.SelectedCommand
		local tw = surface_GetTextSize("Selected Command: " .. cmdup)
		local tw2 = draw_SimpleTextOutlined("Selected Command: ", "DermaLargeSmall", w - 10 - tw, 8, MGA.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)
		draw_SimpleTextOutlined(cmdup, "DermaLargeSmall", w - 10 - tw + tw2, 8, (MGA.WarnCommands[MGA.SelectedCommand] and MGA.Colors.Red) or MGA.Colors.MGABlue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)

		local plyup = MGA.SelectedPlayer.Nick
		local tw = surface_GetTextSize("Selected Player: " .. plyup)
		local tw2 = draw_SimpleTextOutlined("Selected Player: ", "DermaLargeSmall", w - 10 - tw, 24, MGA.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)
		draw_SimpleTextOutlined(plyup, "DermaLargeSmall", w - 10 - tw + tw2, 24,  (MGA.SelectedPlayer.Nick ~= "None" and MGA.Colors.Yellow) or MGA.Colors.MGABlue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)

		local plist = 0
		if (MGA.PlayerList) then
			plist = #MGA.PlayerList
		end
		draw_SimpleTextOutlined("Player List(" .. plist .. ")", "DermaLargeSmall2", MGA.PlyConf.x + (MGA.PlyConf.w/2), 41, MGA.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA.Colors.Shadow)
	end

	/*---------------------------------------------------------------------------
	Avatar Image
	---------------------------------------------------------------------------*/
	MGA.SelfAva = vgui.Create("AvatarImage", MGA.BGPanel)
	MGA.SelfAva:SetPos(10, 10)
	MGA.SelfAva:SetSize(32, 32)
	MGA.SelfAva:SetPlayer(LocalPlayer(), 64)

	/*---------------------------------------------------------------------------
	Command List
	---------------------------------------------------------------------------*/
	MGA.CmdScroll = vgui.Create("DScrollPanel", MGA.BGPanel)
	MGA.CmdScroll:SetSize(MGA.CmdConf.w, MGA.CmdConf.h)
	MGA.CmdScroll:SetPos(MGA.CmdConf.x, MGA.CmdConf.y)
	MGA.CmdScroll.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end
	MGA.CmdScroll.VBar:SetWide(0)
	MGA.PaintVBar(MGA.CmdScroll.VBar)

	MGA.CmdPanel = vgui.Create("DIconLayout", MGA.CmdScroll)
	MGA.CmdPanel:SetSize(MGA.CmdConf.w, MGA.CmdConf.h)
	MGA.CmdPanel:SetPos(0, 0)
	MGA.CmdPanel:SetSpaceX(0)
	MGA.CmdPanel:SetSpaceY(0)

	/*---------------------------------------------------------------------------
	Player List
	---------------------------------------------------------------------------*/
	MGA.PlyScroll = vgui.Create("DScrollPanel", MGA.BGPanel)
	MGA.PlyScroll:SetSize(MGA.PlyConf.w, MGA.PlyConf.h)
	MGA.PlyScroll:SetPos(MGA.PlyConf.x, MGA.PlyConf.y)
	MGA.PlyScroll.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end
	MGA.PlyScroll.VBar:SetWide(0)
	MGA.PaintVBar(MGA.PlyScroll.VBar)

	MGA.PlyPanel = vgui.Create("DIconLayout", MGA.PlyScroll)
	MGA.PlyPanel:SetSize(MGA.PlyConf.w, MGA.PlyConf.h)
	MGA.PlyPanel:SetPos(0, 0)
	MGA.PlyPanel:SetSpaceX(0)
	MGA.PlyPanel:SetSpaceY(0)

	/*---------------------------------------------------------------------------
	Arguments List + Submit
	---------------------------------------------------------------------------*/
	MGA.ArgScroll = vgui.Create("DScrollPanel", MGA.BGPanel)
	MGA.ArgScroll:SetSize(MGA.SubConf.w, MGA.SubConf.h)
	MGA.ArgScroll:SetPos(MGA.SubConf.x, MGA.SubConf.y)
	MGA.ArgScroll.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end

	MGA.ArgPanel = vgui.Create("DIconLayout", MGA.ArgScroll)
	MGA.ArgPanel:SetSize(MGA.SubConf.w - 5, MGA.SubConf.h - 5)
	MGA.ArgPanel:SetPos(5, 5)
	MGA.ArgPanel:SetSpaceX(5)
	MGA.ArgPanel:SetSpaceY(5)


	/*---------------------------------------------------------------------------
	Insert Commands List
	---------------------------------------------------------------------------*/

	MGA.CLP = {}
	MGA.SelectedCommand = "None"
	MGA.SelectedPlayer = {
		Ent = nil,
		Nick = "None",
		SteamID = "None"
	}

	for i = 1, #MGA.CommandList do
		if (LocalRankWeight >= MGA.CommandList[i][1]) then
			MGA.InsertCommandList(i, MGA.CmdPanel)
		end
	end

	/*---------------------------------------------------------------------------
	Insert Players List
	---------------------------------------------------------------------------*/
	MGA.RebuildPlayerList(MGA.PlyPanel)

	if (MGA.Maps == nil) then
		MGA.Maps = {}

		net.Start "MGA.SendMaps"
		net.SendToServer()
	end
end

MGA2 = {
	FrameConf = {
		w = 888,
		h = 702,
		x = (ScrW()/2) - (888/2),
		y = (ScrH()/2) - (702/2)
	},
	CmdConf = {
		w = 281,
		h = 611,
		x = 10, 
		y = 52
	},
	PlyConf = {
		w = 296,
		h = 611,
		x = 296, 
		y = 52
	},
	SubConf = {
		w = 281,
		h = 611,
		x = 597, 
		y = 52	
	}
}

MGA2.Colors = {
	Shadow = Color(0, 0, 0, 35),
	White = Color(255, 255, 255, 255),
	MGA2Blue = Color(30, 130, 255, 255),
	Red = Color(255, 0, 0, 255),
	Yellow = Color(255, 255, 0, 255),
	Gray = Color(183, 183, 183, 255)
}
MGA2.CLP = {}
MGA2.SelectedCommand = "None"
MGA2.SelectedPlayer = {
	Ent = nil,
	Nick = "None",
	SteamID = "None"
}
MGA2.StoredArguments = {}

-- Just for smooth scrolling :>
function MGA2.PaintVBar(sbar)
    sbar.LerpTarget = 0

    function sbar:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()
        dlta = dlta * 75
        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll != self:GetScroll()
    end

    sbar.Think = function(s)
        local frac = FrameTime() * 5
        if (math.abs(s.LerpTarget - s:GetScroll()) <= (s.CanvasSize/10)) then frac = FrameTime() * 2 end
        local newpos = Lerp(frac, s:GetScroll(), s.LerpTarget)
        newpos = math.Clamp(newpos, 0, s.CanvasSize)
        s:SetScroll(newpos)
        if (s.LerpTarget < 0 and s:GetScroll() == 0) then
            s.LerpTarget = 0
        end
        if (s.LerpTarget > s.CanvasSize and s:GetScroll() == s.CanvasSize) then
            s.LerpTarget = s.CanvasSize
        end
    end
end

function MGA2.HandleCommandPressed(cmd)
	if (MGA2.SelectedCommand == cmd[1]) then
		MGA2.SelectedCommand = "None"
		MGA2.RebuildPlayerList()
		MGA2.RebuildCommandArguments()
	else
		MGA2.SelectedCommand = cmd[1]
		MGA2.RebuildPlayerList(nil, cmd[3])
		MGA2.RebuildCommandArguments(nil, cmd or {})
	end
end

function MGA2.HandlePlayerPressed(pl)
	if (not IsValid(pl) or (IsValid(MGA2.SelectedPlayer.Ent) and MGA2.SelectedPlayer.Ent == pl)) then
		MGA2.SelectedPlayer = {
			Ent = nil,
			Nick = "None",
			SteamID = "None"
		}
	else
		MGA2.SelectedPlayer = {
			Ent = pl,
			Nick = pl:Nick(),
			SteamID = pl:SteamID()
		}
	end
end

function MGA2.InsertCommandList(index, pnl)
	local cmdtitle = MGA.CommandList[index][2]
	local listcolor = MGA.CommandList[index][3]
	local cmdlist = MGA.CommandList[index][4]

	MGA2.CLP[index] = {}

	local MGA2L = MGA2.CLP[index]

	MGA2L.ListBtn = pnl:Add("DButton")
	MGA2L.ListBtn:SetSize(MGA2.CmdConf.w, 24)
	MGA2L.ListBtn:SetText("")
	MGA2L.ListBtn.Paint = function(s, w, h)
		surface_SetDrawColor(listcolor)
		surface_DrawRect(0, 0, w, h)

		draw_SimpleTextOutlined(cmdtitle, "DermaLargeSmall_", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
	end
	MGA2L.ListBtn.AnimationActive = false
	MGA2L.ListBtn.Closed = false
	MGA2L.ListBtn.WasClosed = false
	MGA2L.ListBtn.Think = function(s)
		if (s.WasClosed ~= s.Closed) then
			s.AnimationActive = true
		end

		if (s.AnimationActive) then
			pnl:Layout()
			local lp = MGA2L.ListPnl

			if (s.Closed) then
				lp.CurrentHeight = Lerp(FrameTime() * 15, lp.CurrentHeight, 0)

				if (lp.CurrentHeight <= 0.5) then
					lp.CurrentHeight = 0
					s.AnimationActive = false
				end
			else
				lp.CurrentHeight = Lerp(FrameTime() * 15, lp.CurrentHeight, lp.FullHeight)

				if (lp.CurrentHeight >= lp.FullHeight - 0.5) then
					lp.CurrentHeight = lp.FullHeight
					s.AnimationActive = false
				end
			end

			lp:SetTall(lp.CurrentHeight)
		end

		s.WasClosed = s.Closed
	end
	MGA2L.ListBtn.DoClick = function(s)
		if (s.AnimationActive) then return end
		s.Closed = not s.Closed
	end

	MGA2L.ListPnl = pnl:Add("DPanel")
	MGA2L.ListPnl:SetSize(MGA2.CmdConf.w, #cmdlist * 24)
	MGA2L.ListPnl:SetText("")
	MGA2L.ListPnl.CurrentHeight = #cmdlist * 24
	MGA2L.ListPnl.FullHeight = #cmdlist * 24
	MGA2L.ListPnl.Paint = function(s, w, h)
		surface_SetDrawColor(listcolor.r, listcolor.g, listcolor.b, 20)
		surface_DrawRect(0, 0, w, h)
	end

	for i = 1, #cmdlist do
		local btn = vgui.Create("DButton", MGA2L.ListPnl)
		btn:SetSize(MGA2.CmdConf.w, 24)
		btn:SetPos(0, (i - 1) * 24)
		btn:SetText("")
		btn:SetTooltip(cmdlist[i][2])
		btn.Cmd = cmdlist[i][1]
		btn.LerpNum = 0

		if (i % 2 == 0) then
			btn.SweetLine = true
		end

		btn.Paint = function(s, w, h)
			if (s:IsHovered() or MGA2.SelectedCommand == s.Cmd) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, ((btn.SweetLine and 125) or 50) + (50 * s.LerpNum))
			surface_DrawRect(0, 0, w, h)

			draw_SimpleTextOutlined(s.Cmd, "DermaLargeSmall_", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")
			if cmdlist[i][1] == "Votekick" then
				Derma_Message("Make sure to CALL FOR STAFF IN DISCORD FIRST.\nAbuse of votekick will result in a ban from the servers.","Warning", "Ok")
			end
			MGA2.HandleCommandPressed(cmdlist[i])
		end
	end
end

function MGA2.RebuildPlayerList(pnl, ignore)
	if (not pnl) then
		if (not MGA2 or (MGA2 and not MGA2.PlyPanel)) then return end
		
		pnl = MGA2.PlyPanel
	end

	if (MGA2.PlayerList) then
		for i = 1, #MGA2.PlayerList do
			MGA2.PlayerList[i]:Remove()
		end
	end

	MGA2.PlayerList = {}
	MGA2.StoredArguments = {}

	if (isstring(ignore)) then
		local btn = pnl:Add("DPanel")
		btn:SetSize(MGA2.PlyConf.w, 20)
		if (ignore == "SteamID") then
			btn.Paint = function(s, w, h)
				draw_SimpleTextOutlined("Use SteamID", "DermaLargeSmall2_", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
			end
		else
			btn.Paint = function(s, w, h)
				draw_SimpleTextOutlined("No Player Needed", "DermaLargeSmall2_", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
			end
		end

		MGA2.SelectedPlayer = {
			Ent = nil,
			Nick = "None",
			SteamID = "None"
		}

		table.insert(MGA2.PlayerList, btn)
		return
	end

	local minimilist = GetConVar("moat_mga_playerlist"):GetInt() == 1
	local SortedPlayers = table.Copy(player.GetAll())

	table.sort(SortedPlayers, function(a, b) return a:GetNW2Int("MOAT_STATS_LVL", 1) < b:GetNW2Int("MOAT_STATS_LVL", 1) end)

	for k, v in ipairs(SortedPlayers) do
		if (ignore and v:GetGroupWeight() > LocalPlayer():GetGroupWeight()) then
			continue
		end

		local btn = pnl:Add("DButton")
		btn:SetSize(MGA2.PlyConf.w, 28)

		if (minimilist) then
			btn:SetSize(MGA2.PlyConf.w, 24)
		end

		btn:SetText("")
		btn.LerpNum = 0

		btn.PlayerInfo = {
			Nick = v:Nick(),
			SteamID = v:SteamID(),
			Rank = v:GetUserGroup(),
			Ent = v
		}

		if (k % 2 == 0) then
			btn.SweetLine = true
		end

		btn.Paint = function(s, w, h)
			if (s:IsHovered() or (MGA2.SelectedPlayer.Ent and MGA2.SelectedPlayer.Ent:IsValid() and IsValid(MGA2.SelectedPlayer.Ent) and MGA2.SelectedPlayer.Ent == s.PlayerInfo.Ent)) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface_SetDrawColor(50 + (1 * s.LerpNum), 50 + (103 * s.LerpNum), 50 + (205 * s.LerpNum), ((btn.SweetLine and 100 * s.LerpNum) or 100) + (50 * s.LerpNum))
			surface_DrawRect(0, 0, w, h)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")

			MGA2.HandlePlayerPressed(v)
		end

		local ava = vgui.Create("AvatarImage", btn)
		ava:SetSize(24, 24)
		ava:SetPos(2, 2)
		if (minimilist) then
			ava:SetSize(24, 24)
			ava:SetPos(0, 0)
		end
		ava:SetPlayer(v, 32)
		ava.OnMousePressed = function(s)
			btn.DoClick()
		end
		
		local lbl1 = vgui.Create("DLabel", btn)
		lbl1:SetSize(MGA2.PlyConf.w - 26, 16)
		lbl1:SetPos(30, -1)
		lbl1:SetTextColor(Color(255, 255, 255))
		lbl1:SetFont("DermaLargeSmall_")
		lbl1:SetText(btn.PlayerInfo.Nick)

		local lbl2 = vgui.Create("DLabel", btn)
		lbl2:SetSize(MGA2.PlyConf.w - 26, 20)
		lbl2:SetPos(30, 10)
		lbl2:SetTextColor(Color(150, 150, 150))
		lbl2:SetFont("DermaLargeSmall2_")
		lbl2:SetText(btn.PlayerInfo.SteamID)

		if (minimilist) then
			lbl1:SetPos(32, 3)
			lbl2:SetSize(MGA2.PlyConf.w - 26, 0)
		end

		table.insert(MGA2.PlayerList, btn)
	end
end

function MGA2.RebuildCommandArguments(pnl, cmdd)
	if (not pnl) then
		if (not MGA2 or (MGA2 and not MGA2.ArgPanel)) then return end
		
		pnl = MGA2.ArgPanel
	end

	local cmd = {}

	if (cmdd and cmdd[4]) then
		cmd = cmdd[4]
	end

	if (MGA2.ArgumentList) then
		for i = 1, #MGA2.ArgumentList do
			MGA2.ArgumentList[i]:Remove()
		end
	end

	if (MGA2.ArgumentListLabels) then
		for i = 1, #MGA2.ArgumentListLabels do
			MGA2.ArgumentListLabels[i]:Remove()
		end
	end

	MGA2.ArgumentListLabels = {}
	MGA2.ArgumentList = {}
	MGA2.StoredArguments = {}

	if (MGA2.SelectedCommand == "None") then return end

	for i = 1, #cmd do
		local lbl = pnl:Add("DLabel")
		lbl:SetSize(MGA2.SubConf.w - 10, 20)
		lbl:SetFont("DermaLargeSmall_")
		lbl:SetTextColor(MGA2.Colors.White)
		lbl:SetText(cmd[i][2] .. ":")
		table.insert(MGA2.ArgumentListLabels, lbl)

		if (cmd[i][1] == "Entry") then
			local entry = pnl:Add("DTextEntry")
			entry:SetSize(MGA2.SubConf.w - 10, 25)
			entry:SetText("")
			entry.label = cmd[i][2]
			entry.OnGetFocus = function(s)
				MGA2.Frame:SetKeyboardInputEnabled(true)
			end
			entry.OnLoseFocus = function(s)
				MGA2.Frame:SetKeyboardInputEnabled(false)
			end
            entry:SetFont("DermaLargeSmall_")
            entry:SetTextColor(Color(255, 255, 255))
            entry:SetCursorColor(Color(255, 255, 255))
            entry:SetEnterAllowed(true)
            entry:SetTabbingDisabled(true)
            entry:SetDrawBackground(false)
            entry:SetMultiline(false)
            entry.ExampleColor = 50
            entry.DefaultEntry = cmd[i][3]
            entry.BorderColor = MGA2.Colors.MGA2Blue
            entry.Think = function(s)
                if (s:GetValue() == "") then
                    s.ExampleColor = 50
                else
                    s.ExampleColor = 0
                end

                if (entry.label == "SteamID" and MGA2.SelectedPlayer.Ent and MGA2.SelectedPlayer.Ent:IsValid() and IsValid(MGA2.SelectedPlayer.Ent)) then
                	s:SetDisabled(true)
                	s.BorderColor = MGA2.Colors.Gray
                	s.ExampleOverride = MGA2.SelectedPlayer.Nick
                else
                	s:SetDisabled(false)
                	s.ExampleOverride = nil
                	s.BorderColor = MGA2.Colors.MGA2Blue
                end
            end
            entry.Paint = function(s, w, h)
				surface_SetDrawColor(0, 0, 0, 150)
				surface_DrawRect(0, 0, w, h)

				surface_SetDrawColor(s.BorderColor)
				surface_DrawOutlinedRect(0, 0, w, h)

				if (s.ExampleOverride) then
					draw_SimpleText(s.ExampleOverride, "DermaLargeSmall_", 3, 3, Color(255, 255, 255, s.ExampleColor))
				else
					draw_SimpleText(s.DefaultEntry, "DermaLargeSmall_", 3, 3, Color(255, 255, 255, s.ExampleColor))
				end

				s:DrawTextEntryText(MGA2.Colors.White, Color(30, 130, 255), MGA2.Colors.White)
			end
            entry.MaxChars = 192

            if (cmd[i][2] and cmd[i][2] == "The Lua") then
            	entry.MaxChars = 9999	
            end

            entry.OnTextChanged = function(s)
                local txt = s:GetValue()
                local amt = txt:len()

                if (amt > s.MaxChars or string.sub(tostring(txt), #txt, #txt) == "#") then
                    if (s.OldText == nil) then
                        s:SetText("")
                        s:SetValue("")
                        s:SetCaretPos(string.len(""))
                    else
                        s:SetText(s.OldText)
                        s:SetValue(s.OldText)
                        s:SetCaretPos(string.len(s.OldText))
                    end
                else
                    s.OldText = txt
                end
            end

			table.insert(MGA2.ArgumentList, entry)
		elseif (cmd[i][1] == "Drop") then
			if (cmd[i][2] == "Group") then
				cmd[i][3] = moat.Ranks.Table()
			end

			if (cmd[i][2] == "Choose Map") then
				cmd[i][3] = MGA.Maps or {}
			end

			local combo = pnl:Add("DComboBox")
			combo:SetWide(MGA2.SubConf.w - 10)
			combo:SetValue(cmd[i][4])
			combo.label = cmd[i][2]
			combo.DefaultEntry = cmd[i][4]
			for k, v in ipairs(cmd[i][3]) do
				combo:AddChoice(cmd[i][3][k])
			end

			table.insert(MGA2.ArgumentList, combo)
		end
	end

	if (#cmd == 0) then
		local lbl = pnl:Add("DLabel")
		lbl:SetSize(MGA2.SubConf.w - 10, 20)
		lbl:SetFont("DermaLargeSmall_")
		lbl:SetTextColor(MGA2.Colors.White)
		lbl:SetText("No Arguments Needed")
		lbl:SetContentAlignment(5)
		table.insert(MGA2.ArgumentListLabels, lbl)
	end

	local sub = pnl:Add("DButton")
	sub:SetSize(MGA2.SubConf.w - 10, 24)
	sub:SetText("")
	sub.LerpNum = 0
	sub.Paint = function(s, w, h)
		if (s:IsHovered()) then
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
		else
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
		end

		surface_SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface_DrawRect(0, 0, w, h)

		draw_SimpleTextOutlined(cmdd[1], "DermaLargeSmall_", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
	end
	sub.OnCursorEntered = function(s)
		surface.PlaySound("ui/buttonrollover.wav")
	end
	sub.DoClick = function(s)
		surface.PlaySound("ui/buttonclickrelease.wav")
		local args = {}

		for i = 1, #MGA2.ArgumentList do
			local ar = MGA2.ArgumentList[i]

			if (ar.GetText and #ar:GetText() ~= 0) then
				table.insert(args, {ar:GetText(), ar.label == "SteamID"})
			elseif (ar.GetValue and #ar:GetValue() ~= 0) then
				table.insert(args, {ar:GetValue(), ar.label == "SteamID"})
			elseif (ar.GetSelected) then
				table.insert(args, {ar:GetSelected(), ar.label == "SteamID"})
			elseif (MGA2.ArgumentList[i].DefaultEntry ~= "STEAM_0:0:") then
				table.insert(args, {MGA2.ArgumentList[i].DefaultEntry, ar.label == "SteamID"})
			end
		end

		local targ = MGA2.SelectedPlayer.SteamID

		--This weird fuckery because BOT's are weird and have no SteamID
		if (targ == "None" and args[1] and args[1][2] and cmdd[3] ~= "None") then
			targ = args[1][1]
			table.remove(args, 1)
		elseif (targ == "NULL" and args[1] and args[1][2]) then
			targ = MGA2.SelectedPlayer.Nick
			table.remove(args, 1)
		elseif (targ == "NULL" and ((args[1] and not args[1][2]) or not args[1])) then
			targ = MGA2.SelectedPlayer.Nick
		end

		local acargs = {}

		for i = 1, #args do
			table.insert(acargs, args[i][1])
		end

		if (cmdd[3] ~= "None") then
			RunConsoleCommand("mga", cmdd[1], targ, unpack(acargs))
		else
			RunConsoleCommand("mga", cmdd[1], unpack(acargs))
		end

		MGA2.Frame:SetKeyboardInputEnabled(false)
	end

	table.insert(MGA2.ArgumentListLabels, sub)
end

-- Make command red and caps when selected
MGA2.WarnCommands = {
	["Kick"] = true,
	["Votekick"] = true,
	["Ban"] = true,
	["Slay"] = true,
	["Perma"] = true,
	["SetGroup"] = true,
}

function MGA2.OpenMenu()
	local shouldanimate = GetConVar("moat_mga_animation"):GetInt() == 1

	if (IsValid(MGA2.Frame)) then
		if (shouldanimate) then
			MGA2.Frame:MoveTo(MGA2.FrameConf.x, MGA2.FrameConf.y - 10, 0.2, 0, -1, function(a, p)
				p:MoveTo(MGA2.FrameConf.x, ScrH(), 0.1, 0, -1, function(a, p)
					p:Remove()
				end)
			end)
		else
			MGA2.Frame:Remove()
		end

		return
	end

	local LocalRank = LocalPlayer():GetUserGroup()
	local LocalRankWeight = LocalPlayer():GetGroupWeight()
	local LocalNick = LocalPlayer():Nick()

	MGA2.Frame = vgui.Create("DFrame")
	MGA2.Frame:SetTitle("")

	if (shouldanimate) then
		MGA2.Frame:SetPos(MGA2.FrameConf.x, ScrH())
	else
		MGA2.Frame:SetPos(MGA2.FrameConf.x, MGA2.FrameConf.y)
	end

	MGA2.Frame:SetSize(MGA2.FrameConf.w, MGA2.FrameConf.h)
	MGA2.Frame.Think = function(s) end
	MGA2.Frame:MakePopup()
	MGA2.Frame:SetKeyboardInputEnabled(false)
	MGA2.Frame:ShowCloseButton(false)
	MGA2.Frame.Paint = function(s, w, h)
		surface_SetDrawColor(183, 183, 183)
		surface_DrawLine(0, 25, w, 25)
		surface_DrawLine(0, h - 1, w, h - 1)

		surface_SetFont("DermaLarge")

		local tw = surface_GetTextSize("MGA Command Menu")
		local tw2 = draw_SimpleTextOutlined("M", "DermaLarge", (w/2) - (tw/2), -4, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA2.Colors.Shadow)
		local tw3 = draw_SimpleTextOutlined("G", "DermaLarge", (w/2) - (tw/2) + tw2, -4, MGA2.Colors.MGA2Blue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA2.Colors.Shadow)
		local tw4 = draw_SimpleTextOutlined("A Command Menu", "DermaLarge", (w/2) - (tw/2) + tw2 + tw3, -4, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA2.Colors.Shadow)
	end

	if (shouldanimate) then
		MGA2.Frame:MoveTo(MGA2.FrameConf.x, MGA2.FrameConf.y - 10, 0.2, 0, -1, function(a, p)
			p:MoveTo(MGA2.FrameConf.x, MGA2.FrameConf.y, 0.1, 0, -1, function(a, p)
			end)
		end)
	end

	MGA2.CloseButton = vgui.Create("DButton", MGA2.Frame)
	MGA2.CloseButton:SetPos(MGA2.FrameConf.w - 20, 0)
	MGA2.CloseButton:SetSize(20, 20)
	MGA2.CloseButton:SetText("")
	MGA2.CloseButton.Paint = function(s, w, h)
		draw_SimpleTextOutlined("r", "marlett", w/2, h/2, s:IsHovered() and MGA2.Colors.Red or MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
	end
	MGA2.CloseButton.DoClick = function(s)
		MGA2.Frame:Remove()
	end

	local shoulddisableblur = GetConVar("moat_mga_lowend"):GetInt() == 1

	MGA2.BGPanel = vgui.Create("DPanel", MGA2.Frame)
	MGA2.BGPanel:SetPos(0, 3 + 25)
	MGA2.BGPanel:SetSize(MGA2.FrameConf.w, MGA2.FrameConf.h - 6 - 25)
	MGA2.BGPanel.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 150)
		surface_DrawRect(0, 0, w, h)
		DrawBlur(s, 2, shoulddisableblur)

		draw_SimpleTextOutlined(LocalNick, "DermaLargeSmall_", 52, 8, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)
		draw_SimpleTextOutlined(moat.Ranks.Get(LocalRank, "Name"), "DermaLargeSmall_", 52, 24, moat.Ranks.Get(LocalRank, "Color"), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)

		surface_SetFont("DermaLargeSmall_")

		local cmdup = (MGA2.WarnCommands[MGA2.SelectedCommand] and MGA2.SelectedCommand:upper()) or MGA2.SelectedCommand
		local tw = surface_GetTextSize("Selected Command: " .. cmdup)
		local tw2 = draw_SimpleTextOutlined("Selected Command: ", "DermaLargeSmall_", w - 10 - tw, 8, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)
		draw_SimpleTextOutlined(cmdup, "DermaLargeSmall_", w - 10 - tw + tw2, 8, (MGA2.WarnCommands[MGA2.SelectedCommand] and MGA2.Colors.Red) or MGA2.Colors.MGA2Blue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)

		local plyup = MGA2.SelectedPlayer.Nick
		local tw = surface_GetTextSize("Selected Player: " .. plyup)
		local tw2 = draw_SimpleTextOutlined("Selected Player: ", "DermaLargeSmall_", w - 10 - tw, 24, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)
		draw_SimpleTextOutlined(plyup, "DermaLargeSmall_", w - 10 - tw + tw2, 24,  (MGA2.SelectedPlayer.Nick ~= "None" and MGA2.Colors.Yellow) or MGA2.Colors.MGA2Blue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)

		local plist = 0
		if (MGA2.PlayerList) then
			plist = #MGA2.PlayerList
		end
		draw_SimpleTextOutlined("Player List(" .. plist .. ")", "DermaLargeSmall2_", MGA2.PlyConf.x + (MGA2.PlyConf.w/2), 41, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
	end

	/*---------------------------------------------------------------------------
	Avatar Image
	---------------------------------------------------------------------------*/
	MGA2.SelfAva = vgui.Create("AvatarImage", MGA2.BGPanel)
	MGA2.SelfAva:SetPos(10, 10)
	MGA2.SelfAva:SetSize(32, 32)
	MGA2.SelfAva:SetPlayer(LocalPlayer(), 64)

	/*---------------------------------------------------------------------------
	Command List
	---------------------------------------------------------------------------*/
	MGA2.CmdScroll = vgui.Create("DScrollPanel", MGA2.BGPanel)
	MGA2.CmdScroll:SetSize(MGA2.CmdConf.w, MGA2.CmdConf.h)
	MGA2.CmdScroll:SetPos(MGA2.CmdConf.x, MGA2.CmdConf.y)
	MGA2.CmdScroll.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end
	MGA2.CmdScroll.VBar:SetWide(0)
	MGA2.PaintVBar(MGA2.CmdScroll.VBar)

	MGA2.CmdPanel = vgui.Create("DIconLayout", MGA2.CmdScroll)
	MGA2.CmdPanel:SetSize(MGA2.CmdConf.w, MGA2.CmdConf.h)
	MGA2.CmdPanel:SetPos(0, 0)
	MGA2.CmdPanel:SetSpaceX(0)
	MGA2.CmdPanel:SetSpaceY(0)

	/*---------------------------------------------------------------------------
	Player List
	---------------------------------------------------------------------------*/
	MGA2.PlyScroll = vgui.Create("DScrollPanel", MGA2.BGPanel)
	MGA2.PlyScroll:SetSize(MGA2.PlyConf.w, MGA2.PlyConf.h)
	MGA2.PlyScroll:SetPos(MGA2.PlyConf.x, MGA2.PlyConf.y)
	MGA2.PlyScroll.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end
	MGA2.PlyScroll.VBar:SetWide(0)
	MGA2.PaintVBar(MGA2.PlyScroll.VBar)

	MGA2.PlyPanel = vgui.Create("DIconLayout", MGA2.PlyScroll)
	MGA2.PlyPanel:SetSize(MGA2.PlyConf.w, MGA2.PlyConf.h)
	MGA2.PlyPanel:SetPos(0, 0)
	MGA2.PlyPanel:SetSpaceX(0)
	MGA2.PlyPanel:SetSpaceY(0)

	/*---------------------------------------------------------------------------
	Arguments List + Submit
	---------------------------------------------------------------------------*/
	MGA2.ArgScroll = vgui.Create("DScrollPanel", MGA2.BGPanel)
	MGA2.ArgScroll:SetSize(MGA2.SubConf.w, MGA2.SubConf.h)
	MGA2.ArgScroll:SetPos(MGA2.SubConf.x, MGA2.SubConf.y)
	MGA2.ArgScroll.Paint = function(s, w, h)
		surface_SetDrawColor(0, 0, 0, 200)
		surface_DrawRect(0, 0, w, h)
	end

	MGA2.ArgPanel = vgui.Create("DIconLayout", MGA2.ArgScroll)
	MGA2.ArgPanel:SetSize(MGA2.SubConf.w - 5, MGA2.SubConf.h - 5)
	MGA2.ArgPanel:SetPos(5, 5)
	MGA2.ArgPanel:SetSpaceX(5)
	MGA2.ArgPanel:SetSpaceY(5)


	/*---------------------------------------------------------------------------
	Insert Commands List
	---------------------------------------------------------------------------*/

	MGA2.CLP = {}
	MGA2.SelectedCommand = "None"
	MGA2.SelectedPlayer = {
		Ent = nil,
		Nick = "None",
		SteamID = "None"
	}

	for i = 1, #MGA.CommandList do
		if (LocalRankWeight >= MGA.CommandList[i][1]) then
			MGA2.InsertCommandList(i, MGA2.CmdPanel)
		end
	end

	/*---------------------------------------------------------------------------
	Insert Players List
	---------------------------------------------------------------------------*/
	MGA2.RebuildPlayerList(MGA2.PlyPanel)

	if (MGA.Maps == nil) then
		MGA.Maps = {}

		net.Start "MGA.SendMaps"
		net.SendToServer()
	end
end

mga = mga or {
	cfg = {}
}


mga.WarnCommands, mga.MapList = {
	["Kick"] = true,
	["Votekick"] = true,
	["Ban"] = true,
	["Slay"] = true,
	["Perma"] = true,
	["SetGroup"] = true,
	["Wipe"] = true
}, mga.MapList or {}

mga.Colors = {
	Shadow = Color(0, 0, 0, 35),
	White = Color(255, 255, 255, 255),
	MGABlue = Color(30, 130, 255, 255),
	Red = Color(255, 0, 0, 255),
	Yellow = Color(255, 255, 0, 255),
	Gray = Color(183, 183, 183, 255)
}

mga.CLP, mga.StoredArguments = {}, {}
mga.SelectedCommand, mga.SelectedPlayer = "None", {
	Ent = nil,
	Nick = "None",
	SteamID = "None"
}

-- old res used to be for ui
-- w = 1768, h = 992
-- diff now
-- w = 3840, h = 2160

if (not _ScrW) then _ScrW = ScrW end
if (not _ScrH) then _ScrH = ScrH end
ScrW = function() return _ScrW() end
ScrH = function() return _ScrH() end
--ScrW = function() return 1920 end
--ScrH = function() return 1080 end
--ScrW = function() return 1768 end
--ScrH = function() return 992 end
--ScrW = function() return 800 end
--ScrH = function() return 600 end


ScaleW, ScaleH, ScaleF, ScaleP = function(x)
	local n = x * 1.0

	n = math.Round(ScrW() * (n/1768))
	n = x % 2 == 0 and (n % 2 == 0 and n or n - 1) or (n % 2 ~= 0 and n or n - 1)

	return n
end, function(x, thicc)
	local n = x * 1.0

	n = math.Round(ScrH() * (n/992))
	n = x % 2 == 0 and (n % 2 == 0 and n or n - 1) or (n % 2 ~= 0 and n or n - 1)

	return n
end, function(x)
	local n = x * 1.0

	n = math.Round(ScrH() * (n/992))
	n = x % 2 == 0 and (n % 2 == 0 and n or n - 1) or (n % 2 ~= 0 and n or n - 1)

	return "ux" .. (thicc or "") .. "." .. n
end, function(x, prev, cur)
	local n = x * 1.0

	n = math.Round(cur * (x/prev))
	n = x % 2 == 0 and (n % 2 == 0 and n or n - 1) or (n % 2 ~= 0 and n or n - 1)

	return n
end

ScaleX, ScaleY = ScaleW, ScaleH

function mga.Reload()
	local scrw, scrh, t = ScrW(), ScrH(), {}

	-- Main MG Palette
	t.p = ux.p.mg

	-- Main Panel
	t.pnl = {
		w = 601, -- 768
		h = 500  -- 608
	}

	t.cmd = {
		w = 187,
		h = 407,
		x = 10,
		y = 52,
		btn = ScaleH(16)
	}

	t.ply = {
		w = 197,
		h = 407,
		x = 202,
		y = 52,
		btn = ScaleH(20)
	}

	t.sub = {
		w = 187,
		h = 407,
		x = 404,
		y = 52,
		btn = ScaleH(16)
	}

	for k, v in pairs(t) do
		if (v.w) then v.w = ScaleW(v.w) end
		if (v.h) then v.h = ScaleH(v.h) end
		if (v.x) then v.x = ScaleW(v.x) end
		if (v.y) then v.y = ScaleH(v.y) end
	end

	mga.cfg = t
	return mga.cfg
end
hook("moat", mga.Reload)

mga.Main = mga.Main or {}
function mga.Main.Close()
	if (not IsValid(mga.bg)) then
		return
	end

	mga.bg:BounceOut(BOTTOM)
end

function mga.Main.Open()
	if (IsValid(mga.bg)) then
		mga.bg:Remove()
	end

	local LocalRank = LocalPlayer():GetUserGroup()
	local LocalRankWeight = LocalPlayer():GetGroupWeight()
	local LocalNick = LocalPlayer():Nick()

	mga.bg = ux.Create("DFrame", function(s)
		s:Setup(ux.CenterX(mga.cfg.pnl.w), -mga.cfg.pnl.h, mga.cfg.pnl.w, mga.cfg.pnl.h)
		s:BounceIn()

		s:MakePopup()
		s:SetKeyboardInputEnabled(false)
		s:ShowCloseButton(false)
	end, {Paint = function(s, w, h)
		/*
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)

		draw.WebImage("https://static.moat.gg/f/ZbiTBZ.png", 0, 0, 2048, 2048, Color(255, 255, 255, 250))
		*/
		surface.SetDrawColor(183, 183, 183)
		surface.DrawLine(0, ScaleY(25), w, ScaleY(25))
		surface.DrawLine(0, h - 1, w, h - 1)

		surface.SetFont(ScaleF(30))

		local tw = surface.GetTextSize("MGA Command Menu")
		local tw2 = draw.SimpleTextOutlined("M", ScaleF(30), (w/2) - (tw/2), ScaleY(-4), mga.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, mga.Colors.Shadow)
		local tw3 = draw.SimpleTextOutlined("G", ScaleF(30), (w/2) - (tw/2) + tw2, ScaleY(-4), mga.Colors.MGABlue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, mga.Colors.Shadow)
		local tw4 = draw.SimpleTextOutlined("A Command Menu", ScaleF(30), (w/2) - (tw/2) + tw2 + tw3, ScaleY(-4), mga.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, mga.Colors.Shadow)
	end, Think = function(s) end})

	mga.CloseButton = vgui.Create("DButton", mga.bg)
	mga.CloseButton:SetPos(mga.cfg.pnl.w - 20, 0)
	mga.CloseButton:SetSize(20, 20)
	mga.CloseButton:SetText("")
	mga.CloseButton.Paint = function(s, w, h)
		draw.SimpleTextOutlined("r", "marlett", w/2, h/2, s:IsHovered() and mga.Colors.Red or mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
	end
	mga.CloseButton.DoClick = function(s)
		mga.bg:Remove()
	end

	mga.BGPanel = vgui.Create("DPanel", mga.bg)
	mga.BGPanel:SetPos(0, ScaleY(3 + 25))
	mga.BGPanel:SetSize(mga.cfg.pnl.w, mga.cfg.pnl.h - ScaleY(6 - 25))
	mga.BGPanel.Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 150)
		surface.DrawRect(0, 0, w, h)
		ux.Blur(s, 4)

		draw.SimpleTextOutlined(LocalNick, ScaleF(18), ScaleX(52), ScaleY(8), mga.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, mga.Colors.Shadow)
		draw.SimpleTextOutlined(moat.Ranks.Get(LocalRank, "Name"), ScaleF(18), ScaleX(52), ScaleY(24), moat.Ranks.Get(LocalRank, "Color"), TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, mga.Colors.Shadow)

		surface.SetFont(ScaleF(18))

		local cmdup = (mga.WarnCommands[mga.SelectedCommand] and mga.SelectedCommand:upper()) or mga.SelectedCommand
		local tw = surface.GetTextSize("Selected Command: " .. cmdup)
		local tw2 = draw.SimpleTextOutlined("Selected Command: ", ScaleF(18), w - ScaleX(10) - tw, ScaleY(8), mga.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, mga.Colors.Shadow)
		draw.SimpleTextOutlined(cmdup, ScaleF(18), w - ScaleX(10) - tw + tw2, ScaleY(8), (mga.WarnCommands[mga.SelectedCommand] and mga.Colors.Red) or mga.Colors.MGABlue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, mga.Colors.Shadow)

		local plyup = mga.SelectedPlayer.Nick
		local tw = surface.GetTextSize("Selected Player: " .. plyup)
		local tw2 = draw.SimpleTextOutlined("Selected Player: ", ScaleF(18), w - ScaleX(10) - tw, ScaleY(24), mga.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, mga.Colors.Shadow)
		draw.SimpleTextOutlined(plyup, ScaleF(18), w - ScaleX(10) - tw + tw2, ScaleY(24), (mga.SelectedPlayer.Nick ~= "None" and mga.Colors.Yellow) or mga.Colors.MGABlue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, mga.Colors.Shadow)

		local plist = 0
		if (mga.PlayerList) then
			plist = #mga.PlayerList
		end
		draw.SimpleTextOutlined("Player List(" .. plist .. ")", ScaleF(16), mga.cfg.ply.x + (mga.cfg.ply.w/2), ScaleY(41), mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
	end

	/*---------------------------------------------------------------------------
	Avatar Image
	---------------------------------------------------------------------------*/
	mga.SelfAva = vgui.Create("AvatarImage", mga.BGPanel)
	mga.SelfAva:SetPos(ScaleX(10), ScaleY(10))
	mga.SelfAva:SetSize(ScaleW(32), ScaleW(32))
	mga.SelfAva:SetPlayer(LocalPlayer(), 128)

	/*---------------------------------------------------------------------------
	Command List
	---------------------------------------------------------------------------*/
	mga.CmdScroll = ux.Create("DScrollPanel", mga.BGPanel, function(s)
		s:Setup(mga.cfg.cmd.x, mga.cfg.cmd.y, mga.cfg.cmd.w, mga.cfg.cmd.h)
		s.VBar:SetWide(0)
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, w, h)
	end})

	mga.CmdPanel = ux.Create("DIconLayout", mga.CmdScroll, function(s)
		s:Setup(0, 0, mga.cfg.cmd.w, mga.cfg.cmd.h)
		s:SetSpaceX(0)
		s:SetSpaceY(0)
	end)

	/*---------------------------------------------------------------------------
	Player List
	---------------------------------------------------------------------------*/
	mga.PlyScroll = ux.Create("DScrollPanel", mga.BGPanel, function(s)
		s:Setup(mga.cfg.ply.x, mga.cfg.ply.y, mga.cfg.ply.w, mga.cfg.ply.h)
		s.VBar:SetWide(0)
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, w, h)
	end})

	mga.PlyPanel = ux.Create("DIconLayout", mga.PlyScroll, function(s)
		s:Setup(0, 0, mga.cfg.ply.w, mga.cfg.ply.h)
		s:SetSpaceX(0)
		s:SetSpaceY(0)
	end)

	/*---------------------------------------------------------------------------
	Arguments List + Submit
	---------------------------------------------------------------------------*/

	mga.ArgScroll = ux.Create("DScrollPanel", mga.BGPanel, function(s)
		s:Setup(mga.cfg.sub.x, mga.cfg.sub.y, mga.cfg.sub.w, mga.cfg.sub.h)
		s.VBar:SetWide(0)
	end, {Paint = function(s, w, h)
		surface.SetDrawColor(0, 0, 0, 200)
		surface.DrawRect(0, 0, w, h)
	end})

	mga.ArgPanel = ux.Create("DIconLayout", mga.ArgScroll, function(s)
		s:Setup(ScaleX(5), ScaleY(5), mga.cfg.sub.w, mga.cfg.sub.h - ScaleY(5))
		s:SetSpaceX(ScaleX(5))
		s:SetSpaceY(ScaleY(5))
	end)

	/*---------------------------------------------------------------------------
	Insert Commands List
	---------------------------------------------------------------------------*/

	mga.CLP = {}
	mga.SelectedCommand = "None"
	mga.SelectedPlayer = {
		Ent = nil,
		Nick = "None",
		SteamID = "None"
	}

	for i = 1, #MGA.CommandList do
		if (LocalRankWeight >= MGA.CommandList[i][1]) then
			mga.InsertCommandList(i, mga.CmdPanel)
		end
	end

	/*---------------------------------------------------------------------------
	Insert Players List
	---------------------------------------------------------------------------*/
	mga.RebuildPlayerList(mga.PlyPanel)
end

function mga.InsertCommandList(index, pnl)
	local cmdtitle = MGA.CommandList[index][2]
	local listcolor = MGA.CommandList[index][3]
	local cmdlist = MGA.CommandList[index][4]

	mga.CLP[index] = {}

	local mgal = mga.CLP[index]

	mgal.ListBtn = pnl:Add("DButton")
	mgal.ListBtn:SetSize(mga.cfg.cmd.w, mga.cfg.cmd.btn)
	mgal.ListBtn:SetText("")
	mgal.ListBtn.Paint = function(s, w, h)
		surface.SetDrawColor(listcolor)
		surface.DrawRect(0, 0, w, h)

		draw.SimpleTextOutlined(cmdtitle, ScaleF(18), w/2, h/2, mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
	end
	mgal.ListBtn.AnimationActive = false
	mgal.ListBtn.Closed = false
	mgal.ListBtn.WasClosed = false
	mgal.ListBtn.Think = function(s)
		if (s.WasClosed ~= s.Closed) then
			s.AnimationActive = true
		end

		if (s.AnimationActive) then
			pnl:Layout()
			local lp = mgal.ListPnl

			if (s.Closed) then
				lp.CurrentHeight = Lerp(FrameTime() * 15, lp.CurrentHeight, 0)

				if (lp.CurrentHeight <= 0.5) then
					lp.CurrentHeight = 0
					s.AnimationActive = false
				end
			else
				lp.CurrentHeight = Lerp(FrameTime() * 15, lp.CurrentHeight, lp.FullHeight)

				if (lp.CurrentHeight >= lp.FullHeight - 0.5) then
					lp.CurrentHeight = lp.FullHeight
					s.AnimationActive = false
				end
			end

			lp:SetTall(lp.CurrentHeight)
		end

		s.WasClosed = s.Closed
	end
	mgal.ListBtn.DoClick = function(s)
		if (s.AnimationActive) then return end
		s.Closed = not s.Closed
	end

	mgal.ListPnl = pnl:Add("DPanel")
	mgal.ListPnl:SetSize(mga.cfg.cmd.w, #cmdlist * mga.cfg.cmd.btn)
	mgal.ListPnl:SetText("")
	mgal.ListPnl.CurrentHeight = #cmdlist * mga.cfg.cmd.btn
	mgal.ListPnl.FullHeight = #cmdlist * mga.cfg.cmd.btn
	mgal.ListPnl.Paint = function(s, w, h)
		surface.SetDrawColor(listcolor.r, listcolor.g, listcolor.b, 20)
		surface.DrawRect(0, 0, w, h)
	end

	for i = 1, #cmdlist do
		local btn = vgui.Create("DButton", mgal.ListPnl)
		btn:SetSize(mga.cfg.cmd.w, mga.cfg.cmd.btn)
		btn:SetPos(0, (i - 1) * mga.cfg.cmd.btn)
		btn:SetText("")
		btn:SetTooltip(cmdlist[i][2])
		btn.Cmd = cmdlist[i][1]
		btn.LerpNum = 0

		if (i % 2 == 0) then
			btn.SweetLine = true
		end

		btn.Paint = function(s, w, h)
			if (s:IsHovered() or mga.SelectedCommand == s.Cmd) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface.SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, ((btn.SweetLine and 125) or 50) + (50 * s.LerpNum))
			surface.DrawRect(0, 0, w, h)

			draw.SimpleTextOutlined(s.Cmd, ScaleF(16), w/2, h/2, mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")
			if cmdlist[i][1] == "Votekick" then
				Derma_Message("Make sure to CALL FOR STAFF IN DISCORD FIRST.\nAbuse of votekick will result in a ban from the servers.","Warning", "Ok")
			end
			mga.HandleCommandPressed(cmdlist[i])
		end
	end
end

function mga.RebuildPlayerList(pnl, ignore)
	if (not pnl) then
		if (not mga or (mga and not mga.PlyPanel)) then
			return
		end

		pnl = mga.PlyPanel
	end

	if (mga.PlayerList) then
		for i = 1, #mga.PlayerList do
			mga.PlayerList[i]:Remove()
		end
	end

	mga.PlayerList = {}
	mga.StoredArguments = {}

	if (isstring(ignore)) then
		local btn = pnl:Add("DPanel")
		btn:SetSize(mga.cfg.ply.w, mga.cfg.ply.btn)
		if (ignore == "SteamID") then
			btn.Paint = function(s, w, h)
				draw.SimpleTextOutlined("Use SteamID", ScaleF(16), w/2, h/2, mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
			end
		else
			btn.Paint = function(s, w, h)
				draw.SimpleTextOutlined("No Player Needed", ScaleF(16), w/2, h/2, mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
			end
		end

		mga.SelectedPlayer = {
			Ent = nil,
			Nick = "None",
			SteamID = "None"
		}

		table.insert(mga.PlayerList, btn)
		return
	end

	local minimilist = GetConVar("moat_mga_playerlist"):GetInt() == 1
	local SortedPlayers = table.Copy(player.GetAll())

	table.sort(SortedPlayers, function(a, b) return a:GetNW2Int("MOAT_STATS_LVL", 1) < b:GetNW2Int("MOAT_STATS_LVL", 1) end)

	for k, v in ipairs(SortedPlayers) do
		if (ignore and v:GetGroupWeight() > LocalPlayer():GetGroupWeight()) then
			continue
		end

		local btn = pnl:Add("DButton")
		btn:SetSize(mga.cfg.ply.w, ScaleH(24))

		if (minimilist) then
			btn:SetSize(mga.cfg.ply.w, ScaleH(16))
		end

		btn:SetText("")
		btn.LerpNum = 0

		btn.PlayerInfo = {
			Nick = v:Nick(),
			SteamID = v:SteamID(),
			Rank = v:GetUserGroup(),
			Ent = v
		}

		if (k % 2 == 0) then
			btn.SweetLine = true
		end

		btn.ts = {w = 0, h = 0}
		btn.bs = {w = 0, h = 0}
		btn.Spacing = ScaleP(2, 24, ScaleH(24))
		btn.Paint = function(s, w, h)
			if (s:IsHovered() or (mga.SelectedPlayer.Ent and mga.SelectedPlayer.Ent:IsValid() and IsValid(mga.SelectedPlayer.Ent) and mga.SelectedPlayer.Ent == s.PlayerInfo.Ent)) then
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
			else
				s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
			end

			surface.SetDrawColor(50 + (1 * s.LerpNum), 50 + (103 * s.LerpNum), 50 + (205 * s.LerpNum), ((btn.SweetLine and 100 * s.LerpNum) or 100) + (50 * s.LerpNum))
			surface.DrawRect(0, 0, w, h)

			s.ts.w, s.ts.h = draw.SimpleText(btn.PlayerInfo.Nick, ScaleF(16), (h - (s.Spacing * 2)) + (s.Spacing * 2), (h/2) - (s.bs.h/2) + s.Spacing, Color(255, 255, 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
			s.bs.w, s.bs.h = draw.SimpleText(btn.PlayerInfo.Rank, ScaleF(12), (h - (s.Spacing * 2)) + (s.Spacing * 2), (h/2) + (s.ts.h/2) - s.Spacing, Color(150, 150, 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")

			mga.HandlePlayerPressed(v)
		end

		local ava = vgui.Create("AvatarImage", btn)
		ava:SetSize(ScaleH(24) - (btn.Spacing * 2), ScaleH(24) - (btn.Spacing * 2))
		ava:SetPos(btn.Spacing, btn.Spacing)
		if (minimilist) then
			ava:SetSize(ScaleW(15), ScaleW(15))
			ava:SetPos(0, 0)
		end
		ava:SetPlayer(v, 64)
		ava.OnMousePressed = function(s)
			btn.DoClick()
		end

		table.insert(mga.PlayerList, btn)
	end
end

function mga.RebuildCommandArguments(pnl, cmdd)
	if (not pnl) then
		if (not mga or (mga and not mga.ArgPanel)) then
			return
		end

		pnl = mga.ArgPanel
	end

	local cmd = {}

	if (cmdd and cmdd[4]) then
		cmd = cmdd[4]
	end

	if (mga.ArgumentList) then
		for i = 1, #mga.ArgumentList do
			mga.ArgumentList[i]:Remove()
		end
	end

	if (mga.ArgumentListLabels) then
		for i = 1, #mga.ArgumentListLabels do
			mga.ArgumentListLabels[i]:Remove()
		end
	end

	mga.ArgumentListLabels = {}
	mga.ArgumentList = {}
	mga.StoredArguments = {}

	if (mga.SelectedCommand == "None") then return end

	for i = 1, #cmd do
		local lbl = pnl:Add("DLabel")
		lbl:SetSize(mga.cfg.sub.w - ScaleW(10), ScaleH(16))
		lbl:SetFont(ScaleF(16))
		lbl:SetTextColor(mga.Colors.White)
		lbl:SetText(cmd[i][2] .. ":")
		table.insert(mga.ArgumentListLabels, lbl)

		if (cmd[i][1] == "Entry") then
			local bg = pnl:Add "DPanel"
			bg:SetSize(mga.cfg.sub.w - ScaleW(10), ScaleH(22))
			bg.ExampleColor = 50
			bg.DefaultEntry = cmd[i][3]
			bg.BorderColor = mga.Colors.MGABlue
			bg.Paint = function(s, w, h)
				surface.SetDrawColor(0, 0, 0, 150)
				surface.DrawRect(0, 0, w, h)

				surface.SetDrawColor(s.BorderColor)
				surface.DrawOutlinedRect(0, 0, w, h)

				if (s.ExampleOverride) then
					draw.SimpleText(s.ExampleOverride, ScaleF(16), ScaleX(3), ScaleY(2), Color(255, 255, 255, s.ExampleColor))
				else
					draw.SimpleText(s.DefaultEntry, ScaleF(16), ScaleX(3), ScaleY(2), Color(255, 255, 255, s.ExampleColor))
				end
			end

			local entry = vgui.Create("DTextEntry", bg)
			entry:SetSize(mga.cfg.sub.w - ScaleW(10), ScaleH(22))
			entry:SetPos(ScaleX(2), ScaleY(-1))
			entry:SetText("")
			entry.label = cmd[i][2]
			entry.OnGetFocus = function(s)
				mga.bg:SetKeyboardInputEnabled(true)
			end
			entry.OnLoseFocus = function(s)
				mga.bg:SetKeyboardInputEnabled(false)
			end
			entry:SetFont(ScaleF(16))
			entry:SetTextColor(Color(255, 255, 255))
			entry:SetCursorColor(Color(255, 255, 255))
			entry:SetEnterAllowed(true)
			entry:SetTabbingDisabled(true)
			entry:SetDrawBackground(false)
			entry:SetMultiline(false)
			entry.Think = function(s)
				if (s:GetValue() == "") then
					bg.ExampleColor = 50
				else
					bg.ExampleColor = 0
				end

				if (entry.label == "SteamID" and mga.SelectedPlayer.Ent and IsValid(mga.SelectedPlayer.Ent)) then
					s:SetDisabled(true)
					bg.BorderColor = mga.Colors.Gray
					bg.ExampleOverride = mga.SelectedPlayer.Nick
				else
					s:SetDisabled(false)
					bg.ExampleOverride = nil
					bg.BorderColor = mga.Colors.MGABlue
				end
			end
			entry.Paint = function(s, w, h)
				s:DrawTextEntryText(mga.Colors.White, Color(30, 130, 255), mga.Colors.White)
			end
			entry.MaxChars = 192

			if (cmd[i][2] and cmd[i][2] == "The Lua") then
				entry.MaxChars = 9999
			end

			entry.OnTextChanged = function(s)
				local txt = s:GetValue()
				local amt = txt:len()

				if (amt > s.MaxChars or string.sub(tostring(txt), #txt, #txt) == "#") then
					if (s.OldText == nil) then
						s:SetText("")
						s:SetValue("")
						s:SetCaretPos(string.len(""))
					else
						s:SetText(s.OldText)
						s:SetValue(s.OldText)
						s:SetCaretPos(string.len(s.OldText))
					end
				else
					s.OldText = txt
				end
			end

			table.insert(mga.ArgumentList, entry)
		elseif (cmd[i][1] == "Drop") then
			if (cmd[i][2] == "Group") then
				cmd[i][3] = moat.Ranks.Table()
			end

			if (cmd[i][2] == "Choose Map") then
				cmd[i][3] = MGA.Maps or {}
			end

			local combo = pnl:Add("DComboBox")
			combo:SetSize(mga.cfg.sub.w - ScaleW(10), ScaleH(22))
			combo:SetValue(cmd[i][4])
			combo.label = cmd[i][2]
			combo.DefaultEntry = cmd[i][4]
			for k, v in ipairs(cmd[i][3]) do
				combo:AddChoice(cmd[i][3][k])
			end

			table.insert(mga.ArgumentList, combo)
		end
	end

	if (#cmd == 0) then
		local lbl = pnl:Add("DLabel")
		lbl:SetSize(mga.cfg.sub.w - ScaleW(10), ScaleH(16))
		lbl:SetFont(ScaleF(16))
		lbl:SetTextColor(mga.Colors.White)
		lbl:SetText("No Arguments Needed")
		lbl:SetContentAlignment(5)
		table.insert(mga.ArgumentListLabels, lbl)
	end

	local sub = pnl:Add("DButton")
	sub:SetSize(mga.cfg.sub.w - ScaleW(10), ScaleH(24))
	sub:SetText("")
	sub.LerpNum = 0
	sub.Paint = function(s, w, h)
		if (s:IsHovered()) then
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 1)
		else
			s.LerpNum = Lerp(FrameTime() * 8, s.LerpNum, 0)
		end

		surface.SetDrawColor(51 * s.LerpNum, 153 * s.LerpNum, 255 * s.LerpNum, 150 + (50 * s.LerpNum))
		surface.DrawRect(0, 0, w, h)

		draw.SimpleTextOutlined(cmdd[1], ScaleF(18), w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
	end
	sub.OnCursorEntered = function(s)
		surface.PlaySound("ui/buttonrollover.wav")
	end
	sub.DoClick = function(s)
		surface.PlaySound("ui/buttonclickrelease.wav")
		local args = {}

		for i = 1, #mga.ArgumentList do
			local ar = mga.ArgumentList[i]

			if (ar.GetText and #ar:GetText() ~= 0) then
				table.insert(args, {ar:GetText(), ar.label == "SteamID"})
			elseif (ar.GetValue and #ar:GetValue() ~= 0) then
				table.insert(args, {ar:GetValue(), ar.label == "SteamID"})
			elseif (ar.GetSelected) then
				table.insert(args, {ar:GetSelected(), ar.label == "SteamID"})
			elseif (mga.ArgumentList[i].DefaultEntry ~= "STEAM_0:0:") then
				table.insert(args, {mga.ArgumentList[i].DefaultEntry, ar.label == "SteamID"})
			end
		end

		local targ = mga.SelectedPlayer.SteamID

		--This weird fuckery because BOT's are weird and have no SteamID
		if (targ == "None" and args[1] and args[1][2] and cmdd[3] ~= "None") then
			targ = args[1][1]
			table.remove(args, 1)
		elseif (targ == "NULL" and args[1] and args[1][2]) then
			targ = mga.SelectedPlayer.Nick
			table.remove(args, 1)
		elseif (targ == "NULL" and ((args[1] and not args[1][2]) or not args[1])) then
			targ = mga.SelectedPlayer.Nick
		end

		local acargs = {}

		for i = 1, #args do
			table.insert(acargs, args[i][1])
		end

		if (cmdd[3] ~= "None") then
			RunConsoleCommand("mga", cmdd[1], targ, unpack(acargs))
		else
			RunConsoleCommand("mga", cmdd[1], unpack(acargs))
		end

		mga.bg:SetKeyboardInputEnabled(false)
	end

	table.insert(mga.ArgumentListLabels, sub)
end

function mga.HandleCommandPressed(cmd)
	if (mga.SelectedCommand == cmd[1]) then
		mga.SelectedCommand = "None"
		mga.RebuildPlayerList()
		mga.RebuildCommandArguments()
	else
		mga.SelectedCommand = cmd[1]
		mga.RebuildPlayerList(nil, cmd[3])
		mga.RebuildCommandArguments(nil, cmd or {})
	end
end

function mga.HandlePlayerPressed(pl)
	if (not IsValid(pl) or (IsValid(mga.SelectedPlayer.Ent) and mga.SelectedPlayer.Ent == pl)) then
		mga.SelectedPlayer = {
			Ent = nil,
			Nick = "None",
			SteamID = "None"
		}
	else
		mga.SelectedPlayer = {
			Ent = pl,
			Nick = pl:Nick(),
			SteamID = pl:SteamID()
		}
	end
end


mga.Cooldown = 0
mga.CooldownTime = 0.3

function mga.Open()
	if (MGA.Maps == nil) then
		MGA.Maps = {}

		net.Start "MGA.SendMaps"
		net.SendToServer()
	end

	mga.Main.Open()
	mga.Cooldown = CurTime() + 0.3
end

function mga.Close()
	mga.Main.Close()
	mga.Cooldown = CurTime() + 0.3
end

function mga.Toggle()		
	if (not mga.Main or mga.Cooldown > CurTime()) then
		return
	end

	mga.Reload()

	if (IsValid(mga.bg)) then
		mga.Close()
	else
		mga.Open()
	end
end

concommand.Add("mga_menu3", mga.Toggle)

net.Receive("MGA.SendMaps", function()
	MGA.Maps = MGA.Maps or {}

	for i = 1, net.ReadUInt(16) do
		MGA.Maps[i] = net.ReadString()
	end

	if (MGA.CommandList) then
		MGA.CommandList[1][4][2][4][1][3] = MGA.Maps
		MGA.CommandList[2][4][1][4][1][3] = MGA.Maps
	end
end)

local menu_cooldown = 0
hook("PlayerButtonDown", function(p, k)
	if (k == KEY_M and menu_cooldown < CurTime()) then
		menu_cooldown = CurTime() + 1

		if (IsValid(MGA.Frame)) then
			MGA.OpenMenu()

			return
		end

		if ((ScrW() >= 1200) or IsValid(MGA2.Frame)) then
			MGA2.OpenMenu()
		else
			MGA.OpenMenu()
		end
    end
end)

concommand.Add("mga_menu", function()
	if (menu_cooldown < CurTime()) then
		MGA.OpenMenu()
	end
end)

concommand.Add("mga_menu2", function()
	if (menu_cooldown < CurTime()) then
		MGA2.OpenMenu()
	end
end)