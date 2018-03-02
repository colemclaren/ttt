if SERVER then
	util.AddNetworkString('moatNotifyMeticulous')
else
	net.Receive('moatFrozenNotification', function(len)
		local notificationMessage = 'You have been frostbitten! You feel yourself slowing down, and it hurts!'
		local notificationColor = Color(245, 245, 255)
		
		chat.AddText(notificationColor, notificationMessage)
	end)
	
	net.Receive('moatFrozenShake', function(len)
		util.ScreenShake(Vector(0, 0, 0), 1, 15, net.ReadInt(32) + 5, 0)
	end)
	
	net.Receive('moatNotifyMeticulous', function(len)
		chat.AddText(Color( 205, 127, 50 ), 'Through the power of your weapon, you have refilled your entire clip!' )
	end)
end