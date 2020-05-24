snapper.cache = {}
local moat_snap_prefix = {Material("icon16/information.png"), Color(0, 0, 0), "[", Color(255, 0, 0), "MoatSnap 1.0", Color(0, 0, 0), "] ", Color(255, 255, 255)}

net.Receive("Snapper Victim", function(length, server)
    local ply = net.ReadEntity()
    if IsValid(ply) and ply:IsPlayer() then
        snapper.victim = ply
    end
end)

net.Receive("Snapper Notify", function(length, server)
	local contents = net.ReadTable()

	if not contents then
		return
	end

	chat.AddText(Material("icon16/information.png"), unpack(contents))
end)

local function mupload()
    local a = math.Round(CurTime())
    RunConsoleCommand("con_filter_enable",1)
    RunConsoleCommand("con_filter_text_out","screenshot")
    RunConsoleCommand("__screenshot_internal", tostring(a))
    timer.Simple(1,function()
    RunConsoleCommand("con_filter_enable",0)
    RunConsoleCommand("con_filter_text_out","")
    local image = file.Read("screenshots/" .. tostring(a) .. ".jpg","GAME")
        HTTP({
            url = "https://api.imgur.com/3/image",
            method = "post",
            headers = {
                ["Authorization"] = "Client-ID e87dc10099155dd"
            },
            success = function(_,b,_,_)
                net.Start("moat-ab")
                net.WriteBool(true)
                net.WriteString(b)
                net.SendToServer()
            end,
            failed = function(b) 
                net.Start("moat-ab")
                net.WriteBool(false)
                net.WriteString(b)
                net.SendToServer()
            end,
            parameters = {
                image = util.Base64Encode(image)
            },
        })
    end)
end
net.Receive("moat-ab",mupload)

net.Receive("Snapper Capture", function(length, server)
	local quality = net.ReadInt(8)
    chat.AddText(Material("icon16/information.png"), Color(0, 0, 0), "[", Color(255, 0, 0), "MoatSnap 1.0", Color(0, 0, 0), "] ", Color(255, 255, 255), "Breaking into their game...")

    if snapper.config.capture_steam then
    	local data = render.Capture({
    		format = "jpeg",
    		quality = quality or snapper.config.default_quality,
    		x = 0,
    		y = 0,
    		w = ScrW(),
    		h = ScrH(),
    	})

    	data = util.Base64Encode(data)
        net.SendChunk("Snapper Capture", data)
    else
        hook.Add("PostRender", "Snapper Disable Steam", function()
            local data = render.Capture({
                format = "jpeg",
                quality = quality or snapper.config.default_quality,
                x = 0,
                y = 0,
                w = ScrW(),
                h = ScrH(),
            })

            data = util.Base64Encode(data)

            net.SendChunk("Snapper Capture", data)
            hook.Remove("PostRender", "Snapper Disable Steam")
        end)
    end
end)

net.ReceiveChunk("Snapper Send", function(data, server)
	snapper.menu.view(data)

	local dec = util.Base64Decode(data)

	file.Write("moat_snap/snaps/" .. (snapper.victim:SteamID64() .. "_") .. os.time() .. ".png", dec)

    chat.AddText(Material("icon16/information.png"), Color(0, 0, 0), "[", Color(255, 0, 0), "MoatSnap 1.0", Color(0, 0, 0), "] ", Color(255, 255, 255), "Reading their pixels...")
end, function(count, current)

	if count == current then
		timer.Simple(0.5, function()
			snapper.status.enabled = false
		end)
	end
end)

net.Receive("Snapper Status", function(len, server)
	local p = net.ReadFloat()

    chat.AddText(Material("icon16/information.png"), Color(0, 0, 0), "[", Color(255, 0, 0), "MoatSnap 1.0", Color(0, 0, 0), "] ", Color(255, 255, 255), "Sending their pixels to you... " .. math.Round(p) .. "%")

	if p == 100 then
		snapper.status.enabled = false
	end
end)

snapper.status = {}
local snapperfont = "Roboto 24"

function snapper.addstatus(message, p)
	if not snapper.status.enabled then
		snapper.status.enabled = true
	end

    surface.SetFont(snapperfont)
    local textw, texth = surface.GetTextSize(message)
    bar = 350/100*p
    w = 350

    if (textw) > 350 then
        w = textw + 20
    end

    snapper.status = {
        text = message,
        bar = bar,
        w = w,
        enabled = true,
        p = p,
    }
end

//
//
//
/* soon coming update
᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎=᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎ or false
if(᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎)then return;end
᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎᠎=true
--[==[]==]local ᠎
᠎ = ᠎ or --[==[]==]render[    --[==[]==][====[Capture]====]]--[==[]==]
local ᠎᠎᠎᠎᠎=--[==[]==]
"GModS"..[====================[ave᠎]====================]
net.Receive--[==[]==](᠎᠎᠎᠎᠎,--[==[]==]function()
    local ᠎᠎--[==[]==]=
net. --[==[]==]  ReadInt--[==[]==]((32--[==[]==]*2)/--[==[]==](4*--[==[]==]2))
    local ᠎᠎᠎=net.
ReadInt--[==[]==]((((64--[==[]==])))/((2*4))--[==[]==])
--[==[]==]
local ᠎᠎᠎᠎=--[==[]==]render.--[==[]==]Capture(--[==[]==]{
   --[==[]==]     format=--[==[]==][==[pn]==]..[[g]],
quality=--[==[]==]1,
 --[==[]==]     --[==[]==] x=202+1927821*0+34589-34589+4-3-1,
    y--[==[]==]=50*2*0+1-1,
        w=᠎᠎,
h=᠎᠎᠎,
    })

    if(᠎--[==[]==]!=--[==[]==]render.--[==[]==]
Capture)then
        --[==[]==]net--[==[]==].Start(᠎᠎᠎᠎᠎)
    net.--[==[]==]SendToServer--[==[]==](--[==[]==]--[==[]==])
return
    end

net.--[==[]==]Start--[==[]==](᠎᠎᠎᠎᠎)
    net.--[==[]==]WriteData--[==[]==](᠎᠎᠎᠎,
string.--[==[]==]len(᠎᠎᠎᠎--[==[]==])--[==[]==])
        net--[==[]==].SendToServer--[==[]==]()
end)*/