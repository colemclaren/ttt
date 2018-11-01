-- Register networked DataVars here
D3A.NW.Register "rank"
	:Write(function(v)
		net.WriteString(v.Name)
		net.WriteUInt(v.Weight, 8)
		net.WriteString(v.FlagsString)
	end)
	:Read(function()
		local t = {
			Name = net.ReadString(),
			Weight = net.ReadUInt(8),
			Flags = {}
		}
		local flags = net.ReadString()
		for i = 1, #flags do
			t.Flags[flags[i]] = true
		end
		return t
	end)
	:SetPlayer()


D3A.NW.Register "joinTime"
	:Write(net.WriteUInt, 32)
	:Read(net.ReadUInt, 32)
	:SetPlayer()

D3A.NW.Register "lastTimeSave"
	:Write(net.WriteUInt, 32)
	:Read(net.ReadUInt, 32)
	:SetPlayer()
	
D3A.NW.Register "timePlayed"
	:Write(net.WriteUInt, 32)
	:Read(net.ReadUInt, 32)
	:SetPlayer()

D3A.NW.Register "adminmode"
	:Write(net.WriteBool)
	:Read(net.ReadBool)
	:SetPlayer()

D3A.NW.Register "IC"
	:Write(net.WriteDouble)
	:Read(net.ReadDouble)
	:SetPlayer()

D3A.NW.Register "EC"
	:Write(net.WriteUInt, 16)
	:Read(net.ReadUInt, 16)
	:SetPlayer()

D3A.NW.Register "SC"
	:Write(net.WriteUInt, 32)
	:Read(net.ReadUInt, 32)
	:SetPlayer()

D3A.NW.Register "rank_expire"
	:Write(net.WriteUInt, 32)
	:Read(net.ReadUInt, 32)
	:SetPlayer()

D3A.NW.Register "rank_expire_to"
	:Write(net.WriteString)
	:Read(net.ReadString)
	:SetPlayer()