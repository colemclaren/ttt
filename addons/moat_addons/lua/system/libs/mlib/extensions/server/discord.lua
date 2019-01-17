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
	[400] = "The request was improperly formatted, or the server couldn't understand it",
	[401] = "The Authorization header was missing or invalid",
	[40001] = "Unauthorized",
	[50001] = "Missing access",
	[50006] = "Cannot send an empty message",
	[50013] = "Missing permissions",
	[50015] = "Note is too long",
	[50035] = "Invalid Form Body",
	[50010] = "OAuth2 application does not have a bot"
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
	log("Discord http error code " .. (code or "unknown") .. ": " .. (ErrorCodes[code] or ""))
	log "\n"

	if (msg) then
		log(msg)
		log "\n"
	end

	return false
end

local function PostSuccess(msg, body, length, headers, code)
	code = ErrorCodes[code]
	if (code) then
		return ErrorCode(code, msg)
	end

	body = JSONToTable(body)
	if (body and body.code) then
		return ErrorCode(code, msg)
	end

	return true
end

local function Send(user, msg, username, no_suffix)
	assert(user and (Users[user] or Webhooks[user]), "Discord failed to send webhook.")

	string.Replace(msg, "@everyone", "everyone")
	string.Replace(msg, "@here", "here")
	
	if (not http or not http.Loaded) then
		table.insert(PreLoadQueue, {
			User = user,
			Message = msg,
			Username = username,
			NoSuffix = no_suffix
		})
	
		return
	end

	local info, url, name, avatar = Users[user]
	if (info) then
		url = Webhooks[info.Channel]
		name = info.Name
		avatar = info.Avatar
	else
		AddUser(user, username or user, no_suffix)
		return Send(user, msg)
	end

	assert(url and msg, "Discord failed to get webhook url or msg.")

	if (len(msg) > MaxLength) then
		msg = sub(msg, 1, MaxLength)
	end

	if (Server and Server.IsDev) then
		url = "https://discordapp.com/api/webhooks/489951089588699136/PUhbSqO9nTOeDj__f3bBTQlTesFVKHjxdpVGFC-OB2dUx1_zyjiuBTZekBlMpIC191xD"
		return
	end

	post(url, {
		parameters = {
			content = msg,
			username = name,
			avatar_url = avatar
		},
		type = "json"
	}, PostSuccess, ErrorCode)
end

local function SendQueue()
	for k, v in ipairs(PreLoadQueue) do
		Send(v.User, v.Message, v.Username, v.NoSuffix)
	end
end
hook.Add("HTTPLoaded", "Discord.PreLoadQueue", SendQueue)

discord = setmetatable({
    Send = Send,
	AddChannel = AddChannel,
	AddChannels = AddChannels,
	AddUser = AddUser,
	AddUsers = AddUsers
}, {
    __call = function(self, ...)
		return self.Send(...)
	end
})