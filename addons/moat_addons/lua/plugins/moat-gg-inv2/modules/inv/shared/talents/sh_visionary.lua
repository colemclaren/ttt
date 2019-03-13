if (SERVER) then
	util.AddNetworkString "Moat.Talents.Visionary"
	util.AddNetworkString "Moat.Talents.Notify"

	return
end

local vision_col = Color(255, 255, 0, 255)

local function moat_drawvisionary(f, n)
	if (timer.Exists("Moat.Talents.Visionary")) then
		local tm = timer.TimeLeft("Moat.Talents.Visionary")

		timer.Adjust("Moat.Talents.Visionary", tm + n, 1, function()
			timer.Remove "Moat.Talents.Visionary"
			hook.Remove("PreDrawHalos", "Moat.Talents.DrawVisionary")
		end)

		return
	end

	timer.Create("Moat.Talents.Visionary", n, 1, function()
		hook.Remove("PreDrawHalos", "Moat.Talents.DrawVisionary")
		timer.Remove "Moat.Talents.Visionary"
	end)
	
	local dist = f * f
	hook.Add("PreDrawHalos", "Moat.Talents.DrawVisionary", function()
		local plys, lclpl = player.GetAll(), LocalPlayer()
		local visn = {}

		for i = 1, #plys do
			if (not plys[i]:IsValid() or plys[i]:Team() == TEAM_SPEC) then continue end
			if (lclpl:GetRole() == ROLE_TRAITOR and plys[i]:GetRole() == ROLE_TRAITOR) then continue end
			if (plys[i]:GetPos():DistToSqr(lclpl:GetPos()) > dist) then continue end

			table.insert(visn, plys[i])
		end

		halo.Add(visn, vision_col, 2, 2, 1, true, true)
	end)
end

net.Receive("Moat.Talents.Visionary", function()
	local n = net.ReadDouble()
	local f = net.ReadDouble()

	moat_drawvisionary(f * 25, n)
end)


local tal_cols = {
	Color(178, 102, 255, 255),
	Color(0, 255, 128, 255)
}

net.Receive("Moat.Talents.Notify", function()
	local col = tal_cols[net.ReadUInt(8)] or Color(0, 255, 255, 255)
	local str = net.ReadString()

	chat.AddText(Material("icon16/accept.png"), col, str)
end)