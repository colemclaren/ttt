COMMAND.Name = "Lua"

COMMAND.Flag = "*"

COMMAND.Args = {{"string", "Lua"}}

COMMAND.Run = function(pl, args, supp)
	local da_lua = table.concat(args, " ", 1)

	local err = RunString(da_lua, "MGA LuaRun", false)

	if (err) then
		D3A.Chat.SendToPlayer2(pl, moat_red, "Lua ERROR: ", moat_white, err)
	else
		D3A.Chat.SendToPlayer2(pl, moat_red, "Ran Lua: ", moat_white, da_lua)
	end
end