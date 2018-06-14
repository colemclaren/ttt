util.AddNetworkString "REWARDS_Notify"
util.AddNetworkString "REWARDS_OpenMenu"
util.AddNetworkString "REWARDS_CheckNewPlayer"

MOAT_STEAMREWARDS = {}

function MOAT_STEAMREWARDS.RewardPlayer(pl)
	if (not IsValid(pl)) then return end
	if (pl.LastSteamCheck and pl.LastSteamCheck > CurTime()) then 
		D3A.Chat.SendToPlayer2(pl, "Please wait..")
		return 
	end

	pl.LastSteamCheck = CurTime() + 5

	MOAT_RCON:Query("SELECT value FROM steam_rewards WHERE steam = #;", pl:SteamID64(), function(r)
		if (not r or not r[1]) then
			D3A.Chat.SendToPlayer2(pl, Color(255, 0, 0), "Couldn't find you in the steam group? Try running the !steam command again.")
			-- couldnt find you in group, run command again
			return
		end

		if (not IsValid(pl)) then return end
		local rewarded = tonumber(r[1].value)
		if (rewarded == 1) then
			D3A.Chat.SendToPlayer2(pl, Color(255, 0, 0), "We've already rewarded you for being in the steam group!")
			return
		end

		if (not MOAT_INVS[pl] or not MOAT_INVS[pl]["credits"]) then
			D3A.Chat.SendToPlayer2(pl, Color(255, 0, 0), "We couldn't reward you because your inventory hasn't loaded. Try again later.")
			return
		end

		net.Start "REWARDS_Notify"
			net.WriteEntity(pl)
		net.Broadcast()

		m_AddCreditsToSteamID(pl:SteamID(), 2500)
		MOAT_RCON:Query("UPDATE steam_rewards SET value = 1 WHERE steam = #;", pl:SteamID64())
	end)
end

concommand.Add("steam", MOAT_STEAMREWARDS.RewardPlayer)
net.Receive("REWARDS_CheckNewPlayer", function(l, pl)
	MOAT_STEAMREWARDS.RewardPlayer(pl)
end)

function MOAT_STEAMREWARDS.PlayerSay(pl, chattext, pblic)
    if (chattext == "!steam" or chattext == "/steam") then
		net.Start("REWARDS_OpenMenu")
		net.Send(pl)
    end
end
hook.Add("PlayerSay", "MOAT_STEAMREWARDS.PlayerSay", MOAT_STEAMREWARDS.PlayerSay)

hook.Add("SQLConnected", "SteamGroupSQL", function(db)
    print("Steam Group Rewards: MySQL connection successful.")
    --REWARDS.MySQLQuery("CREATE TABLE IF NOT EXISTS steam_rewards(steam char(20) NOT NULL, value INTEGER NOT NULL, PRIMARY KEY(steam));")
end)