local plyMeta = FindMetaTable('Player')

function plyMeta:canBeMoatFrozen()
	return (IsValid(self) && self:Team() != TEAM_SPEC && not MOAT_MINIGAME_OCCURING && GetRoundState() == ROUND_ACTIVE)
end

if (CLIENT) then
	net.Receive('moatFrozenNotification', function(len)
		local notificationMessage = 'You have been frostbitten! You feel yourself slowing down, and it hurts!'
		local notificationColor = Color(245, 245, 255)
		
		chat.AddText(notificationColor, notificationMessage)
	end)
end