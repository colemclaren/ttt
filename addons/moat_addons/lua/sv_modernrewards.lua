--REWARDS Rewards Server Dist (Converted to use MYSQL with mysqloo module)
if REWARDS then REWARDS = REWARDS
else REWARDS = {} end
include('sh_rewardsconfig.lua')
include('sv_rewardsdata.lua')
require('gxml')
util.AddNetworkString("REWARDS_Notify")

function REWARDS.PlayerInitialSpawnCallback(ply, rewarded)
	ply.SteamGroupRewarded = rewarded
	if REWARDS.Settings.ShowOnPlayerConnect and !ply.SteamGroupRewarded then
		REWARDS.CheckPlayerSteamGroup(ply, REWARDS.Settings.GroupName, function(ply)
			if not IsValid(ply) then return end
			if ply.IsInSteamGroup then
				REWARDS.ApplyPlayerReward(ply)
			else
				if REWARDS.Settings.ShowOnPlayerConnect then
					umsg.Start("REWARDS_Open", ply)
						if REWARDS.Settings.AutoCloseTime and 
						REWARDS.Settings.AutoCloseTime > 0 then
							umsg.Long(REWARDS.Settings.AutoCloseTime)
						end
					umsg.End()
				end
			end
		end)
	end
end

function REWARDS.PlayerInitialSpawn(ply)
	REWARDS.Database.IsInGroup(ply, REWARDS.PlayerInitialSpawnCallback)
end
hook.Add( "PlayerInitialSpawn", "REWARDS_PlayerInitialSpawn", REWARDS.PlayerInitialSpawn )

function REWARDS.PlayerAttemptJoin(ply, cmd, args)
if not IsValid(ply) then return end
timer.Simple(REWARDS.Settings.JoinCheckDelay or 30, function()
	if not IsValid(ply) then return end	
		REWARDS.CheckPlayerSteamGroup(ply, REWARDS.Settings.GroupName, function(ply)
			if ply.IsInSteamGroup then
				REWARDS.ApplyPlayerReward(ply)
			else
				if REWARDS.Settings.CloseAfterDelayAndNotInGroup then
					SendUserMessage("REWARDS_Close", ply)
				end			
			end
		end)
	end)
end
concommand.Add("rewards_joinsteam", REWARDS.PlayerAttemptJoin)

function REWARDS.ApplyPlayerReward(ply)
	if not IsValid(ply) or ply.SteamGroupRewarded then SendUserMessage("REWARDS_Close", ply) return end
	REWARDS.Database.GroupJoin(ply)
	ply.SteamGroupRewarded = true
	SendUserMessage("REWARDS_Success", ply)
	--Check DarkRP Reward
	if GAMEMODE.Config and REWARDS.Settings.DarkRPCashReward and REWARDS.Settings.DarkRPCashReward > 0 then
		if ply.AddMoney then ply:AddMoney(REWARDS.Settings.DarkRPCashReward)
		elseif ply.addMoney then ply:addMoney(REWARDS.Settings.DarkRPCashReward) end
	end
	--Check Pointshop Reward
	if PS and REWARDS.Settings.PointshopReward and REWARDS.Settings.PointshopReward > 0 then
		timer.Simple(2, function()
		if not IsValid(ply) then return end
		ply:PS_GivePoints(REWARDS.Settings.PointshopReward)
		end)
	end
	--Check Pointshop Item Reward
	if PS and REWARDS.Settings.PointshopItemReward and REWARDS.Settings.PointshopItemReward != "" then
		timer.Simple(2, function()
		if not IsValid(ply) then return end
			if isstring(REWARDS.Settings.PointshopItemReward) then ply:PS_GiveItem(REWARDS.Settings.PointshopItemReward) return
			elseif istable(REWARDS.Settings.PointshopItemReward) then
				for k,v in pairs(REWARDS.Settings.PointshopItemReward) do
					ply:PS_GiveItem(v)
				end
			end			
		end)
	end
	--Check TTT Karma Reward
	if KARMA and REWARDS.Settings.TTTKarmaReward and REWARDS.Settings.TTTKarmaReward > 0 then
		local config = KARMA.cv
		ply:SetLiveKarma(math.min(ply:GetLiveKarma() + REWARDS.Settings.TTTKarmaReward, config.max:GetFloat()))
	end
	--Check ULX Group Reward
	if ulx and REWARDS.Settings.ULXGroup and REWARDS.Settings.ULXGroup != "" then
		if ply:IsUserGroup("user") then ulx.adduser( ply, ply, REWARDS.Settings.ULXGroup ) end
	end
	--Check Pointshop2 Rewards
	if Pointshop2 then
		timer.Simple(2, function()
			if REWARDS.Settings.Pointshop2StandardPoints and REWARDS.Settings.Pointshop2StandardPoints > 0 then
				ply:PS2_AddStandardPoints(REWARDS.Settings.Pointshop2StandardPoints)
			end
			if REWARDS.Settings.Pointshop2PremiumPoints and REWARDS.Settings.Pointshop2PremiumPoints > 0 then
				ply:PS2_AddPremiumPoints(REWARDS.Settings.Pointshop2PremiumPoints)
			end
			if REWARDS.Settings.Pointshop2Item and #REWARDS.Settings.Pointshop2Item > 0 then
				for k,v in pairs(REWARDS.Settings.Pointshop2Item) do
						local itemClass
						for _, class in pairs(KInventory.Items) do
							if class.PrintName and string.lower(class.PrintName) == string.lower(v) then
								itemClass = class
								break
							end
						end       
					if not itemClass then ErrorNoHalt( "STEAM REWARDS: Invalid Pointshop2 item name: " .. tostring(v)) continue end
					ply:PS2_EasyAddItem( itemClass.className,{ time = os.time(), amount = itemClass.Price.points and itemClass.Price.points or itemClass.Price.premiumPoints, currency = itemClass.Price.points and "points" or "premiumPoints",origin="STEAMGROUP_REWARDS"},true )
				end
			end
		end)
	end

	--Run custom reward function
	if REWARDS.Settings.CustomRewardFunction then
		REWARDS.Settings.CustomRewardFunction(ply)
	end
	
	--Chat notification
	if REWARDS.Settings.EnableChatNotification then
		net.Start("REWARDS_Notify")
			net.WriteEntity(ply)
		net.Send(player.GetAll())
	end
end

function REWARDS.PlayerSay( ply, chattext, pblic )
    if (string.sub(chattext, 1, #chattext) == REWARDS.ChatCommand) then
		SendUserMessage("REWARDS_Open", ply)
    end
end

if REWARDS.ChatCommand and REWARDS.ChatCommand != "" then
	hook.Add( "PlayerSay", "REWARDS_PlayerSay", REWARDS.PlayerSay );
end

function REWARDS.CheckPlayerSteamGroup(ply, group, callback, link)
	if ply:IsValid() then
	http.Fetch( link or string.format("http://steamcommunity.com/groups/%s/memberslistxml/?xml=1&c=%i",group,CurTime()),
	function(body,len,headers,code)
	if code==200 then
		local results = XMLToTable(body)
		if not results or not results.memberList or not results.memberList.members or not results.memberList.members.steamID64 then if callback then callback(ply) end return end
		for k,v in pairs(results.memberList.members.steamID64) do
			if (v == ply:SteamID64()) then ply.IsInSteamGroup = true break end
		end
		if results.memberList.nextPageLink and !ply.IsInSteamGroup then REWARDS.CheckPlayerSteamGroup(ply, group, callback, results.memberList.nextPageLink..string.format("&c=",CurTime())) return end
		if callback then callback(ply) end
	else
		print(string.format("STEAM REWARDS: The Steam Web API's are down for maintenance. (Code:%i)",code))
	end
	end,
	function(err) print("STEAM REWARDS: An error occured: "..err) end)
	end
end

function REWARDS.ResetRewards(ply, cmd, args)
	if ply:IsSuperAdmin() or ply:EntIndex() == 0 then --Superadmins or RCON only to run this command
	if args and args[1] then
		local steamid = util.SteamIDTo64(args[1])
		REWARDS.Database.GroupLeave(steamid)
		if ply:EntIndex() == 0 then
			print("Steam group rewards reset for: " .. args[1])
		else
			ply:ChatPrint("Steam group rewards reset for: " .. args[1])
			print("STEAM REWARDS: Steam group rewards reset for: " .. args[1])
		end
		local resetply = player.GetBySteamID64( steamid )
		if resetply then ply.SteamGroupRewarded = false end
	else
		REWARDS.Database.ClearAllRecords()
		for k,v in pairs(player.GetAll()) do
			v.SteamGroupRewarded = false
		end
		if ply:EntIndex() == 0 then
			print("Steam group rewards reset successfully.")
		else
			ply:ChatPrint("Steam group rewards reset successfully.")
			print("STEAM REWARDS: Steam group rewards reset successfully.")
		end
	end
	end
end
concommand.Add("rewards_reset", REWARDS.ResetRewards)

local function FindGroupNameFromURL()
	local parts = string.Explode( "/" , REWARDS.Settings.SteamGroupPage )
	if (parts[#parts] == "" or parts[#parts]:len() < 3 or #parts < 2) then
		return (parts[#parts - 1])
	else return (parts[#parts]) end
end
REWARDS.Settings.GroupName = FindGroupNameFromURL()