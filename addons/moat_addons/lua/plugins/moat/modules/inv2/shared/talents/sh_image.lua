if (SERVER) then
	util.AddNetworkString("JennyDoggo")
	return
end

local doggo_save = {}
local doggo_play = CurTime()
hook.Add("HUDPaint", "moat_JennyDoggo", function()
	if (doggo_play <= CurTime()) then return end
	
	local scrw, scrh = ScrW(), ScrH()
	local img = 1
	for i = 1, 28 do
		img = i
		if (i > 14) then img = i - 14 end

		if (not doggo_save[i] or (doggo_save[i] and doggo_save[i].lastupdate and doggo_save[i].lastupdate < CurTime() - 0.1)) then doggo_save[i] = {math.random(1, scrw - 256), math.random(1, scrh - 256), lastupdate = CurTime()} end
		cdn.DrawImage("https://static.moat.gg/assets/img/doggo/" .. img .. ".png", doggo_save[i][1], doggo_save[i][2], 256, 256, Color(255, 255, 255))
	end
end)

net.Receive("JennyDoggo", function()
	local owner = net.ReadBool()
	if (owner) then
		chat.AddText(Material("icon16/heart.png"), Color(255, 0, 127), "You have overwelmed your target with doggo :D")
		return
	end

	local amt = net.ReadDouble()
	doggo_play = CurTime() + amt 
end)