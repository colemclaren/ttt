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
end)