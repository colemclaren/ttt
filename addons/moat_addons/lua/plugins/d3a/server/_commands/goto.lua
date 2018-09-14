COMMAND.Name = "Goto"

COMMAND.Flag = D3A.Config.Commands.Goto
COMMAND.AdminMode = true

COMMAND.Args = {{"player", "Name/SteamID"}}

COMMAND.Run = function(pl, args, supp)
	local targ = supp[1]
	
	local pos = targ:GetPos();
	pos = D3A.FindEmptyPos(pos, {pl}, 600, 30, Vector(16, 16, 64))
	
	pl.LastPos = pl:GetPos()
	pl:SetPos(pos)
	
	if !targ:HasAccess("M") then
		D3A.Chat.SendToPlayer2(targ, moat_red, pl:Name() .. " went to you.")
	end
	
	for k, v in pairs(player.GetAll()) do
		if v:HasAccess("M") then
			D3A.Chat.SendToPlayer2(v, moat_red, pl:Name() .. " went to " .. targ:Name() .. ".")
		end
	end

	D3A.Commands.Discord("goto", (IsValid(pl) and pl:NameID()) or D3A.Console, IsValid(targ) and targ:NameID())
end