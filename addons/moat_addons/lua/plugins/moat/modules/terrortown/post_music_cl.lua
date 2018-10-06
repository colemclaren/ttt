net.Receive("Moat.PostRoundMusic", function()
	if (GetConVar("moat_round_music"):GetInt() == 1) then
		cdn.PlayURL(net.ReadString(), GetConVar("moat_round_music_volume"):GetFloat() or 0.75)
	end
end)