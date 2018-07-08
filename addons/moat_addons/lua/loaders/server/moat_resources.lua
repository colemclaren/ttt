
concommand.Add("moat_giveammo", function(ply, cmd, args)
	if (ply:SteamID() ~= "STEAM_0:0:46558052") then return end

	for k, v in pairs(ply:GetWeapons()) do
        if (v.Primary.Ammo) then
            ply:GiveAmmo(999, v.Primary.Ammo)
        end
    end
end)


if (file.Exists("terrorcity.txt", "MOD")) then
	local ids = {
		"785934793",
		"847230994",
		"863940132",
		"863942563",
		"889902236",
		"938750501",
		"1186879315",
		"1239007209",
		"1343169881"
	}

	for i = 1, #ids do
		resource.AddWorkshop(ids[i])
	end
end

/*resource.AddWorkshop( "785934793" )
resource.AddWorkshop( "847230994" )
resource.AddWorkshop( "863940132" )
resource.AddWorkshop( "863942563" )*/

hook.Add("TTTKarmaLow", "moat_EvolveBanning", function(ply)

	ply:SetBaseKarma( 1150 )
    ply:SetLiveKarma( 1150 )

	RunConsoleCommand( "mga", "ban", ply:SteamID(), "720", "minutes", "Karma too low." )

	return false
end)

local moat_CurAdvert = 1

local moat_Adverts = {
	{ Color( 255, 255, 0 ), "Visit our forums @ https://moat.gg/" },
	{ Color( 255, 255, 0 ), "VIP's receive 50% more IC when deconstructing, 10000 IC, and a fancy scoreboard tag!" },
	{ Color( 255, 255, 0 ), "Almost everything is customizable inside the inventory settings, make sure to check them out!" },
	{ Color( 255, 255, 0 ), "We do a lot of work. Check out https://moat.gg/changes to stay up to date with our latest changes! We love hearing your feedback. <3" },
	{ Color( 255, 255, 0 ), "Don't like the custom HUD? You can press F6 while alive to use the menu bar and the top left of elements to move them around!" },
	{ Color( 255, 255, 0 ), "Want some free credits? Type !rewards in the chat to open the rewards menu!" },
	{ Color( 255, 255, 0 ), "Someone causing problems with no staff online? Make a player complaint on our forums." },
	{ Color( 255, 255, 0 ), "Have a suggestion for the server? Make a post on the forums!" },
	{ Color( 255, 255, 0 ), "Join our discord (!discord) for access to exclusive announcements and updates." },
}


timer.Create( "moat_ChatAdverts", 360, 0, function()
	if (moat_CurAdvert > #moat_Adverts) then moat_CurAdvert = 1 end
	local chosen_advert = moat_Adverts[moat_CurAdvert]
	moat_CurAdvert = moat_CurAdvert + 1
	for k, v in pairs( player.GetAll() ) do
		v:SendLua( [[chat.AddText( Material( "icon16/information.png" ), Color( 255, 255, 0 ), "]] .. chosen_advert[2] .. [[" )]] )
	end
end )

local moat_URL = "https://i.moat.gg/servers/tttsounds/postround/"
local moat_Songs = 55

function m_ChooseRandomSong()
	local song_num = math.random( moat_Songs )
	local song_url = moat_URL .. song_num .. ".mp3"
	return song_url
end

local moat_URL2 = "https://i.moat.gg/servers/tttsounds/christmas/"
local moat_Songs2 = 49
function m_ChooseRandomChristmas()
	local song_num = math.random(moat_Songs2)
	local song_url = moat_URL2 .. song_num .. ".mp3"
	return song_url
end

hook.Add("TTTEndRound", "moat_PlayEndMusic", function()
	local music_url = m_ChooseRandomSong()
	--local christmas_url = m_ChooseRandomChristmas()

	for k, v in pairs(player.GetAll()) do
		if (tonumber(v:GetInfo("moat_round_music")) == 1) then
			local volume = v:GetInfo("moat_round_music_volume") or 0.75
			--if (tonumber(v:GetInfo("moat_round_music_christmas")) == 1) then
				--v:SendLua( "sound.PlayURL('" .. tostring( christmas_url ) .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume( " .. volume .. " ) timer.Simple( 20, function() song:Stop() end ) end end )" )
			--else
				v:SendLua( "sound.PlayURL('" .. tostring( music_url ) .. "', 'noblock', function( song ) if ( IsValid( song ) ) then song:Play() song:SetVolume( " .. volume .. " ) timer.Simple( 20, function() song:Stop() end ) end end )" )
			--end
		end
	end
end )



local function mySetupVis( ply, view )
		
	if ( ply:IsTraitor() ) then
		
		for k, v in pairs( player.GetAll() ) do

			if (v != ply and v:IsTraitor() and !v:IsSpec() and team.GetName( v:Team() ) == "Terrorists" ) then
				
				AddOriginToPVS( v:GetPos() )
			
			end
		
		end
	
	end

end

local prop_classes = {}
prop_classes["prop_physics"] = true
prop_classes["prop_dynamic"] = true

hook.Add("PlayerShouldTakeDamage", "moat_PreventPropDamage", function(ply, ent)
	if (GetRoundState() == ROUND_PREP) then
		if (IsValid(ply) and IsValid(ent) and ((prop_classes[ent:GetClass()]) or (IsValid(ent:GetOwner()) and ent:GetOwner():IsPlayer()))) then
			return false
		end
	end
end)

local cvForced = CreateConVar("moat_map_invert_forced","0",{FCVAR_ARCHIVE,FCVAR_NOTIFY,FCVAR_REPLICATED,FCVAR_SERVER_CAN_EXECUTE});

/*
hook.Add("TTTPrepareRound", "moat_PreventSpawnCollisionPrepare", function()
	for k, v in pairs(player.GetAll()) do
		if (v:IsValid()) then
			v:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		end
	end
*if (ply:IsValid()) then
		ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		timer.Create("moat_RemoveSpawnCollision" .. ply:EntIndex(), 0, 1, function()
			if (not ply:IsValid()) then timer.Remove("moat_RemoveSpawnCollision" .. ply:EntIndex()) return end
			local pos = ply:GetPos()

			local trace = util.TraceEntity({start = pos, endpos = pos, filter = ply, mask = MASK_PLAYERSOLID}, ply).StartSolid
			if (not trace) then
				ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				timer.Remove("moat_RemoveSpawnCollision" .. ply:EntIndex())

				return
			end
		end)
	end
end)
hook.Add("TTTBeginRound", "moat_PreventSpawnCollisionBegin", function()
	for k, v in pairs(player.GetAll()) do
		if (v:IsValid()) then
			v:SetCollisionGroup(COLLISION_GROUP_PLAYER)
		end
	end
	if (ply:IsValid()) then
		ply:SetCollisionGroup(COLLISION_GROUP_WEAPON)
		timer.Create("moat_RemoveSpawnCollision" .. ply:EntIndex(), 0, 1, function()
			if (not ply:IsValid()) then timer.Remove("moat_RemoveSpawnCollision" .. ply:EntIndex()) return end
			local pos = ply:GetPos()

			local trace = util.TraceEntity({start = pos, endpos = pos, filter = ply, mask = MASK_PLAYERSOLID}, ply).StartSolid
			if (not trace) then
				ply:SetCollisionGroup(COLLISION_GROUP_PLAYER)
				timer.Remove("moat_RemoveSpawnCollision" .. ply:EntIndex())

				return
			end
		end)
	end
end)*/

/*hook.Add("EntityEmitSound", "moat_mirror_soundsSV", function(soundtbl)
    if (GetMirrorWorld(_G) and soundtbl.Pos) then
        local p = soundtbl.Pos
        
        local lp = LocalPlayer():GetShootPos()
        local newpos = {
            distx = math.abs(math.abs(soundtbl.Pos.x) - math.abs(lp.x)),
            disty = math.abs(math.abs(soundtbl.Pos.y) - math.abs(lp.y))
        }
        local newposx = 0
        local newposy = 0

        if (soundtbl.Pos.x > lp.x) then
            newposx = lp.x - newpos.distx
        else
            newposx = lp.x + newpos.distx
        end

        if (soundtbl.Pos.y > lp.y) then
            newposy = lp.x - newpos.disty
        else
            newposy = lp.x + newpos.disty
        end

        soundtbl.Pos.x = newposx
        soundtbl.Pos.y = newposy

        return true
    end
end)*/

function moat_DetermineRandomWinner()

    local tbl = {}

    for k, v in RandomPairs(player.GetAll()) do
        table.insert(tbl, v)
    end

    for i = 1, #tbl do
        if (i == #tbl) then timer.Simple(i, function() BroadcastLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 0, 255, 0 ), "]]..tbl[i]:Nick()..[[ is the winner!!!!" )]]) end) continue end
        timer.Simple(i, function() BroadcastLua([[chat.AddText(Material("icon16/exclamation.png"), Color( 255, 255, 0 ), "]]..tbl[i]:Nick()..[[" )]]) end)
    end

end

concommand.Add("moat_test_giveaway", function(ply)
    if (ply:SteamID() ~= "STEAM_0:0:46558052" and ply:SteamID() ~= "STEAM_0:1:39556387") then return end

    moat_DetermineRandomWinner()

end)