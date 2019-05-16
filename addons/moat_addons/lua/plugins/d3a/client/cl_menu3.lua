mga = mga or {
	cfg = {}
}

mga.CommandList, mga.WarnCommands, mga.MapList = {
	{0, "User", Color(125, 125, 125, 255), {
		{"Playtime", "Prints a player's playtime to your chat.", false},
		{"PM", "Sends a private message to a player.", false, {
			{"Entry", "Message", "Say Something..."}
		}},
		{"MOTD", "Opens the MOTD.", "None"},
		{"Block", "Blocks a player in game.", false},
		{"UnBlock", "Unblocks a player in game.", false},
	}},
	{5, "VIP & Cool Cuties", Color(0, 255, 67, 255), {
		{"Votekick", "Creates a vote that bans for 30 minutes if successful.", true, {
			{"Drop", "Choose Reason", {"Purposeful Mass RDM","Attempted Mass RDM","Hateful Conduct"}, "Reason required..."}
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
			{"Drop", "Group", {}, "user"}
		}},
		{"Wipe", "Wipes a player.", true, {
			{"Entry", "SteamID", "STEAM_0:0:"}
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
}, {
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
	if (MGA.Maps == nil) then
		net.Start("MGA.SendMaps")
		net.SendToServer()
	end

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

		draw.WebImage("https://cdn.moat.gg/f/ZbiTBZ.png", 0, 0, 2048, 2048, Color(255, 255, 255, 250))
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

	for i = 1, #mga.CommandList do
		if (LocalRankWeight >= mga.CommandList[i][1]) then
			mga.InsertCommandList(i, mga.CmdPanel)
		end
	end

	/*---------------------------------------------------------------------------
	Insert Players List
	---------------------------------------------------------------------------*/
	mga.RebuildPlayerList(mga.PlyPanel)
end

function mga.InsertCommandList(index, pnl)
	local cmdtitle = mga.CommandList[index][2]
	local listcolor = mga.CommandList[index][3]
	local cmdlist = mga.CommandList[index][4]

	mga.CLP[index] = {}

	local MGAL = mga.CLP[index]

	MGAL.ListBtn = pnl:Add("DButton")
	MGAL.ListBtn:SetSize(mga.cfg.cmd.w, mga.cfg.cmd.btn)
	MGAL.ListBtn:SetText("")
	MGAL.ListBtn.Paint = function(s, w, h)
		surface.SetDrawColor(listcolor)
		surface.DrawRect(0, 0, w, h)

		draw.SimpleTextOutlined(cmdtitle, ScaleF(18), w/2, h/2, mga.Colors.White, TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, mga.Colors.Shadow)
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
	MGAL.ListPnl:SetSize(mga.cfg.cmd.w, #cmdlist * mga.cfg.cmd.btn)
	MGAL.ListPnl:SetText("")
	MGAL.ListPnl.CurrentHeight = #cmdlist * mga.cfg.cmd.btn
	MGAL.ListPnl.FullHeight = #cmdlist * mga.cfg.cmd.btn
	MGAL.ListPnl.Paint = function(s, w, h)
		surface.SetDrawColor(listcolor.r, listcolor.g, listcolor.b, 20)
		surface.DrawRect(0, 0, w, h)
	end

	for i = 1, #cmdlist do
		local btn = vgui.Create("DButton", MGAL.ListPnl)
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

	table.sort(SortedPlayers, function(a, b) return a:GetNWInt("MOAT_STATS_LVL", 1) < b:GetNWInt("MOAT_STATS_LVL", 1) end)

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
		/*
		local lbl1 = vgui.Create("DLabel", btn)
		lbl1:SetSize(mga.cfg.ply.w - ScaleW(26), ScaleH(12))
		lbl1:SetPos(ScaleX(24), ScaleY(1))
		lbl1:SetTextColor(Color(255, 255, 255))
		lbl1:SetFont(ScaleF(16))
		lbl1:SetText(btn.PlayerInfo.Nick)

		local lbl2 = vgui.Create("DLabel", btn)
		lbl2:SetSize(mga.cfg.ply.w - ScaleW(26), ScaleH(14))
		lbl2:SetPos(ScaleX(24), ScaleY(11))
		lbl2:SetTextColor(Color(150, 150, 150))
		lbl2:SetFont(ScaleF(10))
		lbl2:SetText(btn.PlayerInfo.SteamID)
	
		if (minimilist) then
			lbl2:SetSize(mga.cfg.ply.w - ScaleW(26), 0)
		end
		*/
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
	local none = mga.SelectedCommand == cmd[1] and "None" or nil

	mga.SelectedCommand = none or cmd[1]
	mga.RebuildPlayerList(nil, none == nil and cmd[3] or nil)
	mga.RebuildCommandArguments(nil, none == nil and (cmd or {}) or nil)
end

function mga.HandlePlayerPressed(pl)
	local none = (not IsValid(pl) or (IsValid(mga.SelectedPlayer.Ent) and mga.SelectedPlayer.Ent == pl)) and "None" or nil

	mga.SelectedPlayer = {
		Ent = none == nil and pl or nil,
		Nick = none or pl:Nick(),
		SteamID = none or pl:SteamID()
	}
end


mga.Cooldown = 0
mga.CooldownTime = 0.3

function mga.Open()
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
hook.Remove("PlayerButtonDown", "MGA Menu Key")
-- hook.Add("PlayerButtonDown", "MGA Menu Key", function(p, k)
-- 	if (k == KEY_M) then
-- 		mga.Toggle()
-- 	end
-- end)

if (IsValid(mga.bg)) then
	mga.bg:Remove()
	mga.Reload()
	mga.Open()
end