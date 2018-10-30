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

MGA.MapList = {}

--{Rank Weight Required, Rank Name, Rank Color in Menu, Commands}
--Commands: {Command Name, Description, Ignore Higher Players, Arguments}
MGA.CommandList = {
	{0, "User", Color(125, 125, 125, 255), {
		{"Playtime", "Prints a player's playtime to your chat.", false},
		{"PM", "Sends a private message to a player.", false, {
			{"Entry", "Message", "Say Something..."}
		}},
		{"MOTD", "Opens the MOTD.", "None"},
		{"Block", "Blocks a player in game.", false},
		{"UnBlock", "Unblocks a player in game.", false},
	}},
	{5, "VIP & Credible Club", Color(255, 128, 0, 255), {
		{"Votekick", "Creates a vote that bans for 30 minutes if successful.", true, {
			{"Drop", "Choose Reason", {"Mic Spamming","Purposeful Mass RDM","Attempted Mass RDM","Chat Spamming","Hateful Conduct"}, "Reason required..."}
		}},
		{"Boost", "Boosts a map for the next map vote.", "None", {
			{"Drop", "Choose Map", {"Loading Maps...", "Loading Maps...", "Loading Maps..."}, "No Map Choosen"}
		}}
	}},
	{15, "Trial Staff", Color(41, 194, 245, 255), {
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
		{"PA", "Announces a message to the entire server.", "None", {
			{"Entry", "Message", "Testing..."}
		}},
		{"ForceMOTD", "Forces a player to open the MOTD.", true},
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
	}},
	{20, "Moderator", Color(0, 102, 0, 255),  {
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
	{25, "Administrator", Color(102, 0, 204, 255), {
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
	{30, "Senior Administrator", Color(102, 0, 102, 255),  {
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
	{35, "Head Administrator", Color(51, 0, 51, 255), {
		{"SetGroup", "Sets the group of a player.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"},
			{"Drop", "Group", {"user", "vip", "credibleclub", "trialstaff", "moderator", "admin", "senioradmin", "headadmin"}, "user"}
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

MGA.PrettyRank = {
	["communitylead"] = {"Community Leader", Color(255, 0, 0)},
	["headadmin"] = {"Head Administrator", Color(51, 0, 51)},
	["senioradmin"] = {"Senior Administrator", Color(102, 0, 102)},
	["admin"] = {"Administrator", Color(102, 0, 204)},
	["moderator"] = {"Moderator", Color(0, 102, 0)},
	["trialstaff"] = {"Trial Staff", Color(51, 204, 255)},
	["credibleclub"] = {"Credible Club", Color(255, 51, 255)},
	["vip"] = {"VIP", Color(0, 255, 0)},
	["user"] = {"User", Color(255, 255, 255)}
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

	table.sort(SortedPlayers, function(a, b) return a:GetNWInt("MOAT_STATS_LVL", 1) < b:GetNWInt("MOAT_STATS_LVL", 1) end)

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
		draw_SimpleTextOutlined(MGA.PrettyRank[LocalRank][1], "DermaLargeSmall", 52, 24, MGA.PrettyRank[LocalRank][2], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA.Colors.Shadow)

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
end

net.Receive("MGA.SendMaps", function()
	MGA.Maps = {}

	for i = 1, net.ReadUInt(16) do
		MGA.Maps[i] = net.ReadString()
	end

	MGA.CommandList[2][4][2][4][1][3] = MGA.Maps
end)

concommand.Add("mga_menu", function()
	MGA.OpenMenu()

	if (MGA.Maps == nil) then
		net.Start("MGA.SendMaps")
		net.SendToServer()
	end
end)