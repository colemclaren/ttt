MatUI = {}
MatUI.ClickExit = {}
MatUI.Card = function()
	return snapper.icons.sheetMat
end

function MatUI:CreateTextureBorder( _x, _y, _w, _h, l, t, r, b )

	local mat = self.Card();
	local tex = mat:GetTexture( "$basetexture" );
	
	_x = _x / tex:Width();
	_y = _y / tex:Height();
	_w = _w / tex:Width();
	_h = _h / tex:Height();
	
	local _l = l / tex:Width();
	local _t = t / tex:Height();
	local _r = r / tex:Width();
	local _b = b / tex:Height();
	
	local x, y, w, h = 0, 0, 110, 110
	
	return function( x, y, w, h, col, middle )
		
		if ( middle == nil ) then middle = true end
		
		surface.SetMaterial( mat );
		if ( col ) then 
			surface.SetDrawColor( col );
		else
			surface.SetDrawColor( 255, 255, 255, 255 );
		end
		
		-- top 
		surface.DrawTexturedRectUV( x, y, l, t, _x, _y, _x+_l, _y+_t );
		surface.DrawTexturedRectUV( x+l, y, w-l-r, t, _x+_l, _y, _x+_w-_r, _y+_t );
		surface.DrawTexturedRectUV( x+w-r, y, r, t, _x+_w-_r, _y, _x+_w, _y+_t );
	
		-- bottom 
		surface.DrawTexturedRectUV( x, y+h-b, l, b, _x, _y+_h-_b, _x+_l, _y+_h );
		surface.DrawTexturedRectUV( x+l, y+h-b, w-l-r, b, _x+_l, _y+_h-_b, _x+_w-_r, _y+_h );
		surface.DrawTexturedRectUV( x+w-r, y+h-b, r, b, _x+_w-_r, _y+_h-_b, _x+_w, _y+_h );
		
		-- middle. 
		if ( middle ) then
		surface.DrawTexturedRectUV( x+l, y+t, w-l-r, h-t-b, _x+_l, _y+_t, _x+_w-_r, _y+_h-_b );
		end
		surface.DrawTexturedRectUV( x, y+t, l, h-t-b, _x, _y+_t, _x+_l, _y+_h-_b );
		surface.DrawTexturedRectUV( x+w-r, y+t, r, h-t-b, _x+_w-_r, _y+_t, _x+_w, _y+_h-_b );
	
	end

end

function MatUI:CreateTextureNormal( _x, _y, _w, _h )

	local mat = self.Card();
	local tex = mat:GetTexture( "$basetexture" );
	
	_x = _x / tex:Width();
	_y = _y / tex:Height();
	_w = _w / tex:Width();
	_h = _h / tex:Height();
		
	return function( x, y, w, h, col )
		
		surface.SetMaterial( mat );
		
		if ( col ) then 
			surface.SetDrawColor( col );
		else
			surface.SetDrawColor( 255, 255, 255, 255 );
		end
		
		surface.DrawTexturedRectUV( x, y, w, h, _x, _y, _x+_w, _y+_h );

	end

end

function MatUI:CreateTextureCentered( _x, _y, _w, _h )

	local mat = self.Card();
	local tex = mat:GetTexture( "$basetexture" );
	
	local width = _w;
	local height = _h;
	
	_x = _x / tex:Width();
	_y = _y / tex:Height();
	_w = _w / tex:Width();
	_h = _h / tex:Height();
		
	return function( x, y, w, h, col )
		
		x = x + (w-width)*0.5;
		y = y + (h-height)*0.5;
		w = width;
		h = height;
		
		surface.SetMaterial( mat );
		
		if ( col ) then 
			surface.SetDrawColor( col );
		else
			surface.SetDrawColor( 255, 255, 255, 255 );
		end
		
		surface.DrawTexturedRectUV( x, y, w, h, _x, _y, _x+_w, _y+_h );

	end;

end

function MatUI.DrawCard(x, y, w, h, col)
	return MatUI:CreateTextureBorder( 2, 2, 110, 110, 8, 8, 8, 8)(x-5, y-5, w+10, h+10, col or Color(255, 255, 255))
end

function LerpColor(frac,from,to)
	local col = Color(
		Lerp(frac,from.r,to.r),
		Lerp(frac,from.g,to.g),
		Lerp(frac,from.b,to.b),
		Lerp(frac,from.a,to.a)
	)
	return col
end

draw.Circle = function(ox,oy,r) --Blue
	local PolyData = {}
	local originx = ox or 300
	local originy = oy or 300
	local radius = r
	for deg=0, 359 do
		local x,y = math.cos(math.rad(deg)*math.pi)*radius+originx, math.sin(math.rad(deg)*math.pi)*radius+originy
		PolyData[deg] = {x=x,y=y}
	end
	surface.DrawPoly(PolyData)
end

surface.CreateFont("Roboto Medium", {
	font="Roboto Medium",
	size=ScreenScale(6),
})

surface.CreateFont("Roboto Title", {
	font="Roboto Regular",
	size=ScreenScale(11),
	weigth = 400,
})

surface.CreateFont("Roboto Text", {
	font="Roboto Regular",
	size=ScreenScale(6),
	weigth = 400,
})

surface.CreateFont("Roboto Bold", {
	font="Roboto Bold",
	size=ScreenScale(6),
})

local blur = Material("pp/blurscreen")

function surface.DrawBlurRect(x, y, w, h, amount, heavyness)
	local X, Y = 0,0
	local scrW, scrH = ScrW(), ScrH()
 
	surface.SetDrawColor(255,255,255)
	surface.SetMaterial(blur)
 
	for i = 1, heavyness do
		blur:SetFloat("$blur", (i / 3) * (amount or 6))
		blur:Recompute()
 
		render.UpdateScreenEffectTexture()
 
		render.SetScissorRect(x, y, x+w, y+h, true)
			surface.DrawTexturedRect(X * -1, Y * -1, scrW, scrH)
		render.SetScissorRect(0, 0, 0, 0, false)
	end
end

function surface.DrawShadow(x,y,w,h,radius,opacity)
	surface.SetDrawColor(0,0,0,opacity or 255)
	surface.DrawRect(x-radius,y-radius,w+(radius*2),h+(radius*2))

	surface.DrawBlurRect(x-radius,y-radius,w+(radius*2),h+(radius*2),0,10)
end

hook.Add("CreateMove", "Mouse Click", function(m, now)
	if input.WasMousePressed(MOUSE_LEFT) then
		for k, v in pairs(MatUI.ClickExit) do
			if v and IsValid(v) and ispanel(v) then
				if v:IsVisible() and v:IsValid() and v:HasFocus() then
					local mx, my = gui.MousePos()
					local px, py = v:GetPos()
					local pw, ph = v:GetSize()

					if (mx > px) and (my > py) and (mx < (px + pw)) and (my < (py + ph)) then
						return		
					end

					if v.Close then
						v:Close()

						return
					end

					v:Remove()
				end
			end
		end
	end
end)

function FancyButton(parent)
	local r, g, b = unpack(parent.Color or {0, 0, 0})

	local ButtonColor = parent.ButtonColor or Color(r, g, b, 0)
	local TextColor = parent.TextColor or Color(r, g, b, 255)

	parent.FadeSpeed = 6
	parent.Radials = {}

	function parent.Paint(s,w,h)
		if parent.Disabled then
			parent:SetTextColor(Color(120, 120, 120, 150))

			return
		end

		if s.Hovered then
			ButtonColor = LerpColor(parent.FadeSpeed * FrameTime(), ButtonColor, Color(ButtonColor.r, ButtonColor.g, ButtonColor.b, 70))
			TextColor = LerpColor(parent.FadeSpeed * FrameTime(), TextColor, Color(TextColor.r, TextColor.g, TextColor.b, 240))
		else
			ButtonColor = LerpColor(parent.FadeSpeed * FrameTime(), ButtonColor, Color(ButtonColor.r, ButtonColor.g, ButtonColor.b, 0))
			TextColor = LerpColor(parent.FadeSpeed * FrameTime(), TextColor, Color(TextColor.r, TextColor.g, TextColor.b, 255))
		end

		if (TextColor ~= s:GetTextColor()) then
			s:SetTextColor(TextColor)
		end

		draw.RoundedBox(parent.Edge or 3, 0, 0, w, h, ButtonColor)

		if (not parent.DisableRadials) then
			for k, v in pairs(parent.Radials) do
				if (not v.static) then
					if v.time > CurTime() then
						v.col.a = math.Approach(v.col.a, 0, (v.speed/2) * FrameTime())
						v.radius = math.Approach(v.radius, parent:GetWide() * 2, v.speed*FrameTime())
					else
						parent.Radials[v] = nil
					end
				end

				surface.SetDrawColor(v.col)
				draw.NoTexture()
				draw.Circle(v.x, v.y, v.radius)
			end
		end

		if parent.CustomPaint then
			parent.CustomPaint(s, w, h)
		end
	end

	function parent.DoClick(s)
		if parent.DisableInput then
			return
		end

		if parent.Disabled then
			return
		end

		if parent.CustomClick then
			parent.CustomClick(s)
		end

		x, y = s:ScreenToLocal(gui.MouseX(), gui.MouseY())
		table.insert(parent.Radials, {
			x = x,
			y = y,
			col = Color(r, g, b, 75),
			time = CurTime() + 3,
			speed = 475 + (parent:GetWide()/14),
			radius = 0,
		})
	end
end

function FancyDialog(_title, _text, options)
	local panel = vgui.Create("DPanel")
	panel:SetSize(ScrW()/2.5, ScrH()/6)
	panel:MakePopup(true)
	
	local w, h = panel:GetSize()
	local x, y = ScrW()/2-w/2, ScrH()/2-h/2

	panel:SetPos(x, y-100)
	panel:MoveTo(x, y, .1, 0, .5)
	panel:SetAlpha(0)

	table.insert(MatUI.ClickExit, panel)

	function panel:Close()
		self.Closing = true

		self:MoveTo(x, y-100, .1, 0, .5, function()
			self.FinishedClosing = true
		end)
	end

	function panel.Paint(s, w, h)
		 local x, y = s:GetPos()

		surface.SetDrawColor(0, 0, 0, 170)
		surface.DrawRect(-x, -y, ScrW(), ScrH())

		MatUI.DrawCard(0, 0, w, h)

		if s.Closing then
			if s:GetAlpha() ~= 0 then
				s:SetAlpha(math.Approach(s:GetAlpha(), 0, 2000 * FrameTime()))
			else
				if s.FinishedClosing then
					s:Remove()
				end
			end

			return
		end

		if s:GetAlpha() ~= 255 then
			s:SetAlpha(math.Approach(s:GetAlpha(), 255, 1270 * FrameTime()))
		end

		s:NoClipping(true)
	end

	local title = vgui.Create("DLabel", panel)
	title:Dock(TOP)
	title:SetTall(70)
	title:DockMargin(25, 0, 0, 0)
	title:InvalidateParent(true)
	title:SetFont("Roboto Title")
	title:SetTextColor(Color(42, 42, 42))
	title:SetText(_title)

	local footer = vgui.Create("DPanel", panel)
	footer:Dock(BOTTOM)
	footer:InvalidateParent(true)
	footer:SetTall(36)
	footer:DockMargin(8, 8, 8, 8)
	footer.Paint=function()end

	for k, v in pairs(options) do
		local button = vgui.Create("DButton", footer)
		button:Dock(RIGHT)
		button:DockMargin(0, 0, 8, 0)
		button:InvalidateParent(true)
		button:SetText(v.text)
		button:SetFont("Roboto Medium")
		button.Color = v.col

		function button.CustomPaint(s, w, h)
			surface.SetFont(s:GetFont())
			local textw, texth = surface.GetTextSize(s:GetText())
			local _w = textw+32

			if _w ~= s:GetWide() then
				s:SetWide(_w > (64+16) and _w or (64+16))
			end
		end

		function button.Close(s)
			panel:Remove()
		end

		function button.CustomClick(s)
			if v.func then
				v.func(s)
			end
		end

		FancyButton(button)
	end

	local text = vgui.Create("ExText", panel)
	text:Dock(FILL)
	text:DockMargin(25, 0, 8, 0)
	text:InvalidateParent(true)
	text:Open()
	text:AppendLine({
		Type = "Font",
		Data = "Roboto Text",
	},
	{
		Type = "Color",
		Data = Color(42, 42, 42),
	},
	{
		Type = "Text",
		Data = _text,
	})

	timer.Simple(.1, function()
		text.Scroll:SetScroll(0)
	end)
end