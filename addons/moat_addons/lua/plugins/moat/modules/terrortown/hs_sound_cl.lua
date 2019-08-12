local EagleSounds = {
	["Eagle Aim"] = "https://cdn.moat.gg/f/7d0Uf.wav",
	["Eagle Kill"] = "https://cdn.moat.gg/f/QUJmd.wav",
	["Eagle Clack"] = "https://cdn.moat.gg/f/gMZ7h.wav",
	["Arcade Tap"] = "https://cdn.moat.gg/f/3I5r0.wav",
	["Arcade Headshot"] = "https://cdn.moat.gg/f/l3GS6.wav",
	["Arcade Kill"] = "https://cdn.moat.gg/f/SAqqL.wav",
	["Arcade Missed"] = "https://cdn.moat.gg/f/r01Nd.wav",
	["FPS Hitmarker"] = "https://cdn.moat.gg/f/Xo03v.wav",
	["FPS Headshot"] = "https://cdn.moat.gg/f/iVweK.wav",
	["Rusty Aim"] = "https://cdn.moat.gg/f/Jvr0A.wav"
}

net.Receive("Moat.Headshot.Sound", function()
	local vol = GetConVar("moat_headshot_sounds"):GetFloat()
	if (vol <= 0) then
		return
	end

	local snd = GetConVar("moat_headshot_sound"):GetString()
	if (not EagleSounds[snd]) then
		snd = "Eagle Aim"
	end

	cdn.PlayURL(EagleSounds[snd], function(me)
		if (IsValid(me)) then
			me:Play()
		end
	end)

	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://cdn.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
end)