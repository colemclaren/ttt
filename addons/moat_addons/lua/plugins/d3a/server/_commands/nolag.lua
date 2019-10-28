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
	
	D3A.Chat.Broadcast2(pl, moat_cyan, D3A.Commands.Name(pl), moat_white, " has frozen everything.")
	D3A.Commands.Discord("nolag", D3A.Commands.NameID(pl))
end