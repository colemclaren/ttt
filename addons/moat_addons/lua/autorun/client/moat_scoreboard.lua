
local MOAT_RANKS = {}
MOAT_RANKS[ "guest" ] = { "", Color( 255, 255, 255 ), true, false, false }
MOAT_RANKS[ "user" ] = { "", Color( 255, 255, 255 ), true, false, false }
MOAT_RANKS[ "vip" ] = { "VIP", Color( 0, 255, 0 ), true, true, false }
MOAT_RANKS[ "credibleclub" ] = { "Credible Club", Color( 255, 128, 0 ), true, true, false }
MOAT_RANKS[ "trialstaff" ] = { "Trial Staff", Color( 51, 204, 255 ), true, true, true }
MOAT_RANKS[ "moderator" ] = { "Moderator", Color( 0, 102, 0 ), true, true, true }
MOAT_RANKS[ "admin" ] = { "Administrator", Color( 102, 0, 204 ), true, true, true }
MOAT_RANKS[ "senioradmin" ] = { "Senior Administrator", Color( 102, 0, 102 ), true, true, true }
MOAT_RANKS[ "headadmin" ] = { "Head Administrator", Color( 51, 0, 51 ), true, true, true }
MOAT_RANKS[ "communitylead" ] = { "Community Lead", Color( 255, 0, 0 ), true, true, true }

local operation_leads = {}
operation_leads["STEAM_0:1:39556387"] = true
operation_leads["STEAM_0:1:69138364"] = true

local tech_leads = {}
tech_leads["STEAM_0:0:96933728"] = true


hook.Add( "TTTScoreboardColumns", "moat_AddGroupLevel", function( pnl )

	pnl:AddColumn( "Rank", function( ply, label )

		local ply_rank = table.Copy(MOAT_RANKS[ply:GetUserGroup()])

		if (operation_leads[ply:SteamID()]) then ply_rank[1] = "Operations Lead" end
		if (tech_leads[ply:SteamID()]) then ply_rank[1] = "Tech Lead" end

		label:SetTextColor( ply_rank[2] )

		return ply_rank[1]

	end, 150 )

	pnl:AddColumn( "Level", function( ply, label )

		return ply:GetNWInt("MOAT_STATS_LVL", 1)

	end )

end )

hook.Add("ScoreboardShow", "moat_ScoreboardShow", function()
	if (IsValid(sboard_panel)) then
		sboard_panel:SetDrawOnTop(true)
	end
end)

hook.Add("TTTScoreboardColorForPlayer", "moat_TTTScoreboardColor", function(ply)

	return MOAT_RANKS[ply:GetUserGroup()][2]

end)

local MOAT_SCOREBOARD_MENU = {
	{1, "Copy SteamID", "icon16/tag_blue.png", function(ply) SetClipboardText(ply:SteamID()) end},
	{1, "Copy Name", "icon16/user_edit.png", function(ply) SetClipboardText(ply:Nick()) end},
	{1, "View Profile", "icon16/world.png", function(ply) ply:ShowProfile() end},
	{1, "Block", "icon16/delete.png", function(ply) RunConsoleCommand("mga", "block", ply:SteamID()) end},
	{1, "Unblock", "icon16/accept.png", function(ply) RunConsoleCommand("mga", "unblock", ply:SteamID()) end},
	{2, "Votekick", "icon16/door_in.png", function(ply) RunConsoleCommand("mga", "votekick", ply:SteamID()) end},
	{3, "AFK", "icon16/user_delete.png", function(ply) RunConsoleCommand("mga", "afk", ply:SteamID()) end},
	{3, "Mute/UnMute", "icon16/sound_delete.png", function(ply) RunConsoleCommand("mga", "mute", ply:SteamID()) end},
	{3, "Gag/UnGag", "icon16/transmit_delete.png", function(ply) RunConsoleCommand("mga", "gag", ply:SteamID()) end},
	{3, "Bring", "icon16/arrow_undo.png", function(ply) RunConsoleCommand("mga", "bring", ply:SteamID()) end}
}

local function moat_TTTScoreboardMenu(menu)
	
	local rank = LocalPlayer():GetUserGroup()
	local ply = menu.Player
	
	for k, v in ipairs(MOAT_SCOREBOARD_MENU) do

		if (MOAT_RANKS[rank][2 + v[1]]) then

			local old_tbl = MOAT_SCOREBOARD_MENU[k - 1]

			if (old_tbl and old_tbl[1] ~= v[1]) then
				menu:AddSpacer()
			end

			if (v[2] == "Votekick") then
				local submenu, parent = menu:AddSubMenu(v[2])
				parent:SetImage(v[3])
				submenu:AddOption("Yes I'm sure.", function() v[4](ply) end):SetIcon( "icon16/tick.png" )
				submenu:AddOption("Cancel."):SetIcon( "icon16/cross.png" )
				continue
			end

			menu:AddOption(v[2], function() v[4](ply) end):SetImage(v[3])
		end

	end
	
	hook.Add("Think", "moat_TTTSCoreboardMenuClose", function()
		if (not input.IsKeyDown( KEY_TAB )) then
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

timer.Simple(0, function() moat_UpdateDefaultTTTShit() end)

net.Receive("MoatSendLua", function()
    RunString(net.ReadString())
end)