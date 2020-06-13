local EagleSounds = {
	["Eagle Aim"] = "https://static.moat.gg/ttt/headshot/surreal-headshot-kill.wav",
	["Eagle Kill"] = "https://static.moat.gg/ttt/headshot/surreal-killshot.wav",
	["Eagle Clack"] = "https://static.moat.gg/ttt/headshot/metallic-headshot.wav",
	["Arcade Tap"] = "https://static.moat.gg/ttt/headshot/arcade-bodyshot.wav",
	["Arcade Headshot"] = "https://static.moat.gg/ttt/headshot/arcade-headshot.wav",
	["Arcade Kill"] = "https://static.moat.gg/ttt/headshot/arcade-headshot-kill.wav",
	["Arcade Missed"] = "https://static.moat.gg/ttt/headshot/arcade-killshot.wav",
	["FPS Hitmarker"] = "https://static.moat.gg/ttt/headshot/fps-bodyshot.wav",
	["FPS Headshot"] = "https://static.moat.gg/ttt/headshot/fps-headshot.wav",
	["Rusty Aim"] = "https://static.moat.gg/ttt/headshot/metallic-headshot.wav"
}

hook("Moat.Headshot", function()
	local snd = GetConVar("moat_headshot_sound"):GetString()
	if (not EagleSounds[snd]) then
		snd = "Eagle Aim"
	end

	cdn.PlayURL(EagleSounds[snd])
end)

net.Receive("Moat.Headshot.Sound", function()
	local vol = GetConVar("moat_headshot_sounds"):GetFloat()
	if (vol <= 0) then
		return
	end

	hook.Run "Moat.Headshot"

	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
	-- cdn.PlayURL "https://static.moat.gg/f/55aLKs6xUXfnMseoc0eWDkcyWdMAJ9yF.mp3"
end)