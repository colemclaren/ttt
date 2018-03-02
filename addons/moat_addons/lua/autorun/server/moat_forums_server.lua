util.AddNetworkString("moat.forums.check")
util.AddNetworkString("moat.forums.success")

MOAT_FORUMS = MOAT_FORUMS or {}
MOAT_FORUMS.Cmds = {
	["!forums"] = true,
	["/forums"] = true,
	["!forum"] = true,
	["/forum"] = true
}
function MOAT_FORUMS.Query(str, cb)
	local q = MINVENTORY_MYSQL:query(str)
	
	function q:onSuccess(d)
		cb(d)
	end
	
	q:start()
end

function MOAT_FORUMS.GiveReward(pl)
	if (not IsValid(pl)) then return end

	net.Start("moat.forums.success")
	net.WriteEntity(pl)
	net.Broadcast()

	pl:m_GiveIC(2500)
	pl:ConCommand("moat_forum_rewards 1")
end

function MOAT_FORUMS:CheckIPB(pl)
	if (not IsValid(pl)) then return end
	
	self.Query("SELECT steamid FROM core_members WHERE steamid='" .. pl:SteamID64() .. "'", function(d)
		if (d and #d > 0) then
			if (not IsValid(pl)) then return end

			self.Query("INSERT INTO moat_forums (id, num) VALUES ('" .. pl:SteamID64() .. "', 1)", function(d)
				self.GiveReward(pl)
			end)
		else
			pl:SendLua("chat.AddText(Color(255, 0, 0), 'Failed to verify forum membership. Click the Open button to sign up!')")
		end
	end)
end

function MOAT_FORUMS:Check(pl)
	self.Query("SELECT num FROM moat_forums WHERE id='" .. pl:SteamID64() .. "'", function(d)
		if (d and #d > 0) then 
			pl:SendLua([[chat.AddText(Color(255, 0, 0), "You've already received your reward for joining the forums!")]])
			pl:SendLua([[if (IsValid(MOAT_FORUMS.BG)) then MOAT_FORUMS.BG:Remove() end LocalPlayer():ConCommand("moat_forum_rewards 1")]])
			return
		end

		self:CheckIPB(pl)
	end)
end

function MOAT_FORUMS.CheckUser(_, pl)
	if (pl.forum_check and pl.forum_check > CurTime()) then return end
	MOAT_FORUMS:Check(pl)

	pl.forum_check = CurTime() + 5
end

net.Receive("moat.forums.check", MOAT_FORUMS.CheckUser)

function MOAT_FORUMS.ChatCommand(pl, txt)
	if (MOAT_FORUMS.Cmds[txt]) then pl:ConCommand("moat_forums") end
end

hook.Add("PlayerSay", "moat.forums.chat", MOAT_FORUMS.ChatCommand)