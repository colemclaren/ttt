COMMAND.Name = "NoLag"
COMMAND.Flag = D3A.Config.Commands.NoLag

COMMAND.Run = function(pl, args, supp)
	for k, v in ipairs(ents.GetAll()) do
        if IsValid(v) then
            local phys = v:GetPhysicsObject()
            if IsValid(phys) then
                phys:EnableMotion(false)
            end
            constraint.RemoveAll(v)
        end
    end
	
	D3A.Chat.Broadcast2(pl, moat_cyan, pl:Name(), moat_white, " has frozen everything.")
	D3A.Commands.Discord("nolag", (((pl and pl.rcon) or IsValid(pl)) and pl:NameID()) or D3A.Console)
end