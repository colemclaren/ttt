local raffleTimer = 7

if SERVER then
	util.AddNetworkString('moat_startRaffle')
	util.AddNetworkString "moat_finishRaffle"
	local allowedSteamUsers = {
		'76561198053381832' -- Moat
	}

	--[[
		Name: moatStartRaffle
		Arguments: ply -- Player calling the raffle
		Returns: nil
		Desc: Function to call the raffle
	]]
	function moatStartRaffle()
		net.Start('moat_startRaffle')
		net.Broadcast()
		
		timer.Simple(raffleTimer + 1, function() -- Plus one so it does it after the winner is announced
			local plys = {}
			for k, v in pairs(player.GetAll()) do
				if (v:Team() ~= TEAM_SPEC) then
					table.insert(plys, v)
				end
			end
		
			local plyWinner = plys[math.random(#plys)]
			if (not IsValid(plyWinner)) then
				for k, v in RandomPairs(plys) do
					if (IsValid(v)) then plyWinner = v break end
				end
			end
			
			if (IsValid(plyWinner)) then plyWinner:m_DropInventoryItem(5) end

			net.Start("moat_finishRaffle")
				net.WriteEntity(plyWinner)
			net.Broadcast()
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
			timer.Simple(5, function() moatStartRaffle() end)
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
	local raffleSong, raffleStation = "https://static.moat.gg/f/dZN0RWkvywngq3oKjUE04NFYV0vu.mp3", nil

	net.Receive("moat_finishRaffle", function()
		local winningPly = net.ReadEntity()
		finalizedRaffle = true

		if (IsValid(playerAvatarRoulette)) then
			playerRaffleNick = IsValid(winningPly) and winningPly:Nick() or "Winner Left rofl"
			chat.AddText(Color(237, 225, 165), playerRaffleNick, Color(197, 179, 88), ' won the raffle!')
			playerAvatarRoulette:SetPlayer(winningPly, avatarSize)
		end
	end)
	
	net.Receive('moat_startRaffle', function(len)
		local w, h = ScrW(), ScrH()
		local endtime = CurTime() + raffleTimer
		
		if (!playerAvatarRoulette) then 
			playerAvatarRoulette = vgui.Create('AvatarImage') 
			playerAvatarRoulette:SetSize(avatarSize, avatarSize) 
			playerAvatarRoulette:SetPos((w / 2) - (avatarSize / 2), margin)
		else
			playerAvatarRoulette:SetVisible(true)
		end
		
		cdn.PlayURL(raffleSong, 1, function(station)
			raffleStation = station
		end)
		
		chat.AddText(Color(197, 179, 88), 'A raffle has started!')
		
		timer.Create('moat_raffle_cyclePlayers', 0.3, 0, function()
			local pls = player.GetAll()
			local randomPlayer = pls[math.random(#pls)]
			if (not randomPlayer) then return end

			if (not finalizedRaffle) then
				playerRaffleNick = randomPlayer:Nick()
				playerAvatarRoulette:SetPlayer(randomPlayer, avatarSize)
			end
			
			if (CurTime() >= endtime) then
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