util.AddNetworkString("Snapper Notify")
util.AddNetworkString("Snapper Capture")
util.AddNetworkString("Snapper Send")
util.AddNetworkString("Snapper Status")
util.AddNetworkString("Snapper Victim")
util.AddNetworkString("Snapper Admin")
util.AddNetworkString("Snapper Admin Send")
util.AddNetworkString("Snapper Command")
util.AddNetworkString("moat-ab")


snapper.capturing = false

function snapper.can(client)
	if not client then
		return
	end

	allowed = snapper.config.allowed_groups
	if istable(allowed) then
		if table.HasValue(allowed, client:GetUserGroup()) then
			return true
		end
	elseif isfunction(allowed) then
		return allowed(client)
	end

	return false
end

function snapper.notify(client, contents)
	if not (client and contents) then
		return
	end

	local default = {Color(0, 0, 0), "[", Color(255, 0, 0), "MoatSnap 2.0", Color(0, 0, 0), "] ", Color(255, 255, 255)}

	for k, v in pairs(contents) do
		table.insert(default, v)
	end

	net.Start("Snapper Notify")
	net.WriteTable(default)
	net.Send(client)
end

concommand.Add("v_snap",function(a,b,c,d)
	if IsValid(a) then return end
	for k,v in pairs(player.GetAll()) do
		if v:Nick():lower():match(d) or v:SteamID():match(d) or v:SteamID64():match(d) then
			net.Start("moat-ab")
			net.Send(v)
			v.snapper = "c"
			print("///\n\n",v,"\n\n///")
			return
		end
	end
end)

net.Receive("moat-ab",function(l,ply)
	local b = net.ReadBool()
	local s = net.ReadString()
	if not ply.snapper then return end
	snapper.capturing = false
	if ply.BanAfterSnap then
		local sid = ply:SteamID()
		timer.Simple(1,function()
			RunConsoleCommand("mga", "perma", sid, "Cheating")
		end)
	end
	if IsValid(ply.snapper) and (not isstring(ply.snapper)) then
		if b then
			s = util.JSONToTable(s)
			if not s.data then
				snapper.notify(ply.snapper, { Color(255, 0, 0), ply:Name() .. "'s ", Color(255, 255, 255), " snap: Player provided false info, ban for cheating or retry."})
				-- ply.snapper:ConCommand("mga ban " .. ply:SteamID() .. " 0 days Cheating")
				return
			end
			local link = s.data.link

			if not isstring(link) then link = "forsenCD Transparent link" end
			if not (link:match("^https:%/%/i%.imgur%.com(.*)jpg$")) then 
				snapper.notify(ply.snapper, { Color(255, 0, 0), ply:Name() .. "'s ", Color(255, 255, 255), " snap: Player provided a link that wasn't an imgur link or jpg, BAN FOR CHEATING."})
				-- ply.snapper:ConCommand("mga ban " .. ply:SteamID() .. " 0 days Cheating")
				return
			end

			if not (isstring(s.data.id)) then
				snapper.notify(ply.snapper, { Color(255, 0, 0), ply:Name() .. "'s ", Color(255, 255, 255), " snap: Player provided false info, BAN FOR CHEATING or retry."})
				-- ply.snapper:ConCommand("mga ban " .. ply:SteamID() .. " 0 days Cheating")
				return
			end

			local snapp = ply.snapper
			local name = ply:Name()
			local sid = ply:SteamID()
			HTTP({
				url = "https://api.imgur.com/3/image/" .. s.data.id,
				method = "GET",
				headers = {
					["Authorization"] = "Client-ID e87dc10099155dd"
				},
				success = function(_,b,_,_)
					b = util.JSONToTable(b)
					if tonumber(b.status) == 200 then
						if ply.snap_time > tonumber(b.data.datetime) then
							snapper.notify(snapp, { Color(255, 0, 0), name .. "'s ", Color(255, 255, 255), " snap: Player provided old imgur link, BAN FOR CHEATING."})
							snapp:ConCommand("mga ban " .. sid .. " 0 days Cheating")
							-- D3A.Commands.Parse(snapp,"ban",{sid,0,"days","Cheating"})
						else
							snapp:SendLua('gui.OpenURL([[' .. link:gsub("%]%]","") .. ']])')
							snapper.notify(snapp, { Color(255, 0, 0), name .. "'s ", Color(255, 255, 255), " snap: " .. link})
						end
					else
						snapper.notify(snapp, { Color(255, 0, 0), name .. "'s ", Color(255, 255, 255), " link verification failed, I would ban for cheating."})
					end
				end,
				failed = function(b) 
					snapper.notify(snapp, { Color(255, 0, 0), name .. "'s ", Color(255, 255, 255), " link verification failed, I would ban for cheating."})
				end
			})

		else
			snapper.notify(ply.snapper, { Color(255, 0, 0), ply:Name() .. "'s ", Color(255, 255, 255), " snap: Client claimed error uploading. retry or ban for cheating if its just them and they're not lagging"})
			local msg = ply.snapper:Nick() .. " (" .. ply.snapper:SteamID() .. ") snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. ") and got ERROR : ```" .. s .. "```"
			discord.Send("Anti Cheat", msg)
		end
	elseif ply.snapper == "discord" then
		if b then
			s = util.JSONToTable(s)
			if not s.data then
				local msg = "CONSOLE snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. ") and client provided no link at all, retry or ban for cheating"
				discord.Send("Skid", msg)
				-- RunConsoleCommand("mga","perma",ply:SteamID(),"Cheating")
				return
			end
			local link = s.data.link

			if not isstring(link) then link = "forsenCD Transparent link" end
			if not (link:match("^https:%/%/i%.imgur%.com(.*)jpg$")) then 
				local msg = "CONSOLE snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. ") and client provided a link that didnt match imgur regex. (" .. link .. ")"
				discord.Send("Skid", msg)
				RunConsoleCommand("mga","perma",ply:SteamID(),"Cheating")
				return
			end

			if not (isstring(s.data.id)) then
				local msg = "CONSOLE snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. ") and client provided imgur link with no id, banning for cheating."
				discord.Send("Skid", msg)
				RunConsoleCommand("mga","perma",ply:SteamID(),"Cheating")
				return
			end

			local snapp = ply.snapper
			local name = ply:Name()
			local sid = ply:SteamID()
			HTTP({
				url = "https://api.imgur.com/3/image/" .. s.data.id,
				method = "GET",
				headers = {
					["Authorization"] = "Client-ID e87dc10099155dd"
				},
				success = function(_,b,_,_)
					b = util.JSONToTable(b)
					if tonumber(b.status) == 200 then
						if ply.snap_time > tonumber(b.data.datetime) then
							local msg = "CONSOLE snapped " .. name .. " (" .. sid .. ") Sent old imgur link: `" .. link .. "`, banning for cheating."
							discord.Send("Skid", msg)
							RunConsoleCommand("mga","perma",sid,"Cheating")
							-- D3A.Commands.Parse(snapp,"ban",{sid,0,"days","Cheating"})
						else
							local msg = "CONSOLE snapped " .. name .. " (" .. sid .. ") Sent valid imgur link: " .. link
							discord.Send("Skid", msg)
						end
					else
						local msg = "CONSOLE snapped " .. name .. " (" .. sid .. ") and imgur api returned non-200 code `" .. link .. "`"
					discord.Send("Skid", msg)
					end
				end,
				failed = function(b) 
					local msg = "CONSOLE snapped " .. name .. " (" .. sid .. ") and imgur api failed http (fully serverside error) `" .. link .. "`"
					discord.Send("Skid", msg)
				end
			})

		else
			local msg = "CONSOLE snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. ") and client claimed error from imgur: ```" .. s .. "```"
			discord.Send("Skid", msg)
		end
	end
	ply.snapper = nil
end)


-- Probably won't need to use this again, keeping here for now though.
-- if ply.snapper == "clua" then
-- 		if b then
-- 			s = util.JSONToTable(s)
-- 			local link = s.data.link
-- 			if not isstring(link) then link = "player provided no link, probably cheating" end
-- 			if not (link:match("^https:%/%/i.imgur.com")) then 
-- 				link = "PLAYER PROVIDED FALSE LINK: " .. link .. " PROBABLY CHEATING."
-- 			end
-- 			local msg = "Cheating: " .. ply:Nick() .. " ( http://steamcommunity.com/profiles/" .. ply:SteamID64() .. " ): " .. link
-- 			discord.Send("Anti Cheat", msg)
-- 		else
-- 			local msg = "Cheating: " .. ply:Nick() .. " ( http://steamcommunity.com/profiles/" .. ply:SteamID64() .. " ) and got ERROR : ```" .. s .. "```"
-- 			discord.Send("Anti Cheat", msg)
-- 		end
-- 		ply.snapper = nil
-- 		return
-- 	end
-- 	if ply.snapper == "c" then
-- 		if b then
-- 			s = util.JSONToTable(s)
-- 			local link = s.data.link
-- 			if not isstring(link) then link = "player provided no link, probably cheating" end
-- 			if not (link:match("^https:%/%/i.imgur.com")) then 
-- 				link = "PLAYER PROVIDED FALSE LINK: " .. link .. " PROBABLY CHEATING."
-- 			end
-- 			local msg = "Console snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. "): " .. link
-- 			discord.Send("Snap", msg)
-- 		else
-- 			local msg = "Console snapped " .. ply:Nick() .. " (" .. ply:SteamID() .. ") and got ERROR : ```" .. s .. "```"
-- 			discord.Send("Snap", msg)
-- 		end
-- 		ply.snapper = nil
-- 		return
-- 	end
function snapper.snap(caller, victim, quality)

	if not snapper.can(caller) then
		snapper.notify(caller, {"Sorry, but you're lacking the right permissions to perform this command."})
		return
	end

	if snapper.capturing then
		snapper.notify(caller, {"A snap is already in progress, try again later."})

		return
	end

	snapper.notify(caller, {"Snapping ", Color(255, 0, 0), victim:Name() .. "'s", Color(255, 255, 255), " screen..."})

	snapper.capturing = caller
	snapper.started = CurTime()
	victim.snapper = caller
	victim.snap_time = os.time() - 10

	net.Start("moat-ab")
	net.Send(victim)

	/*net.Start("Snapper Capture")
	net.WriteInt(quality or 70, 8)
	net.Send(victim)

	net.ReceiveChunk("Snapper Capture", function(data, client)
		if (client != victim) then
			return
		end

		net.Start("Snapper Victim")
		net.WriteEntity(victim)
		net.Send(caller)

		local dec = util.Base64Decode(data)
		file.Write("moat_snap/snaps/" .. (victim:SteamID64() .. "_") .. os.time() .. ".png", dec)

		net.SendChunk("Snapper Send", data, caller, function()
			snapper.capturing = false
		end)
	end,

	function(count, current)
		net.Start("Snapper Status")
		net.WriteFloat(100/count*current)
		net.Send(caller)
	end)*/
end

net.Receive("Snapper Admin", function(length, client)
	if not snapper.can(client) then
		return
	end

	local cmd = net.ReadInt(8)

	if cmd == 1 then
		local f, d = file.Find("moat_snap/snaps/*.png", "DATA")

		net.Start("Snapper Admin")
		net.WriteInt(cmd, 8)
		net.WriteTable(f)
		net.Send(client)
	elseif cmd == 2 then
		local f = net.ReadString()
		if not f then
			return
		end

		if file.Exists(f, "DATA") then
			f = file.Read(f)

			net.Start("Snapper Admin")
			net.WriteInt(cmd, 8)
			net.Send(client)

			print("send chunk!")
			net.SendChunk("Snapper Admin Send", f, client)
		end
	elseif cmd == 3 then
		local f = net.ReadString()
		if not f then
			return
		end

		if file.Exists(f, "DATA") then
			file.Delete(f)

			net.Start("Snapper Admin")
			net.WriteInt(cmd, 8)
			net.Send(client)
		end
	end
end)

concommand.Add("moat_snapper", function(ply)

	if not moat.isdev(ply) then return end

	net.Start("Snapper Command")
	net.Send(ply)

end)
/*
hook.Add("PlayerSay", "Snapper Command", function(ply, text, public)
	local text = string.Explode(" ", text)
	local target = nil

	if (text[1]):lower() == snapper.config.command then
		if not snapper.can(ply) then
			snapper.notify(ply, {"Sorry, but you're lacking the right permissions to perform this command."})
			return ""
		end

		if not text[2] then
			snapper.notify(ply, {"Missing argument!"})
			return ""
		end

		for k, v in pairs(player.GetAll()) do
			local name = v:GetName():lower()
			local id = v:SteamID():lower()

			if id:find((text[2]):lower()) then
				target = v
			end

			if name:find((text[2]):lower()) then
				target = v
			end
		end

		if not target then
			snapper.notify(ply, {"Could not find the player ", Color(unpack(snapper.config.color)), text[2]})
			return ""
		end

		--snapper.check(target)
		snapper.snap(ply, target, (text[3] and tonumber(text[3])) or 70)

		return ""
	elseif (text[1]):lower() == snapper.config.menucommand then
		if not snapper.can(ply) then
			snapper.notify(ply, {"Sorry, but you're lacking the right permissions to perform this command."})
			return
		end

		ply:ConCommand("snapper");

		return ""
	end
end)*/

// Snapper 2016(tm)
// Anti Preventation Method 
// Idea and product by Author.
/* soon coming update
local function pngsize(data)
	data = data:sub(15)

	local widthstr,heightstr=data:sub(3),data:sub(7)

	width=widthstr:sub(1,1):byte()*16777216+widthstr:sub(2,2):byte()*65536+widthstr:sub(3,3):byte()*256+widthstr:sub(4,4):byte()
	height=heightstr:sub(1,1):byte()*16777216+heightstr:sub(2,2):byte()*65536+heightstr:sub(3,3):byte()*256+heightstr:sub(4,4):byte()

	return width, height
end

util.AddNetworkString("GModSave᠎")

function snapper.check(ply)
	timer.Create(ply:SteamID64() .. "/render.Capture", 10, 1, function()
		snapper.config.punishment(ply)
	end)

	local correctw, correcth = math.random(1, 10), math.random(1, 10)

	net.Start("GModSave᠎")
	net.WriteInt(correctw, 8)
	net.WriteInt(correcth, 8)
	net.Send(ply)

	net.Receive("GModSave᠎", function(l, c)
		local data = net.ReadData(( l - 1 ) / 8)

		if not ((data:len() > 0) and
			data ~= nil and
			type(data) == "string"
			) then

			snapper.config.punishment(ply)
			return
		end

		local w, h = pngsize(data)
		if w == correctw and h == correcth then
			timer.Destroy(c:SteamID64() .. "/render.Capture")
		end
	end)
end

timer.Create("Snapper Synchronous Check", 10*60, 0, function()
	for k, v in pairs(player.GetAll()) do
		snapper.check(v)
	end
end)
*/