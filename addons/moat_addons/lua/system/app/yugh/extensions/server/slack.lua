local JSONToTable = util.JSONToTable
local post = http.Post
local len = string.len
local sub = string.sub
local log = ServerLog
local MaxLength = 2000 - 50
local PreLoadQueue = {}
local Webhooks = {}
local Users = {}
local ErrorCodes = {
	[400] = "the data sent in your request cannot be understood as presented; verify your content body matches your content type and is structurally valid.",
	[403] = "the team associated with your request has some kind of restriction on the webhook posting in this context.",
	[404] = "the channel associated with your request does not exist.",
	[410] = "the channel has been archived and doesn't accept further messages, even from your incoming webhook.",
	[500] = "something strange and unusual happened that was likely not your fault at all."
}

local function AddChannel(channel, url)
	Webhooks[channel] = url
end

local function AddChannels(tbl)
	for k, v in pairs(tbl) do
		AddChannel(k, v)
	end
end

local function AddUser(channel, user, no_suffix, avatar)
	local name = user and user:gsub("^.", string.upper)

	if (not no_suffix) then
		name = name .. " Bot"
	end

	Users[user] = {Channel = channel, Name = name, Avatar = avatar}
end

local function AddUsers(channel, tbl, no_suffix)
	for _, user in pairs(tbl) do
		AddUser(channel, user, no_suffix)
	end
end

local function ErrorCode(code, msg)
	log("Slack http error code " .. (code or "unknown") .. ": " .. (ErrorCodes[code] or ""))
	log "\n"

	if (msg) then
		log(msg)
		log "\n"
	end

	return false
end

local function PostSuccess(body, length, headers, code)
	code = ErrorCodes[code]
	if (code) then
		return ErrorCode(code, body)
	end

	return true
end

local function Send(user, msg, userName, no_suffix)
	assert(user and (Users[user] or Webhooks[user]), "Slack failed to send webhook.")

	msg = string.gsub(msg, "(@everyone)", "everyone")
	msg = string.gsub(msg, "(@here)", "here")

	if (not http or not http.Loaded) then
		table.insert(PreLoadQueue, {
			User = user,
			Message = msg,
			UserName = userName,
			NoSuffix = no_suffix
		})

		return
	end

	local Info, URL, Name, Avatar = Users[user]
	if (Info) then
		URL = Webhooks[Info.Channel]
		Name = Info.Name
		Avatar = Info.Avatar
	else
		AddUser(user, userName or user, no_suffix)
		return Send(user, msg)
	end

	assert(URL and msg, "Slack failed to get webhook URL or msg.")

	if (len(msg) > MaxLength) then
		msg = sub(msg, 1, MaxLength)
	end

	if (Server and Server.IsDev) then
		-- URL = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp"
	end

	HTTP({
		url = URL,
		method = 'POST',
		headers = {
			['Content-Type'] = 'application/json'
		},
		body = util.TableToJSON {
			['text'] = msg,
			['blocks'] = {
				{
					['type'] = 'section',
					['text'] = {
						['type'] = 'mrkdwn',
						['text'] = msg
					}
				}
			}
		},
		success = PostSuccess,
		failed = ErrorCode
	})
end

local function Embed(user, msg, userName, no_suffix, fields)
	assert(user and (Users[user] or Webhooks[user]), "Slack failed to send webhook.")

	if (msg.pretext) then
		msg.pretext = string.gsub(msg.pretext, "(@everyone)", "everyone")
		msg.pretext = string.gsub(msg.pretext, "(@here)", "here")
	end

	-- Since the embeds are in tables we will need to check everything manually before sending

	local Info, URL, Name, Avatar = Users[user]
	if (Info) then
		URL = Webhooks[Info.Channel]
		Name = Info.Name
		Avatar = Info.Avatar
	else
		AddUser(user, userName or user, no_suffix)
		return Embed(user, msg)
	end

	assert(URL and msg, "Discord failed to get webhook URL or msg.")

	-- if (len(msg) > MaxLength) then
	-- 	msg = sub(msg, 1, MaxLength)
	-- end
	-- Since the embeds are in tables we will need to check everything manually before sending

	if (Server and Server.IsDev) then
		URL = "https://discord.moat.gg/api/webhooks/638361841281531905/rivDFMUI6od10U2fcTj_U7tf6wDic7w81HhV-7RM_jNsiEuQ4Un9-tL3Y5ROZFCM7csp"
	end

	HTTP({
		url = URL,
		method = 'POST',
		headers = {
			['Content-Type'] = 'application/json'
		},
		body = '{"attachments": [' .. util.TableToJSON(msg, true) .. "]}", -- tabletojson doesn't work because it doesn't include the square brackets??
		success = PostSuccess,
		failed = ErrorCode
	})
end

local function SendQueue()
	for k, v in ipairs(PreLoadQueue) do
		Send(v.User, v.Message, v.UserName, v.NoSuffix)
	end
end
hook.Add("HTTPLoaded", "Slack.PreLoadQueue", SendQueue)

slack = setmetatable({
	Send = Send,
	Embed = Embed,
	AddChannel = AddChannel,
	AddChannels = AddChannels,
	AddUser = AddUser,
	AddUsers = AddUsers
}, {
	__call = function(self, ...)
		return self.Send(...)
	end
})