if SERVER then
	util.AddNetworkString('moatNotifyMeticulous')
	return
end

net.Receive('moatNotifyMeticulous', function(len)
	chat.AddText(Color( 205, 127, 50 ), 'Through the power of your weapon, you have refilled your entire clip!' )
end)