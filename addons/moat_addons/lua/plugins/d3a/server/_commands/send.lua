COMMAND.Name = "Send"
COMMAND.Flag = D3A.Config.Commands.Send

COMMAND.Args = {{"player", "Name/SteamID Player 1"}, {"player", "Name/SteamID Player 2"}}

COMMAND.Run = function(pl, args, supp)
	local targ = supp[1]
	local pos = D3A.FindEmptyPos(supp[2]:GetPos(), {supp[2]}, 600, 30, Vector(16, 16, 64))

	if not targ:Alive() then 
		if targ:IsFrozen() then targ:Spawn() targ:Freeze(true)
		else
			targ:Spawn()
		end
	end
		
	targ.LastPos = targ:GetPos()
	targ:SetPos(pos)
	
	D3A.Chat.Broadcast2(moat_cyan, D3A.Commands.Name(pl), moat_white, " has sent ", moat_green, supp[1]:NameID(), moat_white, " to ", moat_green, supp[2]:NameID(), moat_white, ".")
end