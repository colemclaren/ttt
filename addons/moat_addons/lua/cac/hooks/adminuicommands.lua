hook.Add ("PlayerSay", "CAC.ChatCommands",
	function (ply, text)
		if not CAC.Permissions.PlayerHasPermission (ply, "ViewMenu") then return end
		
		if string.Trim (string.lower (text)) == "!cac_menu" then
			ply:ConCommand ("+cac_menu")
		end
	end
)

CAC:AddEventListener ("Unloaded",
	function ()
		hook.Remove ("PlayerSay", "CAC.ChatCommands")
	end
)