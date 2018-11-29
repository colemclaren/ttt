local color_dead = Color(255, 30, 40)
local color_team = Color(30, 160, 40)
local color_white = Color(255, 255, 255)
local color_detective = Color(50, 200, 255)

local function OnPlayerChat(gm, pl, str, isteam, isdead, ignore_block)
	local t, n, ValidPlayer, Dead = {}, 1, IsValid(pl), false

	if (ValidPlayer) then
		Dead = pl:Team() == TEAM_SPEC

		if (ignore_block) then
			ignore_block = pl:Nick()
		end
	end

	str = string.Replace(str, "/tableflip", [[(╯°□°）╯︵ ┻━┻]])
	str = string.Replace(str, "/unflip", [[┬─┬ノ( º _ ºノ)]])
	str = string.Replace(str, "/shrug", [[¯\_(ツ)_/¯]])

	-- PrePlayerChat should be used instead of OnPlayerChat
	-- return true to supress message
	if (hook.Run("PrePlayerChat", ignore_block or pl, str, isteam, isdead or Dead, ValidPlayer)) then
		return
	end

	if (isdead or (ValidPlayer and Dead)) then
		t, n = {color_dead, "*DEAD* "}, n + 2
	end

	if (isteam and (ValidPlayer and pl:IsActiveSpecial())) then
		t[n], t[n + 1], n = color_team, "(TEAM) ", n + 2
	end

	if (ValidPlayer) then
		if (pl:IsActiveDetective()) then
			t[n], n = color_detective, n + 1
		end

		t[n], n = nick or pl, n + 1
	else
		t[n], n = "Console", n + 1
	end

	t[n], t[n + 1] = color_white, string (": ", str)

	chat.AddText(unpack(t))

	return true
end

local function HandleTTTRadio(gm)
	local pl = net.ReadEntity()
	if (not IsValid(pl)) then
		return
	end

	local msg = net.ReadString()
	if (not msg) then
		return
	end

	local param = net.ReadString()
	if (not param) then
		return
	end

	if (not LANG) then
		return
	end

	hook.Run("PlayerSentRadioCommand", pl, msg, param)

	local lang_param = LANG.GetNameParam(param)
	if (lang_param) then
		param = lang_param == "quick_corpse_id" and LANG.GetParamTranslation(lang_param, {
			player = net.ReadString() or "Someone"
		}) or LANG.GetTranslation(lang_param)
	end

	local text = LANG.GetParamTranslation(msg, {player = param})
	if (lang_param) then
		text = util.Capitalize(text)
	end

	PlayerChat(pl, text, true)
end

local function Detour(gm)
	gm._OnPlayerChat = gm._OnPlayerChat or gm.OnPlayerChat
	gm.OnPlayerChat = OnPlayerChat

	function PlayerChat(pl, msg, ignore_block)
		return OnPlayerChat(gm, pl, msg, nil, nil, ignore_block)
	end

	net.Receive("TTT_RadioMsg", function()
		HandleTTTRadio(gm)
	end)
end

local GM = GM or GAMEMODE or gmod.GetGamemode()
if (not GM) then
	hook("Initialize", function()
		Detour(GM or GAMEMODE or gmod.GetGamemode())
	end)
else
	Detour(GM)
end