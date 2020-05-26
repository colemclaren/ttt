D3A.Chat = {}

D3A.Chat.TypeColors = {}
	D3A.Chat.TypeColors["ERR"] = Color(255, 100, 100, 255)
	D3A.Chat.TypeColors["CONDISCON"] = Color(100, 255, 100, 255)

D3A.Chat.White = Color(255, 255, 255)
D3A.Chat.Blue = Color(0, 0, 255)
D3A.Chat.Red = Color(255, 0, 0)
	
local gold = Color(255, 200, 0);
local white = Color(255, 255, 255);

function D3A.Chat.Add(Text, Col, Snd)
	Text = string.Explode("\n", Text) or {"Text not found"}
	Col = Col or Color(200, 200, 200, 255)

	for k, v in pairs(Text) do
		chat.AddText(moat_blue, "| ", Col, v)
	end
end

net.Receive("D3A.Chat", function(len)
	local Text = net.ReadString()
	local Type = net.ReadString()

	local Col = D3A.Chat.TypeColors[Type] or nil

	D3A.Chat.Add(Text, Col)
end)

net.Receive("D3A.Chat2", function(len)
	if (net.ReadBool()) then
		local instigator = net.ReadEntity()
		if (IsValid(instigator) and cookie.GetNumber("moat_block"..instigator:SteamID(), 0) == 1) then
			return
		end
	end

	local Table = net.ReadTable()

	chat.AddText(moat_blue, "| ", moat_white, unpack(Table))
end)

net.Receive("D3A.AdminChat", function(len)
	local isAdmin = tobool(net.ReadString())
	local name = net.ReadString()
	local text = net.ReadString()

	chat.AddText(moat_blue, "| ", (isAdmin and Color(255, 0, 255)) or Color(255, 50, 255), ((isAdmin and "[STAFF] ") or "[TO STAFF] "), moat_cyan, name .. ": ", Color(0, 255, 0), text)
end)

hook.Add("ChatText", "D3A.Chat.SuppressChatText", function(plInd, plName, Text, Type)
	if (Type == "joinleave") then return true end
end)