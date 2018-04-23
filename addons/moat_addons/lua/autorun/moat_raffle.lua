local raffleTimer = 7

if SERVER then
	util.AddNetworkString('moat_startRaffle')
	local allowedSteamUsers = {
		'76561198053381832', -- Moat
		'76561197996924066', -- Nook
	}

	--[[
		Name: moatStartRaffle
		Arguments: ply -- Player calling the raffle
		Returns: nil
		Desc: Function to call the raffle
	]]
	function moatStartRaffle()

		local plys = {}

		for k, v in pairs(player.GetAll()) do
			if (v:Team() ~= TEAM_SPEC) then
				table.insert(plys, v)
			end
		end
		
		local plyWinner = plys[math.random(1, #plys)]
		net.Start('moat_startRaffle')
			net.WriteEntity(plyWinner)
		net.Broadcast()
		
		timer.Simple(raffleTimer + 1, function() -- Plus one so it does it after the winner is announced
			plyWinner:m_DropInventoryItem(5)
		end)
	end
	
	concommand.Add('moat_raffle_start', function(ply, cmd, args, argStr)
		local canUse = false
		
		for _, steamID64 in ipairs(allowedSteamUsers) do
			if (ply:SteamID64() == steamID64) then
				canUse = true
			end
		end
		
		if (!canUse) then ply:ChatPrint('You cannot start a raffle!') return end
		
		moatStartRaffle()		
	end)
	
	hook.Add('TTTBeginRound', 'moat_roundStart_raffle', function()
		local raffleChance = 1
		local randomNum = math.random(1, 20)
		
		if (randomNum == raffleChance) then
			moatStartRaffle()
		end
	end)
else
	surface.CreateFont('moat_raffleHUDFont', {
		font = 'DermaLarge',
		size = 26,
		weight = 800
	})
	
	local playerAvatarRoulette, playerRaffleNick = nil, ''
	local avatarSize, margin = 128, 25
	local finalizedRaffle = false
	local raffleSong, raffleStation = 'https://i.moat.gg/servers/tttsounds/rafflesong.mp3', nil
	
	net.Receive('moat_startRaffle', function(len)
		local w, h = ScrW(), ScrH()
		local endtime = CurTime() + raffleTimer
		local winningPly = net.ReadEntity()
		
		if (!playerAvatarRoulette) then 
			playerAvatarRoulette = vgui.Create('AvatarImage') 
			playerAvatarRoulette:SetSize(avatarSize, avatarSize) 
			playerAvatarRoulette:SetPos((w / 2) - (avatarSize / 2), margin)
		else
			playerAvatarRoulette:SetVisible(true)
		end
		
		sound.PlayURL(raffleSong, '', function(station)
			if (IsValid(station)) then
				station:Play()
				raffleStation = station
			end
		end)
		
		chat.AddText(Color(197, 179, 88), 'A raffle has started!')
		
		timer.Create('moat_raffle_cyclePlayers', 0.3, 0, function()
			local randomPlayer = table.Random(player.GetAll())
			playerRaffleNick = randomPlayer:Nick()
			playerAvatarRoulette:SetPlayer(randomPlayer, avatarSize)
			
			if (CurTime() >= endtime) then
				playerAvatarRoulette:SetPlayer(winningPly, avatarSize)
				if (not IsValid(winningPly)) then
					playerRaffleNick = "Winner Left rofl"
				else
					playerRaffleNick = winningPly:Nick()
				end
				finalizedRaffle = true
				
				chat.AddText(Color(237, 225, 165), playerRaffleNick, Color(197, 179, 88), ' won the raffle!')
				
				timer.Destroy('moat_raffle_cyclePlayers')
				
				timer.Simple(5, function()
					playerAvatarRoulette:SetVisible(false)
					playerRaffleNick = ''
					finalizedRaffle = false
					if (raffleStation) then
						raffleStation:Stop()
					end
				end)
			end
		end)
	end)
	
	hook.Add('HUDPaint', 'moat_raffleHUD', function()
		if (playerRaffleNick == '') then return end
		
		local w, h = ScrW(), ScrH()
		
		if (finalizedRaffle) then
			textFunction = DrawRainbowText(5, playerRaffleNick, 'moat_raffleHUDFont', w / 2, avatarSize + margin, TEXT_ALIGN_CENTER)
		else
			draw.SimpleText(playerRaffleNick, 'moat_raffleHUDFont', w / 2, avatarSize + margin, Color(255, 255, 255), TEXT_ALIGN_CENTER)
		end
	end)
end