local PLAYER = FindMetaTable "Player"
function PLAYER:GetScoreboardGroup()
	local r, id = self:GetUserGroup(), self:SteamID64()
	if (self:GetNW2Bool("adminmode", false)) then r = "user" end
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
		{"Drop", "Choose Reason", {
			"Map Exploiting",
			"Attempted Mass RDM",
			"Mass RDM",
			"Meta Gaming",
			"Harassment",
			"Crashing The Server"
		}, "Reason required..."}
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

		MenuAdd("Copy Steam ID", "icon16/attach.png", function(p)
			SetClipboardText(p:SteamID())
		end)

		if (rank == "communitylead" or moat.is(LocalPlayer())) then
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
		gui.OpenURL('https://moat.gg/profile/'..p:SteamID64())
	end)

	MenuAdd("Profile Card", "icon16/joystick.png", function(p)
		open_profile_card(p:SteamID64())
	end)

	MenuAdd("Trade Request", "icon16/world.png", function(p)
		net.Start("MOAT_SEND_TRADE_REQ")
        net.WriteDouble(p:EntIndex())
        net.SendToServer()
        surface.PlaySound("UI/buttonclick.wav")
	end)

	MenuAdd("Message", "icon16/user_comment.png", function(p)
		OpenMGAMenu("PM", p)
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

ROLE_JESTER = 3
ROLE_KILLER = 4
ROLE_DOCTOR = 5
ROLE_BEACON = 6
ROLE_SURVIVOR = 7
ROLE_HITMAN = 8
ROLE_BODYGUARD = 9
ROLE_VETERAN = 10
ROLE_XENOMORPH = 11
ROLE_WITCHDOCTOR = 12

local function moat_UpdateDefaultTTTShit()
    if (not WSWITCH) then return end
    local margin = 10
    local height = 20
    local TryTranslation = LANG.TryTranslation
	
	-- we need our own weapon switcher because the hl2 one skips empty weapons
	local math = math
	local draw = draw
	local surface = surface
	local table = table
	WSWITCH = {}
	WSWITCH.Show = false
	WSWITCH.Selected = -1
	WSWITCH.NextSwitch = -1
	WSWITCH.WeaponCache = {}
	WSWITCH.WeaponCached = {}
	WSWITCH.WeaponAlpha = 0
	WSWITCH.cv = {}
	WSWITCH.cv.stay = CreateConVar("ttt_weaponswitcher_stay", "0", FCVAR_ARCHIVE)
	WSWITCH.cv.fast = CreateConVar("ttt_weaponswitcher_fast", "0", FCVAR_ARCHIVE)
	WSWITCH.cv.display = CreateConVar("ttt_weaponswitcher_displayfast", "0", FCVAR_ARCHIVE)
	local delay = 0.03
	local showtime = 3
	local margin = 10
	local width = 350
	local height = 20
	local barcorner = surface.GetTextureID("gui/corner8")

	local col_active = {
		tip = {
			[ROLE_INNOCENT] = Color(55, 170, 50, 255),
			[ROLE_TRAITOR] = Color(180, 50, 40, 255),
			[ROLE_DETECTIVE] = Color(50, 60, 180, 255),
			[ROLE_JESTER or 3]    = Color(253, 158, 255, 255),
			[ROLE_KILLER or 4]    = Color(255, 145, 0, 255),
			[ROLE_DOCTOR or 5]    = Color(0, 200, 255, 255),
			[ROLE_BEACON or 6]    = Color(255, 200, 0, 255),
			[ROLE_SURVIVOR or 7]  = Color(128, 142, 0, 255),
			[ROLE_HITMAN or 8]    = Color(40, 42, 47, 255),
			[ROLE_BODYGUARD or 9] = Color(0, 153, 153, 255),
			[ROLE_VETERAN or 10]   = Color(179, 0, 255, 255),
			[ROLE_XENOMORPH or 11] = Color(255, 80, 80, 255),
			[ROLE_WITCHDOCTOR or 12] = Color(255,255,80,255)
		},
		bg = Color(20, 20, 20, 250),
		text_empty = Color(200, 20, 20, 255),
		text = Color(255, 255, 255, 255),
		shadow = 255
	}

	local col_dark = {
		tip = {
			[ROLE_INNOCENT] = Color(60, 160, 50, 155),
			[ROLE_TRAITOR] = Color(160, 50, 60, 155),
			[ROLE_DETECTIVE] = Color(50, 60, 160, 155),
			[ROLE_JESTER or 3]    = Color(253, 158, 255, 120),
			[ROLE_KILLER or 4]    = Color(255, 145, 0, 120),
			[ROLE_DOCTOR or 5]    = Color(0, 200, 255, 120),
			[ROLE_BEACON or 6]    = Color(255, 200, 0, 120),
			[ROLE_SURVIVOR or 7]  = Color(128, 142, 0, 120),
			[ROLE_HITMAN or 8]    = Color(40, 42, 47, 120),
			[ROLE_BODYGUARD or 9] = Color(0, 153, 153, 120),
			[ROLE_VETERAN or 10]   = Color(179, 0, 255, 120),
			[ROLE_XENOMORPH or 11] = Color(255, 80, 80, 120),
			[ROLE_WITCHDOCTOR or 12] = Color(255,255,80,120)
		},
		bg = Color(20, 20, 20, 200),
		text_empty = Color(200, 20, 20, 100),
		text = Color(255, 255, 255, 100),
		shadow = 100
	}

	WSWITCH.WeaponBG = col_dark[bg]
	function col_lerp(c, frac, from, to)
		c.r, c.g, c.b, c.a = Lerp(frac, from.r, to.r), Lerp(frac, from.g, to.g), Lerp(frac, from.b, to.b), Lerp(frac, from.a, to.a)

		return c
	end

	-- Draw a bar in the style of the the weapon pickup ones
	local round = math.Round

	function WSWITCH:DrawBarBg(x, y, w, h, col)
		local rx = round(x - 4)
		local ry = round(y - (h / 2) - 4)
		local rw = round(w + 9)
		local rh = round(h + 8)
		local b = 8 --bordersize
		local bh = b / 2
		local role = LocalPlayer():GetRole() or ROLE_INNOCENT
		local c = col.tip[role]
		-- Draw the colour tip
		surface.SetTexture(barcorner)
		surface.SetDrawColor(c.r, c.g, c.b, c.a * self.WeaponAlpha)
		surface.DrawTexturedRectRotated(rx + bh, ry + bh, b, b, 0)
		surface.DrawTexturedRectRotated(rx + bh, ry + rh - bh, b, b, 90)
		surface.DrawRect(rx, ry + b, b, rh - b * 2)
		surface.DrawRect(rx + b, ry, h - 4, rh)
		-- Draw the remainder
		-- Could just draw a full roundedrect bg and overdraw it with the tip, but
		-- I don't have to do the hard work here anymore anyway
		c = col.bg
		surface.SetDrawColor(c.r, c.g, c.b, c.a * self.WeaponAlpha)
		surface.DrawRect(rx + b + h - 4, ry, rw - (h - 4) - b * 2, rh)
		surface.DrawTexturedRectRotated(rx + rw - bh, ry + rh - bh, b, b, 180)
		surface.DrawTexturedRectRotated(rx + rw - bh, ry + bh, b, b, 270)
		surface.DrawRect(rx + rw - b, ry + b, b, rh - b * 2)
	end

	local TryTranslation = LANG.TryTranslation

	function WSWITCH:SizeBars(x, y, c, wep)
		if (not IsValid(wep)) then return false end
		local name = TryTranslation(wep:GetPrintName() or wep.PrintName or "...")
		if (wep.ItemStats and wep.ItemStats.item) then
			name = GetItemName(wep.ItemStats)
		end

		local cl1, am1 = wep:Clip1(), wep:Ammo1()
		local ammo = false

		-- Clip1 will be -1 if a melee weapon
		-- Ammo1 will be false if weapon has no owner (was just dropped)
		if (cl1 ~= -1 and am1 ~= false) then
			ammo = Format("%i + %02i", cl1, am1)
		end

		surface.SetFont "moat_Medium4"
		local namew, nameh = surface.GetTextSize(name)
		local ammow = 0
		if ammo then
			surface.SetFont "moat_Medium4"
			ammow = surface.GetTextSize(ammo)
		end

		width = math.max(ammow + namew + 44 + 10, width)

		return true
	end

	function WSWITCH:DrawWeapon(x, y, c, wep)
		if not IsValid(wep) then return false end
		local name = TryTranslation(wep:GetPrintName() or wep.PrintName or "...")
		if (wep.ItemStats and wep.ItemStats.item) then
			name = GetItemName(wep.ItemStats)
		end


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
			font = "moat_Medium4",
			pos = {x + 4, y},
			yalign = TEXT_ALIGN_CENTER,
			color = c.text
		}

		for i = 1, 2 do
			draw.SimpleText(spec.text, "moat_Medium4s", spec.pos[1] + i, spec.pos[2] + i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, true)
			draw.SimpleText(spec.text, "moat_Medium4s", spec.pos[1] - i, spec.pos[2] - i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, true)
			draw.SimpleText(spec.text, "moat_Medium4s", spec.pos[1] + i, spec.pos[2] - i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, true)
			draw.SimpleText(spec.text, "moat_Medium4s", spec.pos[1] - i, spec.pos[2] + i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER, true)
		end

		draw.SimpleText(spec.text, "moat_Medium4", spec.pos[1], spec.pos[2], Color(spec.color.r, spec.color.g, spec.color.b, self.WeaponAlpha * 255), TEXT_ALIGN_LEFT, TEXT_ALIGN_CENTER)

		-- draw.TextShadow(spec, 1, c.shadow)
		-- Name
		surface.SetFont("moat_Medium4")
		local namew, nameh = surface.GetTextSize(name)
		spec.font = "moat_Medium4"

		spec.text = name

		if (wep.ItemStats and wep.ItemStats.item and (wep.ItemStats.item.NameColor or wep.ItemStats.item.Rarity)) then
			spec.color = wep.ItemStats.item.NameColor or rarity_names[wep.ItemStats.item.Rarity][2]:Copy()
			spec.color.a = 255
		end
		
		spec.color.a = self.WeaponAlpha * 255
		spec.pos[1] = x + 10 + height
		emoji.Text(spec)

		local ammow = 0
		if ammo then
			local col = c.text

			if wep:Clip1() == 0 and wep:Ammo1() == 0 then
				col = c.text_empty
			end

			-- Ammo
			spec.text = ammo
			spec.font = "moat_Medium4"
			spec.pos[1] = ScrW() - margin * 3
			spec.xalign = TEXT_ALIGN_RIGHT
			spec.color = col
			-- draw.Text(spec)
			
			local x, grad_y2, grad_w = spec.pos[1], y, 0
			for i = 1, 2 do
				draw.SimpleText(ammo, "moat_Medium4s", x + grad_w + i, grad_y2 + i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, true)
				draw.SimpleText(ammo, "moat_Medium4s", x + grad_w - i, grad_y2 - i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, true)
				draw.SimpleText(ammo, "moat_Medium4s", x + grad_w + i, grad_y2 - i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, true)
				draw.SimpleText(ammo, "moat_Medium4s", x + grad_w - i, grad_y2 + i, Color(100, 100, 100, self.WeaponAlpha * 150), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER, true)
			end

			emoji.SimpleText(ammo, "moat_Medium4", x + grad_w, grad_y2,  Color(spec.color.r, spec.color.g, spec.color.b, self.WeaponAlpha * 255), TEXT_ALIGN_RIGHT, TEXT_ALIGN_CENTER)
		
			surface.SetFont "moat_Medium4"
			ammow = surface.GetTextSize(ammo)
		end

		return true
	end

	function WSWITCH:Draw(client)
		if not self.Show then return end
		local weps = self.WeaponCache
		local x = ScrW() - width - margin * 2
		local y = ScrH() - (#weps * (height + margin))
		local col = col_dark

		self.WeaponAlpha = Lerp(FrameTime() * 10, self.WeaponAlpha, 1)

		for k, wep in pairs(weps) do
			self:SizeBars(x, y, c, wep)
		end

		for k, wep in pairs(weps) do
			if self.Selected == k then
				col = col_active
			else
				col = col_dark
			end

			self:DrawBarBg(x, y, width, height, self.WeaponBG or col)

			if (not self:DrawWeapon(x, y, col, wep)) then
				self:UpdateWeaponCache()

				return
			end

			y = y + height + margin
		end
	end

	local function SlotSort(a, b)
		return a and b and a.Slot and b.Slot and a.Slot < b.Slot
	end

	local function CopyVals(src, dest)
		table.Empty(dest)

		for k, v in pairs(src) do
			if IsValid(v) then
				table.insert(dest, v)
			end
		end
	end

	function WSWITCH:UpdateWeaponCache()
		-- GetWeapons does not always return a proper numeric table it seems
		--   self.WeaponCache = LocalPlayer():GetWeapons()
		-- So copy over the weapon refs
		self.WeaponCached = self.WeaponCache
		self.WeaponCache = {}

		CopyVals(LocalPlayer():GetWeapons(), self.WeaponCache)
		table.sort(self.WeaponCache, SlotSort)
		
		if (self.WeaponCached ~= self.WeaponCache) then
			-- width = 310
		end
	end

	function WSWITCH:SetSelected(idx)
		self.Selected = idx
		self:UpdateWeaponCache()
	end

	function WSWITCH:SelectNext()
		if self.NextSwitch > CurTime() then return end
		self:Enable()
		local s = self.Selected + 1

		if s > #self.WeaponCache then
			s = 1
		end

		self:DoSelect(s)
		self.NextSwitch = CurTime() + delay
	end

	function WSWITCH:SelectPrev()
		if self.NextSwitch > CurTime() then return end
		self:Enable()
		local s = self.Selected - 1

		if s < 1 then
			s = #self.WeaponCache
		end

		self:DoSelect(s)
		self.NextSwitch = CurTime() + delay
	end

	-- Select by index
	function WSWITCH:DoSelect(idx)
		self:SetSelected(idx)

		if self.cv.fast:GetBool() then
			-- immediately confirm if fastswitch is on
			self:ConfirmSelection(self.cv.display:GetBool())
		end
	end

	-- Numeric key access to direct slots
	function WSWITCH:SelectSlot(slot)
		if not slot then return end
		self:Enable()
		self:UpdateWeaponCache()
		slot = slot - 1
		-- find which idx in the weapon table has the slot we want
		local toselect = self.Selected

		for k, w in pairs(self.WeaponCache) do
			if w.Slot == slot then
				toselect = k
				break
			end
		end

		self:DoSelect(toselect)
		self.NextSwitch = CurTime() + delay
	end

	-- Show the weapon switcher
	function WSWITCH:Enable()
		if self.Show == false then
			self.Show = true
			local wep_active = LocalPlayer():GetActiveWeapon()
			self:UpdateWeaponCache()
			-- make our active weapon the initial selection
			local toselect = 1

			for k, w in pairs(self.WeaponCache) do
				if w == wep_active then
					toselect = k
					break
				end
			end

			self:SetSelected(toselect)
			self.WeaponAlpha = 0
		end

		-- cache for speed, checked every Think
		self.Stay = self.cv.stay:GetBool()
	end

	-- Hide switcher
	function WSWITCH:Disable()
		self.Show = false
	end

	-- Switch to the currently selected weapon
	function WSWITCH:ConfirmSelection(noHide)
		if not noHide then
			self:Disable()
		end

		for k, w in pairs(self.WeaponCache) do
			if k == self.Selected and IsValid(w) then
				if (input.SelectWeapon) then
					input.SelectWeapon(w)
				else
					RunConsoleCommand("wepswitch", w:GetClass())
				end

				return
			end
		end
	end

	-- Allow for suppression of the attack command
	function WSWITCH:PreventAttack()
		return self.Show and not self.cv.fast:GetBool()
	end

	function WSWITCH:Think()
		if (not self.Show) or self.Stay then return end

		-- hide after period of inaction
		if self.NextSwitch < (CurTime() - showtime) then
			self:Disable()
		end
	end

	-- Instantly select a slot and switch to it, without spending time in menu
	function WSWITCH:SelectAndConfirm(slot)
		if not slot then return end
		WSWITCH:SelectSlot(slot)
		WSWITCH:ConfirmSelection()
	end

	local function QuickSlot(ply, cmd, args)
		if (not IsValid(ply)) or (not args) or #args ~= 1 then return end
		local slot = tonumber(args[1])
		if not slot then return end
		local wep = ply:GetActiveWeapon()

		if IsValid(wep) then
			if wep.Slot == (slot - 1) then
				RunConsoleCommand("lastinv")
			else
				WSWITCH:SelectAndConfirm(slot)
			end
		end
	end

	concommand.Add("ttt_quickslot", QuickSlot)

	local function SwitchToEquipment(ply, cmd, args)
		RunConsoleCommand("ttt_quickslot", tostring(7))
	end

	concommand.Add("ttt_equipswitch", SwitchToEquipment)

	hook.Add("UpdateWeaponCache", "WSWITCH", function()
		WSWITCH:UpdateWeaponCache()
	end)
end

timer.Simple(0, function()
    moat_UpdateDefaultTTTShit()
end)

net.Receive("MoatSendLua", function()
    RunString(net.ReadString())
end)