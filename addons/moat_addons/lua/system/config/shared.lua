-- stuff
moat.cfg.developers = {
	{name = "motato", id = "STEAM_0:0:46558052", id64 = "76561198053381832"},
	{name = "meepen", id = "STEAM_0:0:44950009", id64 = "76561198050165746"},
	{name = "velkon", id = "STEAM_0:0:96933728", id64 = "76561198154133184"}
}

moat.isdev, moat.isdevc = function(str)
	if (moat.isdevc[str]) then return moat.isdevc[str] end
	str = (IsValid(str) and str:IsPlayer()) and str:SteamID64() or str

	local dev = false
	for k, v in ipairs(moat.cfg.developers) do
		if (v.id == str or v.id64 == str) then
			dev = true
			break
		end
	end

	moat.isdevc[str] = dev
	return dev
end, {}