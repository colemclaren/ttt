local killed_verbs = {"cooked","wrecked","roasted","crucified","plundered","sacrificed","eliminated","firebombed","terrorized","devastated","slaughtered","assasinated","incinerated","electrocuted","exterminated"}

if (CLIENT) then
	net.Receive("terrortown.jester.killed", function()
		local nick1 = net.ReadString()
		local pl = net.ReadPlayer()

		pl.Skeleton = true

		chat.AddText(Material("icon16/information.png"), Color(253, 158, 255), nick1 .. " " .. killed_verbs[math.random(#killed_verbs)] .. " a Jester!")

		sound.PlayURL("https://static.moat.gg/ttt/jester_killed.mp3", "mono", function(audio)
			if (audio) then
				audio:SetVolume(0.5)
				audio:Play()
			end
		end)
	end)

	
	hook.Add("TTTEndRound", "terrortown.roles.jester", function()
		for k, v in ipairs(player.GetAll()) do
			v.Skeleton = false
		end
	end)

	hook.Add("TTTPrepareRound", "terrortown.roles.jester", function()
		for k, v in ipairs(player.GetAll()) do
			v.Skeleton = false
		end
	end)

end