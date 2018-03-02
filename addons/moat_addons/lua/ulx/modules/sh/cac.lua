local function cac (ply)
	if not ply:IsValid() then
		Msg ("You can't see the !cake Anti-Cheat menu from the console.\n")
		return
	end
	
	ply:ConCommand ("+cac_menu")
end
local command = ulx.command ("Menus", "ulx cac", cac)
command:defaultAccess (ULib.ACCESS_ALL)
command:help ("Show the !cake Anti-Cheat menu.")
