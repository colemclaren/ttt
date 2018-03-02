CreateConVar("sv_customnodegraph_enabled", 1, FCVAR_NOTIFY)
hook.Add("InitPostEntity", "SLV_GM_Initialized", function()
	hook.Remove("InitPostEntity", "SLV_GM_Initialized")
	if GAMEMODE.IsSandboxDerived then
		hook.Add("PlayerSpawnedNPC", "SLV_InitNPCSandbox", function(pl, npc)
			if IsValid(npc) && npc.InitSandbox then npc:InitSandbox() end
		end)
	end
	
	local tags = GetConVarString("sv_tags")
	local tblTags = {}
	for addon, info in pairs(SLVBase.GetDerivedAddons()) do
		if info.tag then table.insert(tblTags, info.tag) end
	end
	if #tblTags == 0 then return end
	if tags then
		local _tblTags = string.Explode(",", tags)
		for _, tag in pairs(tblTags) do
			if !table.HasValue(_tblTags, tag) then
				tags = tags .. "," .. tag
			end
		end
		RunConsoleCommand("sv_tags", tags)
	else RunConsoleCommand("sv_tags", table.concat(tblTags, ",")) end
end)

