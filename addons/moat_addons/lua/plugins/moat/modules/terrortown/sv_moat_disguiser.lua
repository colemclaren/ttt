local function enabled_disguise(pl)
	pl.DisguiseModel = pl:GetModel()
	pl.DisguiseColor = pl:GetColor()
	pl.DisguisePlayerColor = pl:GetPlayerColor()

	pl:SetModel(GAMEMODE.playermodel or GetRandomPlayerModel() or "models/player/phoenix.mdl")
	pl:SetColor(Color(255, 255, 255, 255))
	pl:SetPlayerColor(Vector(1, 1, 1))

	net.Start "MOAT_PLAYER_CLOAKED"
	net.WriteEntity(pl)
	net.WriteBool(true)
	net.Broadcast()
end

local function disabled_disguise(pl)
	if (pl.DisguiseModel) then
		pl:SetModel(pl.DisguiseModel)
	end

	if (pl.DisguiseColor) then
		pl:SetColor(pl.DisguiseColor)
	end

	if (pl.DisguisePlayerColor) then
		pl:SetPlayerColor(pl.DisguisePlayerColor)
	end

	net.Start "MOAT_PLAYER_CLOAKED"
	net.WriteEntity(pl)
	net.WriteBool(false)
	net.Broadcast()
end

hook.Add("TTTToggleDisguiser", "Moat.Toggle.Disguiser", function(pl, state)
	if (cur_random_round and cur_random_round == "Invisible Traitors") then return end

	if (state) then
		enabled_disguise(pl)
	else
		disabled_disguise(pl)
	end
end)
