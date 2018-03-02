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
	
	D3A.Chat.Broadcast2(moat_cyan, pl:Name(), moat_white, " has frozen everything.")
end