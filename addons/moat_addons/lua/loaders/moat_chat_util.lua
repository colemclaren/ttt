if (SERVER) then
	util.AddNetworkString("moat_chat_msg")

	local pl = FindMetaTable("Player")

	function pl:MoatChat(str)
		net.Start("moat_chat_msg")
		net.WriteString(str)
		net.Send(self)
	end
else
	net.Receive("moat_chat_msg", function(l)
		local str = net.ReadString()

		chat.AddText(Material("icon16/information.png"), Color(255, 0, 0), str)
	end)
end