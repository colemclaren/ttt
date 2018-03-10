DOCTOR_ALREADY_REVIVED = false

hook.Add("TTTBeginRound", "terror.city.revived", function() DOCTOR_ALREADY_REVIVED = false end)
net.Receive("terrorcity.doctor", function()
	DOCTOR_ALREADY_REVIVED = true
	RemoveSearchScreen()
end)