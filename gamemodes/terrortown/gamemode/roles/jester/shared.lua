local killed_verbs = {"cooked","wrecked","roasted","crucified","plundered","sacrificed","eliminated","firebombed","terrorized","devastated","slaughtered","assasinated","incinerated","electrocuted","exterminated"}

if (CLIENT) then
	net.Receive("terrortown.jester.killed", function()
		local nick1 = net.ReadString()

		chat.AddText(Material("icon16/information.png"), Color(253, 158, 255), nick1 .. " " .. killed_verbs[math.random(#killed_verbs)] .. " Jester!")

		sound.PlayURL("https://cdn.moat.gg/ttt/jester_killed.mp3", "mono", function(audio)
			if (audio) then
				audio:SetVolume(0.5)
				audio:Play()
			end
		end)
	end)
end