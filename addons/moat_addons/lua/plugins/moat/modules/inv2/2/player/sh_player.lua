local PLAYER = FindMetaTable "Player"
if (SERVER) then
	util.AddNetworkString "mi.Stats.Dispatch"
end

mi.Stats = mi.Stats or {}

net.Receive("mi.Stats.Dispatch", function(_, p)
	local pl = net.ReadEntity()
	local chr = string.char(net.ReadByte())
	if (not mi.Stats[chr]) then
		p:Kick("No "..chr)
	end
	local name = mi.Stats[chr].name
	if (SERVER) then
		if (not IsValid(pl)) then return end

		net.Start "mi.Stats.Dispatch"
			net.WriteEntity(pl)
			net.WriteUInt(pl["Get" .. name](), 32)
		net.Send(p)
	else
		if (not IsValid(pl)) then return end
		pl["Set" .. name](net.ReadUInt(32))
	end
end)

function mi:GetStatName(statid)
	return self.Stats[statid].name
end

function mi:RegisterStat(char, name, def)
	self.Stats[char] = self.Stats[char] or {
		name = name,
		ply_data = setmetatable({},	{
			__index = function(self, k)
				if (CLIENT) then
					net.Start "mi.Stats.Dispatch"
						net.WriteEntity(k)
						net.WriteByte(char:byte(1, 1))
					net.SendToServer()
				end
				rawset(self, k, def or 0)
				return self[k]
			end
		})
	}

	local pls = self.Stats[char].ply_data

	setmetatable(self.Stats[char], smt)

	PLAYER["Get" .. name] = function(s)
		return pls[s]
	end
	PLAYER["Set" .. name] = function(s, n)
		pls[s] = n

		if (SERVER) then
			self:SaveStat(s, char, n, function()
				net.Start "mi.Stats.Dispatch"
					net.WriteEntity(s)
					net.WriteByte(char:byte(1, 1))
					net.WriteUInt(s["Get" .. name](s), 32)
				net.Broadcast()
			end)
		end
	end
	PLAYER["Add" .. name] = function(s, n)
		s["Set" .. name](s, s["Get" .. name](s) + (n or 1))
	end
	PLAYER["Take" .. name] = function(s, n)
		s["Set" .. name](s, s["Get" .. name](s) - (n or 1))
	end
	PLAYER["Has" .. name] = function(s, n)
		return s["Get" .. name](s) <= n
	end
	PLAYER["SetStat" .. char] = function(s, n)
		pls[s] = n
	end
end

mi:RegisterStat("k", "Kills")
mi:RegisterStat("x", "XP")
mi:RegisterStat("d", "Deaths")
mi:RegisterStat("o", "Drops")
mi:RegisterStat("l", "Level", 1)
mi:RegisterStat("r", "Deconstructs")
mi:RegisterStat("c", "IC")