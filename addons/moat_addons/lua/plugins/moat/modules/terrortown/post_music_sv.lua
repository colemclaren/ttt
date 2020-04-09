util.AddNetworkString "Moat.PostRoundMusic"

local moat_URL = "https://cdn.moat.gg/ttt/music/"
local moat_Songs = 138

-- local moat_URL = "https://cdn.moat.gg/ttt/music/hip-hop/"
-- local moat_Songs = 131

function m_ChooseRandomSong()
	local song_num = math.random( moat_Songs )
	local song_url = moat_URL .. song_num .. ".mp3"
	return song_url
end

local moat_URL2 = "https://cdn.moat.gg/ttt/music/christmas/"
local moat_Songs2 = 49
function m_ChooseRandomChristmas()
	local song_num = math.random(moat_Songs2)
	local song_url = moat_URL2 .. song_num .. ".mp3"
	return song_url
end

hook.Add("TTTEndRound", "moat_PlayEndMusic", function()
	local music_url, christmas_url = m_ChooseRandomSong(), m_ChooseRandomChristmas()

	net.Start "Moat.PostRoundMusic"
		net.WriteString(music_url)
		net.WriteString(christmas_url)
	net.Broadcast()
end)