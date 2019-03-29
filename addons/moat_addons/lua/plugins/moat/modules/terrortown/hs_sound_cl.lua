net.Receive("Moat.Headshot.Sound", function()
	if GetConVar("moat_headshot_sound"):GetInt() ~= 1 then
		return
	end
	print("HS")
	cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
end)