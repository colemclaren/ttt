D3A.Menu = {}
-- haha no d3a menu d3a got no menu beast u fgt

if (MGA2 and IsValid(MGA2.Frame)) then
	MGA2.Frame:Remove()
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
	size = 18,
	weight = 800
})

surface.CreateFont("DermaLargeSmall2", {
	font = "DermaLarge",
	size = 16,
	weight = 800
})

surface.CreateFont("DermaLargeSmall3", {
	font = "DermaLarge",
	size = 12,
	weight = 700
})

MGA2.MapList = {}

--{Rank Weight Required, Rank Name, Rank Color in Menu, Commands}
--Commands: {Command Name, Description, Ignore Higher Players, Arguments}

MGA2.CommandList = {
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
		{"Votekick", "Creates a vote that bans for 30 minutes if successful.", true},
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

MGA2.PrettyRank = {
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
	local cmdtitle = MGA2.CommandList[index][2]
	local listcolor = MGA2.CommandList[index][3]
	local cmdlist = MGA2.CommandList[index][4]

	MGA2.CLP[index] = {}

	local MGA2L = MGA2.CLP[index]

	MGA2L.ListBtn = pnl:Add("DButton")
	MGA2L.ListBtn:SetSize(MGA2.CmdConf.w, 24)
	MGA2L.ListBtn:SetText("")
	MGA2L.ListBtn.Paint = function(s, w, h)
		surface_SetDrawColor(listcolor)
		surface_DrawRect(0, 0, w, h)

		draw_SimpleTextOutlined(cmdtitle, "DermaLargeSmall", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
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

			draw_SimpleTextOutlined(s.Cmd, "DermaLargeSmall", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
		end
		btn.OnCursorEntered = function(s)
			surface.PlaySound("ui/buttonrollover.wav")
		end
		btn.DoClick = function(s)
			surface.PlaySound("ui/buttonclickrelease.wav")

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
				draw_SimpleTextOutlined("Use SteamID", "DermaLargeSmall2", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
			end
		else
			btn.Paint = function(s, w, h)
				draw_SimpleTextOutlined("No Player Needed", "DermaLargeSmall2", w/2, h/2, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
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

	table.sort(SortedPlayers, function(a, b) return a:GetNWInt("MOAT_STATS_LVL", 1) < b:GetNWInt("MOAT_STATS_LVL", 1) end)

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
		lbl1:SetFont("DermaLargeSmall")
		lbl1:SetText(btn.PlayerInfo.Nick)

		local lbl2 = vgui.Create("DLabel", btn)
		lbl2:SetSize(MGA2.PlyConf.w - 26, 20)
		lbl2:SetPos(30, 10)
		lbl2:SetTextColor(Color(150, 150, 150))
		lbl2:SetFont("DermaLargeSmall2")
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
		lbl:SetFont("DermaLargeSmall")
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
            entry:SetFont("DermaLargeSmall")
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
					draw_SimpleText(s.ExampleOverride, "DermaLargeSmall", 3, 3, Color(255, 255, 255, s.ExampleColor))
				else
					draw_SimpleText(s.DefaultEntry, "DermaLargeSmall", 3, 3, Color(255, 255, 255, s.ExampleColor))
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
		lbl:SetFont("DermaLargeSmall")
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

		draw_SimpleTextOutlined(cmdd[1], "DermaLargeSmall", w/2, h/2, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 2, Color(0, 0, 0, 35))
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

		local tw = surface_GetTextSize("MGA2 Command Menu Large")
		local tw2 = draw_SimpleTextOutlined("M", "DermaLarge", (w/2) - (tw/2), -4, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA2.Colors.Shadow)
		local tw3 = draw_SimpleTextOutlined("G", "DermaLarge", (w/2) - (tw/2) + tw2, -4, MGA2.Colors.MGA2Blue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA2.Colors.Shadow)
		local tw4 = draw_SimpleTextOutlined("A Command Menu Large", "DermaLarge", (w/2) - (tw/2) + tw2 + tw3, -4, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 2, MGA2.Colors.Shadow)
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

		draw_SimpleTextOutlined(LocalNick, "DermaLargeSmall", 52, 8, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)
		draw_SimpleTextOutlined(MGA2.PrettyRank[LocalRank][1], "DermaLargeSmall", 52, 24, MGA2.PrettyRank[LocalRank][2], TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)

		surface_SetFont("DermaLargeSmall")

		local cmdup = (MGA2.WarnCommands[MGA2.SelectedCommand] and MGA2.SelectedCommand:upper()) or MGA2.SelectedCommand
		local tw = surface_GetTextSize("Selected Command: " .. cmdup)
		local tw2 = draw_SimpleTextOutlined("Selected Command: ", "DermaLargeSmall", w - 10 - tw, 8, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)
		draw_SimpleTextOutlined(cmdup, "DermaLargeSmall", w - 10 - tw + tw2, 8, (MGA2.WarnCommands[MGA2.SelectedCommand] and MGA2.Colors.Red) or MGA2.Colors.MGA2Blue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)

		local plyup = MGA2.SelectedPlayer.Nick
		local tw = surface_GetTextSize("Selected Player: " .. plyup)
		local tw2 = draw_SimpleTextOutlined("Selected Player: ", "DermaLargeSmall", w - 10 - tw, 24, MGA2.Colors.White, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)
		draw_SimpleTextOutlined(plyup, "DermaLargeSmall", w - 10 - tw + tw2, 24,  (MGA2.SelectedPlayer.Nick ~= "None" and MGA2.Colors.Yellow) or MGA2.Colors.MGA2Blue, TEXT_ALIGN_LEFT, TEXT_ALIGN_TOP, 1, MGA2.Colors.Shadow)

		local plist = 0
		if (MGA2.PlayerList) then
			plist = #MGA2.PlayerList
		end
		draw_SimpleTextOutlined("Player List(" .. plist .. ")", "DermaLargeSmall2", MGA2.PlyConf.x + (MGA2.PlyConf.w/2), 41, MGA2.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, MGA2.Colors.Shadow)
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

	for i = 1, #MGA2.CommandList do
		if (LocalRankWeight >= MGA2.CommandList[i][1]) then
			MGA2.InsertCommandList(i, MGA2.CmdPanel)
		end
	end

	/*---------------------------------------------------------------------------
	Insert Players List
	---------------------------------------------------------------------------*/
	MGA2.RebuildPlayerList(MGA2.PlyPanel)
end

concommand.Add("mga_menu2", function()
	MGA2.OpenMenu()

	if (MGA.Maps == nil) then
		net.Start("MGA.SendMaps")
		net.SendToServer()
	end
end)


net.Receive("MGA.SendMaps", function()
	MGA.Maps = {}

	for i = 1, net.ReadUInt(16) do
		MGA.Maps[i] = net.ReadString()
	end

	MGA.CommandList[2][4][2][4][1][3] = MGA.Maps
	MGA2.CommandList[2][4][2][4][1][3] = MGA.Maps
end)