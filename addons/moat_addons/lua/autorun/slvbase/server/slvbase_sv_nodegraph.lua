concommand.Add("hlr_nodegraph_selecttool", function(pl,cmd,args)
	if !IsValid(pl) then return end
	pl:SelectWeapon("gmod_tool")
	pl:ConCommand("gmod_tool hlr_nodegraph_create")
end)