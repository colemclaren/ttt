net.Receive("_SetGlobalInt", function()
	local str = net.ReadString()
	TTT_GLOBALS_SAVE[str] = net.ReadInt(32)
end)

net.Receive("_SetGlobalBool", function()
	local str = net.ReadString()
	TTT_GLOBALS_SAVE[str] = net.ReadBool()
end)

net.Receive("_SetGlobalFloat", function()
	local str = net.ReadString()
	TTT_GLOBALS_SAVE[str] = net.ReadFloat()
end)

net.Receive("_SetGlobalSync", function()
	for k, v in pairs(TTT_GLOBALS) do
		local str = net.ReadString()
		local t = TTT_GLOBALS[str]
		if (not net.ReadBool()) then TTT_GLOBALS_SAVE[str] = nil continue end

		if (t == "Bool") then
			TTT_GLOBALS_SAVE[str] = net.ReadBool()
		elseif (t == "Int") then
			TTT_GLOBALS_SAVE[str] = net.ReadInt(32)
		elseif (t == "Float") then
			TTT_GLOBALS_SAVE[str] = net.ReadFloat()
		end
	end
end)