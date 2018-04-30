DOCTOR_ALREADY_REVIVED = false

function ROLE:TTTBeginRound()
	DOCTOR_ALREADY_REVIVED = false
	for k,v in pairs(player.GetAll()) do
		v.Doctor_CannotRevive = false
	end
end

net.Receive("terrorcity.doctor", function()
	local t = net.ReadUInt(3)
	if (t == 0) then
		DOCTOR_ALREADY_REVIVED = true
		RemoveSearchScreen()
	elseif (t == 1) then
		-- cannot revive
		net.ReadEntity().Doctor_CannotRevive = true
	end
end)