COMMAND.Name = "Lua"

COMMAND.Flag = "*"

COMMAND.Args = {{"string", "Lua"}}

COMMAND.Run = function(pl, args, supp)
	local da_lua = table.concat(args, " ", 1)

	local lua = CompileString(da_lua,"MGA.Lua")
	local succ, ret = pcall(lua)

	if (not succ) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Lua ERROR: ", moat_white, ret)
	elseif (not ret) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Ran Lua: ", moat_white, da_lua)
	else
		D3A.Chat.SendToPlayer2(pl, moat_red, "Lua returned var: ", moat_white, tostring(ret))
	end
end