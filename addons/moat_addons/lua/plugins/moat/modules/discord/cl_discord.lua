discordrpc = discordrpc or {}
discordrpc.enabled = true
discordrpc.debug = false
discordrpc.port = discordrpc.port

discordrpc.states = discordrpc.states or {}
discordrpc.state = discordrpc.state


function discordrpc.Print(...)
	/*local header = "[Discord RPC%s] "
	local args = {...}
	if type(args[1]) ~= "string" then
		if not discordrpc.debug then return end -- we are entering debug message land, don't show them if we don't want them to
		header = header:format(" DEBUG")
	else
		header = header:format("")
	end

	MsgC(Color(114, 137, 218), header)

	for k, v in next, args do
		if istable(v) then
			args[k] = table.ToString(v)
		end
	end*/
	--print(unpack(args))
end

function discordrpc.Init(callback)
	if not discordrpc.port then
		local validPort
		for port = 6463, 6473 do
			local success = function(body)
				if body:match("Authorization Required") and not validPort then
					discordrpc.Print(("Connection success on port %s! "):format(port))
					validPort = port
					discordrpc.port = validPort

					callback(true,nil)
				end
			end
			local failed = function(...)
				-- do nothing
			end
			http.Fetch(("http://127.0.0.1:%s"):format(port), success, failed)
		end
	else
        callback(true,nil)
    end
end
function discordrpc.SetActivity(activity, callback)
	if not discordrpc.enabled then return end

	if not discordrpc.port then
		ErrorNoHalt("DiscordRPC: port unset, did you Init?")
		return
	end

	HTTP{
		method = "POST",
		url = ("http://127.0.0.1:%s/rpc?v=1&client_id=%s"):format(discordrpc.port, discordrpc.clientID),

		type = "application/json",
		body = util.TableToJSON{
			cmd = "SET_ACTIVITY",
			args = {
				pid = math.random(11, 32768), -- This doesn't really matter though it would be nice if we could get GMod's process ID in Lua
				activity = activity
			},
			nonce = tostring(SysTime())
		},

		success = function(status, body)
			if not callback then return end
			local data = util.JSONToTable(body)
			if not data or data.evt == "ERROR" then
				callback(false, "Discord error: " .. tostring(data.data and data.data.message or "nil"))
			else
				callback(data)
			end
		end,
		failed = function(err)
			if not callback then return end

			callback(false, "HTTP error: " .. err)
		end,
	}
end
local defaultActivity = {
	details = "???",
	state = "Default state"
}
local start = os.time()
local ServerName = false

function discordrpc.GetActivity()
    if not ServerName then
        local s = ""
        if GetHostName():lower():match("ttc") then
            s = s .. "TTC"
        else
            s = s .. "TTT"
        end
        if GetHostName():lower():match("west") then
            s = s .. " West"
        elseif GetHostName():lower():match("eu") then
            s = s .. " EU"
        elseif GetHostName():lower():match("minecraft") then
            s = s .. " MC"
        end
        for i = 1,12 do
            if GetHostName():lower():match("%#" .. i) then
                s = s .. " #" .. i
            end
        end
        if (s == "TTT") or (s == "TTC") then s = s .. " Dev" end
        ServerName = s
    end

    local round = "Active Round"
    local r = GetRoundState()
    if r == ROUND_POST then round = "Ending Round" end
    if r == ROUND_PREP then round = "Preparing Round" end

	local activity = {}
        activity = {
            details = #player.GetAll()  .. "/" .. game.MaxPlayers() .. " Players | " .. math.max(0, GetGlobal("ttt_rounds_left")) .. " Rounds Left | " .. round,
            state = ServerName ..  " | " .. game.GetMap() .. " | " .. game.GetIPAddress() .. "",
            timestamps = {
               -- start = start,
                ["end"] = os.time() + math.ceil(GetGlobal("ttt_round_end") - CurTime()) -- nothing?
            },
            assets = {
                large_image = "logo",
                large_text = "http://moat.gg/",
                small_image = "gmod",
                small_text = "Garry's Mod"
            }
            -- Other fields available that we can't use (atleast I don't think so): party, secrets, instance, application_id, flags
        }

	return activity
end


discordrpc.clientID = "430843529510649897" 
discordrpc.BotclientID = "432286257532633099"
discordrpc.state = "" 

function discordrpc.Auth()
    HTTP({
        method = "POST",
        url = ("http://127.0.0.1:%s/rpc?v=1&client_id=%s"):format(discordrpc.port, discordrpc.BotclientID),

        type = "application/json",
        body = util.TableToJSON{
            cmd = "AUTHORIZE",
            args = {
                client_id = discordrpc.BotclientID,
                scopes = {
                    "identify",
                    "guilds.join"
                }
            },
            nonce = tostring(SysTime())
        },

        success = function(status, body)
            body = util.JSONToTable(body)
			if (not body.data) then return end
            if body.data.code == 5000 then return end
            discordrpc.OAuth = body.data.code

            net.Start("discord.OAuth")
            net.WriteString(discordrpc.OAuth)
            net.SendToServer()         
        end,
        failed = function(err)
            print(err)
        end,
    })
end

local blur = Material("pp/blurscreen")
local function DrawBlur(panel, amount)
    local x, y = panel:LocalToScreen(0, 0)
    local scrW, scrH = ScrW(), ScrH()
    surface.SetDrawColor(255, 255, 255)
    surface.SetMaterial(blur)

    for i = 1, 3 do
        blur:SetFloat("$blur", (i / 3) * (amount or 6))
        blur:Recompute()
        render.UpdateScreenEffectTexture()
        surface.DrawTexturedRect(x * -1, y * -1, scrW, scrH)
    end
end


local function make_discord()
    dis_panel = vgui.Create("DFrame")
    dis_panel:SetSize(500,240)
    dis_panel:MakePopup()
    dis_panel:Center()
    dis_panel:SetTitle("Join our discord!")
    function dis_panel:Paint(w,h)
        surface.SetDrawColor(21, 28, 35, 150)
        surface.DrawRect(0, 0, w, h)

        DrawBlur(self, 3)
    end
	dis_panel.OnRemove = function()
		local num = cookie.GetNumber("MG_Discord_Attempts_working0", 0)
		cookie.Set("MG_Discord_Attempts_working0", num + 1)
	end

    local lbl = vgui.Create("DLabel", dis_panel)
	lbl:SetPos(10, 30)
	lbl:SetText("We've noticed that you have Discord!\n\nWould you like to join our Discord for a free 3,000 Inventory Credits?")
	lbl:SetWide(dis_panel:GetWide() - 20)
	lbl:SetWrap(true)
	lbl:SetAutoStretchVertical(true)
	lbl:SetTextColor(Color(255, 255, 255))
	lbl:SetFont("DermaLarge")

    local yes = vgui.Create("DButton",dis_panel)
    yes:SetWide(dis_panel:GetWide() - 20)
    yes:SetTall(50)
    yes:SetPos(10,175)
    yes:SetText("YES!")
    yes:SetFont("DermaLarge")
    function yes.DoClick()
        dis_panel:Close() 
        Derma_Message("Please click 'Authorize' in your Discord client and enjoy the free IC!","Last step for Discord","Done!")
        timer.Simple(0.5,function()
            discordrpc.Auth()
        end)
    end
end
concommand.Add("discord_popup",make_discord)

net.Receive("discord.OAuth",function()
    local p = net.ReadEntity()
	if (not IsValid(p)) then return end

    if p == LocalPlayer() then
        cookie.Set("MG_DiscordZ",1)
    end
    chat.AddText(Color(255,255,255),"[",Color(114,137,218),"!discord",Color(255,255,255),"] ",Color(0,255,0),p:Nick(),Color(255,255,255)," Just joined our discord and got ",Color(255,255,0),"3,000 IC!!!")
end)

hook.Add("HTTPLoaded", "discordrpc_init", function()
    --if (GetHostName():lower():find("dev")) then return end
	discordrpc.Init(function(succ, err)
		if succ then
            timer.Simple(0,function()
                if cookie.GetNumber("MG_DiscordZ", 0) ~= 1 and cookie.GetNumber("MG_Discord_Attempts_working0", 0) < 5 then
                    net.Receive("AmIDiscord",function()
                        local d = net.ReadBool()
                        if d then
                            cookie.Set("MG_DiscordZ",1)
                        else
                            make_discord()
                        end
                    end)
                    net.Start("AmIDiscord")
                    net.SendToServer()
                end
            end)
			--[[discordrpc.SetActivity(discordrpc.GetActivity(), print)
            hook.Add("ShutDown","Discord",function()
                HTTP{
                    method = "POST",
                    url = ("http://127.0.0.1:%s/rpc?v=1&client_id=%s"):format(discordrpc.port, discordrpc.clientID),

                    type = "application/json",
                    body = util.TableToJSON{
                        cmd = "SET_ACTIVITY",
                        args = {
                        },
                        nonce = tostring(SysTime())
                    },

                    success = function(status, body)
                    end,
                    failed = function(err)
                    end,
                }          
            end)
            timer.Create("discordrpc", 20, 0, function()
                discordrpc.SetActivity(discordrpc.GetActivity(), discordrpc.Print)
            end)]]
		end
	end)
end)
