REWARDS.Theme = {}
--
-- STEAM Rewards Theme
--

REWARDS.Theme.WindowColor = Color(26, 30, 38, 255) --Main window color

REWARDS.Theme.Logo = Material("modernrewards/steamlogo1.png") --Banner logo material
REWARDS.Theme.LogoColor = Color(255, 255, 255, 185) --Banner logo color, default is white
REWARDS.Theme.Font = "Trebuchet24" --Font used for text

REWARDS.Theme.MessageBoxBackColor = Color(51 ,102 ,255 ,255) --Message box back color
REWARDS.Theme.MessageBoxJoinCheckBackColor = Color(51 ,102 ,255 ,255) --Back color when checking
REWARDS.Theme.MessageBoxJoinBarColor = Color(77 ,255 ,121 ,255) --Color of checking progress bar
REWARDS.Theme.MessageBoxSuccessBackColor = Color(77 ,255 ,121 ,255) --Back color when successful
REWARDS.Theme.SuccessColorEffect = true --Color effect when successful

REWARDS.Theme.ButtonColor = Color( 153,0,153 ) --Back color of buttons
REWARDS.Theme.ButtonHoverColor = Color(255,77,77 ) --Hover color of buttons

REWARDS.Theme.NoticePrefixColor = Color(51,255,102) --Chat text color of notice prefix
REWARDS.Theme.NoticeTextColor = Color(51,102,255) --Chat text color of notices

REWARDS.Settings = {}
--
-- STEAM Rewards Addon Settings
--
--Link to your Steam Group page, simply open your group page in Steam and copy the link
REWARDS.Settings.SteamGroupPage = "https://steamcommunity.com/groups/moatgaming"
--Name of your Steam Group, used for checking, this name is the last part of the link
 -- e.g. for steamcommunity.com/groups/Facepunch it's just Facepunch
REWARDS.Settings.GroupName = "Moat Gaming"
REWARDS.Settings.ShowOnPlayerConnect = true --Open steam rewards when players not in group connect
REWARDS.Settings.AutoCloseTime = 300 --Auto close steam rewards after certain time (seconds)
REWARDS.Settings.SuccessCloseTime = 0 --Auto close steam rewards after success (seconds)
REWARDS.Settings.PlaySounds = false --Play the menu sounds?
REWARDS.Settings.SuccessSound = "modernrewards/success.wav" --Success sound effect
--Change chat command to "" to disable the chat command
REWARDS.ChatCommand = "!steam"
REWARDS.NoticePrefix = "[STEAM REWARDS]" --Chat notification prefix
REWARDS.JoinButtonText = "Join Steam Group" --Text on join button
REWARDS.DontJoinButtonText = "Not Now, Thanks" --Text on don't join (Close) button
--Message box text (e.g. explain the rewards of joining your group)
REWARDS.Settings.RewardsMessage = "Join our steam group and receive 2,500\n inventory credits!"
--Message box text on success (e.g. explain what rewards we're given)
REWARDS.Settings.RewardsSuccessMessage = "Thanks for joining the group! You have received your inventory credits! Press I to open your inventory!"
--Message box text on check (e.g. explain that a check is happening)
REWARDS.Settings.RewardsJoinCheckMessage = "Checking Steam Group Membership..."
--Chat message shown to players when a new user joins the steam group. Player name will be shown before the message
REWARDS.Settings.EnableChatNotification = true	
REWARDS.Settings.RewardsChatMessage = " joined our steam group and received 2,500 IC!"
--You can set the FKeyShowCursor to F1,F2,F3 or F4 and change to "" to disable FKeyShowCursor
REWARDS.Settings.FKeyShowCursor = "F2" --Useful for gamemodes with no cursor key
--Delay before check after player presses join button (we recommend at least 30 seconds)
REWARDS.Settings.JoinCheckDelay = 25
REWARDS.Settings.CloseAfterDelayAndNotInGroup = true --Close after check and player not in group?


--
-- STEAM Rewards - Reward Settings
--
--You can enable or disable multiple types of rewards and they will all be given to
--the player as a reward for joining the group. The rewards are given once only.
REWARDS.Settings.DarkRPCashReward = 0 --DarkRP Cash Reward (Set to 0 to disable)
REWARDS.Settings.PointshopReward = 0 --Pointshop Points Reward (Set to 0 to disable)
--Pointshop Item Reward (you need the itemid, that's the name of the item lua file)
--You can add multiple items by adding a comma and another item name e.g. {"ninjaturtle","texthat"}
REWARDS.Settings.PointshopItemReward = {} --Change to {} to disable
--TTT Karma Reward, Karma is applied at the next round start and won't go above the max karma setting
REWARDS.Settings.TTTKarmaReward = 0 -- (Set to 0 to disable)
--Set ULX Group as a reward. e.g. you could set a "vip" or "donator" rank
--The rank will not be applied if they already have a higher rank than default
REWARDS.Settings.ULXGroup = "" --Change to "" to disable
--Pointshop2 standard and premium/donator point rewards (Set to 0 to disable)
REWARDS.Settings.Pointshop2StandardPoints = 0
REWARDS.Settings.Pointshop2PremiumPoints = 0
--Pointshop2 item reward. (You need the item name as it displays in the menu e.g. "Top Hat")
--You can add multiple items by adding a comma and another item name e.g. {"Hotdog Hat","Monocle"}
REWARDS.Settings.Pointshop2Item = {} --Change to {} to disable

--Custom Reward Function
--Developers can also add a custom reward function, this will be called
--when a successful reward is being applied to a player.
--Example
REWARDS.Settings.CustomRewardFunction = function(ply)
	timer.Simple(2, function()
		ply:m_GiveIC(2500)
	end)
end