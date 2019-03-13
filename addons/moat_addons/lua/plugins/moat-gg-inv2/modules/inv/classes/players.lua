--
-- Networked Player Data
--

local PLAYER = FindMetaTable "Player"

mi.Players = mi.Players or {}
mi.OldStats = mi.OldStats or {}

function mi:NewPlayers(id, dt, name, def, old)
	self.Players[id] = self.Players[id] or {
		Name = name,
		Type = dt,
		Old = old,
		Default = def or 0,
		Data = setmetatable({},	{
			__index = function(self, k)
				if (CLIENT) then
					net.SendPlayer('mi.PlayersDispatch', k, function()
						net.WriteByte(id)
					end, net.SendToServer)
				end

				rawset(self, k, def or 0)

				return self[k]
			end
		})
	}

	mi.OldStats[old] = id
	setmetatable(self.Players[id], smt)

	PLAYER["Get" .. name] = function(s)
		return mi.Players[id].Data[s]
	end
	PLAYER["Set" .. name] = function(p, n)
		mi.Players[id].Data[p] = n

		if (SERVER) then
			p:SaveData(id, dt == 'num' and tonumber(n) or nil, dt == 'str' and tostring(n) or nil, function()
				net.Start "mi.PlayersDispatch"
					net.WritePlayer(p)
					net.WriteByte(id)

					if (type == 'num') then
						net.WriteUInt(p["Get" .. name](p), 32)
					elseif (type == 'str') then
						net.WriteString(p["Get" .. name](p))
					end

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
	PLAYER["SetData" .. id] = function(s, n)
		mi.Players[id].Data[s] = n
	end
end