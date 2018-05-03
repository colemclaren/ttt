local PLAYER = FindMetaTable "Player"

MOAT_INV.Stats = MOAT_INV.Stats or {}
MOAT_INV.Stats.n = 1

function MOAT_INV:RegisterStat(id, name, def)
	local char = MOAT_INV.Stats.n
	local netid = "MOAT_INV.Stats." .. char
	if (SERVER) then util.AddNetworkString(netid) end

	local smt = {
		__index = function(s)
			return s["default"]
		end
	}

	self.Stats[char] = {
		["default"] = def or 0,
		["char"] = id
	}
	setmetatable(self.Stats[char], smt)

	PLAYER["Get" .. name] = function(s)
		return self.Stats[char][s]
	end
	PLAYER["Set" .. name] = function(s, n)
		self.Stats[char][s] = math.max(0, math.floor(n))

		if (SERVER) then
			self:SaveStat(s:ID(), id, self.Stats[char][s], function()
				net.Start(netid)
					net.WriteEntity(s)
					net.WriteUInt(s["Get" .. name](), 32)
				net.Broadcast()
			end)
		end
	end
	PLAYER["Add" .. name] = function(s, n)
		n = n or 1
		s["Set" .. name](s["Get" .. name]() + n)
	end
	PLAYER["Take" .. name] = function(s, n)
		n = n or 1
		s["Set" .. name](s["Get" .. name]() - n)
	end
	PLAYER["Has" .. name] = function(s, n)
		return s["Get" .. name]() <= n
	end
	PLAYER["SetStat" .. name] = function(s, n)
		s["Set" .. name](n)
	end

	MOAT_INV.Stats.n = MOAT_INV.Stats.n + 1
	if (SERVER) then return end
	net.Receive(netid, function()
		local pl = net.ReadEntity()
		if (not IsValid(pl)) then return end
		pl["Set" .. name] = net.ReadUInt(32)
	end)
end

MOAT_INV:RegisterStat("k", "Kills")
MOAT_INV:RegisterStat("x", "XP")
MOAT_INV:RegisterStat("d", "Deaths")
MOAT_INV:RegisterStat("o", "Drops")
MOAT_INV:RegisterStat("l", "Level", 1)
MOAT_INV:RegisterStat("r", "Deconstructs")
MOAT_INV:RegisterStat("c", "IC")

hook.Run "MOAT_INV.StatsRegistered"