snapper.menu = snapper.menu or {}
snapper.icons = snapper.icons or {}

surface.CreateFont("Snapper Title", {
	font = "Roboto Regular",
	size = ScreenScale(8),
	weigth = 400,
})

surface.CreateFont("Roboto 24", {
	font = "Roboto Regular",
	size = 24,
	weigth = 400,
})

surface.CreateFont("Roboto Big", {
	font = "Roboto Regular",
	size = ScreenScale(28),
	weigth = 400,
})

local gradient_d = Material("vgui/gradient-d")
function snapper.menu.view(data)
	if (not data) then return end

	snapper.menu.frame = vgui.Create("DPanel")
	local frame = snapper.menu.frame

	frame:SetSize(ScrW()/2, ScrH()/1.5)
	frame:Center(true)
	frame:NoClipping(true)
	frame:SetMouseInputEnabled(true)
	frame.text = "Screenshot of ".. snapper.victim:Name() .. " (".. snapper.victim:SteamID() .. ")"

	gui.EnableScreenClicker(true)

	function frame.Paint(s, w, h)
		surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, 25)

        m_DrawShadowedText(1, s.text, "moat_ItemDesc", w - 40, 6, Color(200, 200, 200, 255), TEXT_ALIGN_RIGHT)
	end

	local frameheader = vgui.Create("DPanel", frame)
	frameheader:Dock(TOP)
	frameheader:SetTall(25)

	function frameheader.Paint(s, w, h) end

	frameheader.close = vgui.Create("DButton", frameheader)
    frameheader.close:SetPos(frame:GetWide() - 36, 3)
    frameheader.close:SetSize(33, 19)
    frameheader.close:SetText("")

    frameheader.close.Paint = function(s, w, h)
        draw.RoundedBoxEx(0, 0, 0, w, h, Color(28, 28, 25), false, true, false, true)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(95, 95, 95))
        surface.SetDrawColor(Color(137, 137, 137, 255))
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(157, 157, 157, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))

        if (s:IsHovered()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 15))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 50), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end

        if (s:IsDown()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 0, 0, 20))
            draw.SimpleTextOutlined("r", "marlett", 17, 9, Color(255, 0, 0, 100), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER, 1, Color(75, 75, 75, 100))
        end
    end

    frameheader.close.DoClick = function()
        snapper.menu.close()
    end

    local save = vgui.Create("DButton", frameheader)
	save:SetPos(3, 3)
	save:SetSize(75, 19)
	save:SetText("")
	save.text = "Save"
    save.Paint = function(s, w, h)
    	surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 0, 200, 100)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 255, 100)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)

        if (s:IsHovered()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 255, 15))
        end

        if (s:IsDown()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 0, 255, 20))
        end
    	
    	m_DrawShadowedText(1, s.text, "moat_ItemDesc", w/2, 9, Color(175, 175, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

	function save:DoClick()
		if not file.IsDir("snapper", "DATA") then
			file.CreateDir("snapper")
		end

		if not file.IsDir("moat_snap/saved", "DATA") then
			file.CreateDir("moat_snap/saved")
		end

		file.Write("moat_snap/saved/".. os.time() ..".png", util.Base64Decode(data))

		self.text = "Saved!"
		self:SetEnabled(false)
	end

    local recapture = vgui.Create("DButton", frameheader)
	recapture:SetPos(81, 3)
	recapture:SetSize(75, 19)
	recapture:SetText("")
	recapture.text = "Resnap"
    recapture.Paint = function(s, w, h)
    	surface.SetDrawColor(50, 50, 50, 100)
        surface.DrawOutlinedRect(0, 0, w, h)
        surface.SetDrawColor(0, 200, 0, 100)
        surface.DrawRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 200 + 55, 0, 100)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)

        if (s:IsHovered()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 255, 0, 15))
        end

        if (s:IsDown()) then
            draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(0, 255, 0, 20))
        end
    	
    	m_DrawShadowedText(1, s.text, "moat_ItemDesc", w/2, 9, Color(175, 255, 175), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    end

	function recapture:DoClick()
		RunConsoleCommand("say", snapper.config.command .. " " .. snapper.victim:SteamID())

		snapper.menu.close()
	end

	local holder = vgui.Create("DPanel", frame)
	holder:Dock(FILL)
	holder:InvalidateParent(true)
	holder.Paint = nil

	local main = vgui.Create("DHTML", holder)
   	main:SetPos(0, 0)
   	main:SetSize(holder:GetSize())

   	main:InvalidateParent(true)
   	main:SetMouseInputEnabled(true)
	main:SetHTML( '<style type="text/css"> body { margin: 0; padding: 0; overflow: hidden; } img { width: 100%; height: 100%; } </style> <img src="data:image/jpg;base64,' .. data .. '"> ')
   	main:RequestFocus()

   	local p = vgui.Create("DPanel", holder)
   	p:Dock(FILL)
   	function p:Paint(w, h) end

   	function p:Think()
		local mousex = self:ScreenToLocal(gui.MouseX())
		local mousey = self:ScreenToLocal(gui.MouseY())
			
		if (self.Dragging) then
			local x = mousex - self.Dragging[1]
			local y = mousey - self.Dragging[2]

			main:SetPos( x, y )
		end
   	end

   	function p:Button()
   		if not p.b then
	   		p.b = vgui.Create("DButton", frameheader)
	   		p.b:SetPos(159, 3)
			p.b:SetSize(125, 19)
	   		p.b:SetText("")
	   		p.b.text = "Reset Position"
    		p.b.Paint = function(s, w, h)
    			surface.SetDrawColor(50, 50, 50, 100)
        		surface.DrawOutlinedRect(0, 0, w, h)
        		surface.SetDrawColor(200, 200, 200, 100)
        		surface.DrawRect(1, 1, w - 2, h - 2)
        		surface.SetDrawColor(255, 255, 255, 100)
        		surface.SetMaterial(gradient_d)
        		surface.DrawTexturedRect(1, 1, w - 2, h - 2)

        		if (s:IsHovered()) then
        		    draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 15))
        		end

        		if (s:IsDown()) then
          			draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(255, 255, 255, 20))
        		end
    	
    			m_DrawShadowedText(1, s.text, "moat_ItemDesc", w/2, 9, Color(255, 255, 255), TEXT_ALIGN_CENTER, TEXT_ALIGN_CENTER)
    		end

	   		function p.b:DoClick()
	   			main:SetPos(0, 0)
	   			main:SetSize(holder:GetSize())

	   			self:Remove()

	   			p.b = nil
	   		end
	   	end
   	end

   	function p:OnMouseWheeled(code)
   		self:Button()

   		local x, y, w, h = main:GetBounds()
   		if code > 0 then
   			main:SetPos(x-15, y-15)
   			main:SetSize(w+30, h+30)
   		else
   			main:SetPos(x+15, y+15)
   			main:SetSize(w-30, h-30)
   		end
   	end

   	function p:OnMousePressed(code)
   		self:Button()
		self.Dragging = {main:ScreenToLocal(gui.MouseX()), main:ScreenToLocal(gui.MouseY())}
		self:MouseCapture(true)
   	end

   	function p:OnMouseReleased(code)
		self.Dragging = nil
		self:MouseCapture(false)
		self:InvalidateParent()
   	end
end

function snapper.menu.close()
	gui.EnableScreenClicker(false)
	snapper.menu.frame:Remove()
end

surface.CreateFont( "Info Text", {
    font = "Roboto Medium",
    size = ScreenScale(6.4),
    antialias = true
} )

surface.CreateFont( "Info Header", {
    font = "Roboto Bold",
    size = ScreenScale(8),
    antialias = true
} )

surface.CreateFont( "Info Title", {
    font = "Roboto Medium",
    size = ScreenScale(16),
    antialias = true
} )

surface.CreateFont( "Info Tiny", {
    font = "Roboto Medium",
    size = ScreenScale(5),
    antialias = true
} )

function snapper.menu.admin()
	if snapper.menu.frame then
		snapper.menu.frame:Remove()
	end

	snapper.menu.frame = vgui.Create("DPanel")
   	local frame = snapper.menu.frame

    frame:SetSize(ScrW()/1.3, ScrH()/1.3)
    frame:Center(true)
    frame:NoClipping(true)

    gui.EnableScreenClicker(true)

    function frame.Paint(s, w, h)
        surface.SetDrawColor(62, 62, 64, 255)
        surface.DrawOutlinedRect(0, 0, w, h)
        draw.RoundedBox(0, 1, 1, w - 2, h - 2, Color(34, 35, 38, 250))
        surface.SetDrawColor(0, 0, 0, 120)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, h - 2)
        surface.SetDrawColor(0, 0, 0, 150)
        surface.SetMaterial(gradient_d)
        surface.DrawTexturedRect(1, 1, w - 2, 25)
    end

    local frameheader = vgui.Create("DPanel", frame)
    frameheader:Dock(TOP)
    frameheader:SetTall(32)

    function frameheader.Paint(s, w, h)
		surface.SetDrawColor(unpack(snapper.config.color))
		surface.DrawRect(0, 0, w, h)

		surface.SetDrawColor(0, 0, 0, 145)
		surface.DrawRect(0, 0, w, h)
    end

    frameheader.close = vgui.Create("DButton", frameheader)
    frameheader.close:Dock(RIGHT)
    frameheader.close:SetWide(32)
    frameheader.close:SetText("")

    function frameheader.close.Paint(s, w, h)
        surface.SetDrawColor(255, 255, 255, 255 and s:IsHovered() or 175)
        surface.SetMaterial(snapper.icons.closeMat)
        surface.DrawTexturedRect(0, h/2-48/2/2, 48/2, 48/2)
    end

    function frameheader.close.DoClick(s)
        frame:Remove()
        gui.EnableScreenClicker(false)
    end

    local header = vgui.Create("DPanel", frame)
    header:Dock(TOP)
    header:SetTall(64)
    header.text = "Snapper Administration Panel"

    function header.Paint(s, w, h)
        surface.SetDrawColor(unpack(snapper.config.color))
        surface.DrawRect(0, 0, w, h)

        surface.SetDrawColor(255, 255, 255)
        surface.SetMaterial(snapper.icons.cameraMat)
        surface.DrawTexturedRect(16, 16, 32, 32)

        surface.SetTextColor(255, 255, 255)
        surface.SetFont("Snapper Title")

        local textw, texth = surface.GetTextSize(header.text)

        surface.SetTextPos(64+16, h/2-texth/2)
        surface.DrawText(header.text)
    end

    local snaps = vgui.Create("DTree", frame)
    snaps:Dock(LEFT)
    snaps:SetWide(frame:GetWide()/5)
    snaps.RootNode:DockMargin(8, 8, 8, 8)

   	function snaps:Paint(w, h)
   		surface.SetDrawColor(230, 230, 230)
   		surface.DrawRect(0, 0, w, h)

   		surface.SetDrawColor(175, 175, 175)
   		surface.DrawLine(w-1, 0, w-1, h)

   		/* wtf
   		if self.Items then
   			surface.SetTextColor(100, 100, 100)
   			surface.SetFont("Roboto 24")

   			local text = "Oh boy that's empty!"
   			local tw, th = surface.GetTextSize(text)

   			surface.SetTextPos(w/2-tw/2, h/10-th/2)
   			surface.DrawText(text)
   		end
   		*/
	end

	local holder = vgui.Create("DPanel", frame)
	holder:Dock(FILL)
	holder:InvalidateParent(true)

	holder.Text = "Select a snap to load"
	holder.Text2 = "from the list"
	function holder:Paint(w, h)
		surface.SetTextColor(200, 200, 200)
		surface.SetFont("Roboto Big")
		
		local textw, texth = surface.GetTextSize(self.Text)

		surface.SetTextPos(w/2-textw/2, h/3-texth/2)
		surface.DrawText(self.Text)

		//Newline

		surface.SetTextColor(200, 200, 200)
		surface.SetFont("Roboto Big")
		
		local textw2, texth2 = surface.GetTextSize(self.Text2)

		surface.SetTextPos(w/2-textw2/2, h/3-texth2/2+texth)
		surface.DrawText(self.Text2)

		--surface.SetDrawColor(200, 200, 200)
		--surface.DrawRect(w/2-textw/2, h/3+texth/1.75, textw, 3)
	end

	local main, p, open
	local function open(data)
		data = util.Base64Encode(data)

		main = main or vgui.Create("DHTML", holder)
   		main:SetPos(0, 0)
   		main:SetSize(holder:GetSize())

   		main:InvalidateParent(true)
   		main:SetMouseInputEnabled(true)
		main:SetHTML( '<style type="text/css"> body { margin: 0; padding: 0; overflow: hidden; } img { width: 100%; height: 100%; } </style> <img src="data:image/jpg;base64,' .. data .. '"> ')
   		main:RequestFocus()

   		if not p then
	   		p = vgui.Create("DPanel", holder)
	   		p:Dock(FILL)
	   		function p:Paint(w, h) end

	   		function p:Think()
				local mousex = self:ScreenToLocal(gui.MouseX())
				local mousey = self:ScreenToLocal(gui.MouseY())
				
				if (self.Dragging) then
					local x = mousex - self.Dragging[1]
					local y = mousey - self.Dragging[2]

					main:SetPos( x, y )
				end
	   		end

	   		function p:Button()
	   			if not p.b then
		   			p.b = vgui.Create("DButton", p)
		   			p.b:SetPos(8, 8)
		   			p.b:SetSize(64, 32)
		   			p.b:SetText("RESET")
		   			p.b:SetFont("Roboto Medium")
		   			p.b.Color = {0, 175, 255}

		   			FancyButton(p.b)

		   			function p.b:DoClick()
		   				main:SetPos(0, 0)
		   				main:SetSize(holder:GetSize())

		   				self:Remove()

		   				p.b = nil
		   			end
		   		end
	   		end

	   		function p:OnMouseWheeled(code)
	   			self:Button()

	   			local x, y, w, h = main:GetBounds()
	   			if code > 0 then
	   				main:SetPos(x-15, y-15)
	   				main:SetSize(w+30, h+30)
	   			else
	   				main:SetPos(x+15, y+15)
	   				main:SetSize(w-30, h-30)
	   			end
	   		end

	   		function p:OnMousePressed(code)
	   			self:Button()
				self.Dragging = {main:ScreenToLocal(gui.MouseX()), main:ScreenToLocal(gui.MouseY())}
				self:MouseCapture(true)
	   		end

	   		function p:OnMouseReleased(code)
				self.Dragging = nil
				self:MouseCapture(false)
				self:InvalidateParent()
	   		end
	   	end
   	end
   	
   	net.Start("Snapper Admin")
   	net.WriteInt(1, 8)
   	net.SendToServer()

   	local png
   	net.Receive("Snapper Admin", function(length, server)
   		local cmd = net.ReadInt(8)

   		if cmd == 1 then
	   		local t = net.ReadTable()
		    local players = {}

		   	for k, v in pairs(t) do
		   		local ply = v:match("%d*")
		   		players[ply] = players[ply] or {}
		   		table.insert(players[ply], tostring(v:match("_%d*"):gsub("_", "")))
		   	end

		   	for k, v in pairs(players) do
		   		local ply = player.GetBySteamID64(k)
		   		if not ply then
		   			continue
		   		end

		   		local node = snaps:AddNode((ply:Name() .. " (" .. k .. ")") or k)
		   		node:SetIcon("icon16/user.png")
		   		node.Label:SetFont("Info Tiny")
				local days = {}

		   		for _, time in pairs(v) do
		   			local day = os.date("%d/%m/%Y", time)
		   			days[day] = days[day] or {}
		   			table.insert(days[day], time)
		   		end

		   		for _, time in pairs(days) do
		   			local day = node:AddNode(_)
		   			day:SetIcon("icon16/time.png")
		   			day.Label:SetFont("Info Tiny")
		   			local used = {}
		   			for __, t in pairs(time) do
		   				if table.HasValue(used, t) then
		   					continue
		   				end

		   				table.insert(used, t)

		   				local n = day:AddNode(os.date("%H:%M:%S", t))
			   			n:SetIcon("icon16/picture.png")
			   			n.Label:SetFont("Info Tiny")
			   			function n:OnNodeSelected()
			   				if main and IsValid(main) and ispanel(main) then
				   				main:Remove()
				   				main = nil
				   			end

				   			if p and IsValid(p) and ispanel(p) then
				   				p:Remove()
				   				p = nil
				   			end

			   				holder.Text = "Requestig image..."
			   				holder.Text2 = ""

			   				png = ("moat_snap/snaps/" .. k .. "_" .. t .. ".png")

			   				if file.Exists(png, "DATA") then
			   					open(file.Read(png))

			   					return
			   				end

			   				net.Start("Snapper Admin")
			   				net.WriteInt(2, 8)
			   				net.WriteString(png)
			   				net.SendToServer()
			   			end

			   			function n:DoRightClick()
			   				local menu = DermaMenu()
							local delete = menu:AddOption("Delete", function()
								png = ("moat_snap/snaps/" .. k .. "_" .. t .. ".png")

				   				net.Start("Snapper Admin")
				   				net.WriteInt(3, 8)
				   				net.WriteString(png)
				   				net.SendToServer()

				   				n:Remove()
				   				n = nil
							end)

							delete:SetPos(gui.MouseX(), gui.MouseY())
							delete:SetIcon("icon16/cross.png")
							menu:Open()
			   			end
		   			end
		   		end
	   		end
	   	elseif cmd == 2 then
	   		net.ReceiveChunk("Snapper Admin Send", function(data)
	   			open(data)
	   			
	   			file.Write(png, data)

	   			holder.Text = "Boom!"
	   		end, function(current, amount)
	   			if not (holder and IsValid(holder) and ispanel(holder)) then
	   				return
	   			end

	   			holder.Text = "Receiving image..."
	   			holder.Text2 = amount/current*100 .. "%..."
	   		end)
	   	elseif cmd == 3 then
	   		if holder and IsValid(holder) and ispanel(holder) then
	   			if main and IsValid(main) and ispanel(main) then
				   	main:Remove()
				   	main = nil
				end

				if p and IsValid(p) and ispanel(p) then
					p:Remove()
					p = nil
				end

		   		holder.Text = "Image deleted!"
		   		holder.Text2 = ""
		   	end
	   	end
   	end)
end

function snapper.download(url, name, res)
	if file.Exists("moat_snap/".. name ..".png", "DATA") then
		res(Material("../data/moat_snap/".. name ..".png"))
	end

	http.Fetch(url, function(contents)
		file.Write("moat_snap/".. name ..".png", contents)

		print("Downloaded menu file (".. name .. ".png)")

		res(Material("../data/moat_snap/".. name ..".png"))
	end)
end

hook.Add("InitPostEntity", "Download Snapper Content", function()
	snapper.download("http://i.imgur.com/tbT4Zvd.png", "sheet", function(res) snapper.icons.sheetMat = res end)
	snapper.download("http://i.imgur.com/TQj30DE.png", "close", function(res) snapper.icons.closeMat = res end)
	snapper.download("http://i.imgur.com/9rdirBF.png", "camera", function(res) snapper.icons.cameraMat = res end)
end)

net.Receive("Snapper Command", function(len)
	snapper.menu.admin()
end)