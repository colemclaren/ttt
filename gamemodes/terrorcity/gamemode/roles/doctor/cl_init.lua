DOCTOR_ALREADY_REVIVED = false

function ROLE:TTTBeginRound()
	DOCTOR_ALREADY_REVIVED = false
end

net.Receive("terrorcity.doctor", function()
	DOCTOR_ALREADY_REVIVED = true
	RemoveSearchScreen()
end)