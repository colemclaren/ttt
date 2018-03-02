local PANEL = {}

function PANEL:Init()

	self.btnUp  :SetAlpha( 0 )
	self.btnDown:SetAlpha( 0 )

	self:SetWide( 6 )
	self.AmIVisible = false

	self.BGAlpha = 0
	self.FGAlpha = 140

	function self.btnGrip.Paint( s, w, h )

		if not self.AmIVisible then
			return
		end

		if self.Dragging or self:IsHovered() or self:IsChildHovered( 4 ) then
			self.FGAlpha = math.min( self.FGAlpha + FrameTime() * ( 20 / 0.1 ), 190 )
		else
			self.FGAlpha = math.max( self.FGAlpha - FrameTime() * ( 20 / 0.1 ), 170 )
		end

		surface.SetDrawColor( self.FGAlpha, self.FGAlpha, self.FGAlpha, 255 )
		surface.DrawRect( 0, 0, w, h )

	end

	DVScrollBar.SetEnabled( self, true )	

end

function PANEL:OnCursorMoved( x, y )

	if ( !self.Enabled ) then return end
	if ( !self.Dragging ) then return end

	local x = 0
	local y = gui.MouseY()
	local x, y = self:ScreenToLocal( x, y )
	
	-- Uck. 
	y = y - self.HoldPos
	
	local TrackSize = self:GetTall() - self.btnGrip:GetTall()
	
	y = y / TrackSize
	
	self:SetScroll( y * self.CanvasSize )	
	
end

function PANEL:PerformLayout()

	local Scroll = self:GetScroll() / self.CanvasSize
	local BarSize = 28
	local Track = self:GetTall() - BarSize + 1
	
	Scroll = Scroll * Track
	
	self.btnGrip:SetPos( 0, Scroll )
	self.btnGrip:SetSize( self:GetWide(), BarSize )

end

function PANEL:GetRealWidth()

	if self.Enabled then
		return self:GetWide()
	else
		return 0
	end

end

function PANEL:ScrollToBottom( now )

	if now then

		self:SetScroll( self.CanvasSize )

	else

		timer.Simple( 0, function()

			if IsValid( self ) then
				self:ScrollToBottom( true )
			end

		end )		

	end

end

function PANEL:ScrollToTop( now )

	if now then

		self:SetScroll( 0 )

	else

		timer.Simple( 0, function()

			if IsValid( self ) then
				self:ScrollToTop( true )
			end

		end )		

	end

end

function PANEL:SetEnabled( b )

	self.AmIVisible = b

end

function PANEL:AtBottom()

	return not self.Enabled or self:GetScroll() == self.CanvasSize

end

function PANEL:Paint( w, h )

	if not self.AmIVisible then
		return
	end

	if self.Dragging or self:IsHovered() or self:IsChildHovered( 4 ) then
		self.BGAlpha = math.min( self.BGAlpha + FrameTime() * ( 32 / 0.1 ), 48 )
	else
		self.BGAlpha = math.max( self.BGAlpha - FrameTime() * ( 32 / 0.1 ), 0 )
	end

	if self.BGAlpha ~= 0 then

		surface.SetDrawColor( 80, 80, 80, self.BGAlpha )
		surface.DrawRect( 0, 0, w, h )

	end

end

vgui.Register( "ExTextScrollBar", PANEL, "DVScrollBar" )

local PANEL = {}

AccessorFunc( PANEL, "m_Rebuilding", "Rebuilding" )
AccessorFunc( PANEL, "m_ScrollOffset", "ScrollOffset" )
AccessorFunc( PANEL, "m_ScrollDown", "ShouldScrollDown" )

function PANEL:Init()

	self.CurX = 0
	self.CurY = 0

	self.Content	= {}
	self.Children	= {}

	self:SetRebuilding( false )
	self:SetScrollOffset( 0 )
	self:SetShouldScrollDown( false )

	self.Scroll = vgui.Create( "ExTextScrollBar", self )
	self.Scroll : Dock( RIGHT )

	self:SetMouseInputEnabled( true )

	-- Gott's be even
	self.VPadding = 2

	self:Open()

end

function PANEL:PerformLayout()

	-- All children will be rebuilt from our content array
	self.Children = {}

	-- Rebuild!
	self.CurX = 0
	self.CurY = 0

	local oldContent = self.Content
	self.Content	= {}

	-- We don't want to update our scroll panel while re-adding each line (unless we feel like removing FPS)
	self:SetRebuilding( true )
		for k, v in ipairs( oldContent ) do
			self:AppendLine( unpack( v ) )
		end
	
		self:UpdateScrollBar()
	self:SetRebuilding( false )

end

function PANEL:AppendLine( ... )

	local args = { ... }

	table.insert( self.Content, args )

	self:StartInsertion()

	for k, v in ipairs( args ) do

		local vType = v.Type
		local vData = v.Data

		if vType == "Text" then
			self:AppendText( vData )
		elseif vType == "Image" then
			self:AppendImage( vData )
		elseif vType == "Font" then
			self:AppendFont( vData )
		elseif vType == "Color" then
			self:AppendColor( vData )
		elseif vType == "Spacer" then
			self:AppendSpacer( vData )
		end

	end

	self:AppendText "\n"

	self:EndInsertion()

	-- Split our content in half after each 256 lines
	if #self.Content > 256 then

		for i = 1, 128 do
			table.remove( self.Content, 1 )
		end

		self:PerformLayout()

	end

end

function PANEL:StartInsertion()

	self.CurFont	= "DermaDefaultBold"
	self.CurColor	= Color( 162, 255, 162 )
	self.CurLine	= { Time = RealTime(), Height = 0 }

	self:SetShouldScrollDown( self.Scroll:AtBottom() or self:GetRebuilding() )

	self.SegmentBuffer = {}

end

function PANEL:EndInsertion()

	for _, segment in ipairs( self.SegmentBuffer ) do

		if segment.Type == "Text" then

			local x, y	= segment.x, segment.y
			local font	= segment.Font
			local text	= table.concat( segment.Text )
			local color	= Color( segment.Color.r, segment.Color.g, segment.Color.b, segment.Color.a )

			surface.SetFont( font )
			local textW, textH = surface.GetTextSize( text )			

			local panelTall = self:GetTall()
			local panelWide = self:GetWide()

			local lineHeight = segment.Line.Height

			--
			-- Move our text to the bottom of our bounding radius
			--
			local realY = y
			y = y + lineHeight - textH - self.VPadding / 2

			local x2, y2 = x + textW, y + textH

			local StartTime, DieTime = segment.Line.Time + 10, segment.Line.Time + 10.3

			if #text == 0 then
				continue
			end

			local function Paint( yOffset, isOpen )

				-- Don't render if we are out of bounds
				if y2 + yOffset < 0 or y + yOffset > panelTall then
					return
				end

				local alpha = 255

				if not self.IsOpen then

					if RealTime() >= StartTime then
						alpha = math.max( 0, 255 * ( 1 - math.TimeFraction( StartTime, DieTime, RealTime() ) ) )

						if alpha == 0 then
							return
						end
					end

				end

				color.a = alpha

				--surface.SetDrawColor( Color( 0, 255, 0 ) )
				--surface.DrawOutlinedRect( x, y + yOffset, textW, textH )

				surface.SetFont( font )
				surface.SetTextPos( x, y + yOffset )
				surface.SetTextColor( color )

				surface.DrawText( text )

			end

			table.insert( self.Children, Paint )

		elseif segment.Type == "Image" then

			local x, y		= segment.x, segment.y
			local mat		= segment.Mat
			local w, h		= segment.Width, segment.Height

			local realY = y

			--
			-- Center our image vertically
			--
			y = y + segment.Line.Height / 2 - h / 2 + 1

			local y2 = y + h
			local panelTall = self:GetTall()
			local panelWide = self:GetWide()

			local lineHeight = segment.Line.Height

			local StartTime, DieTime = segment.Line.Time + 10, segment.Line.Time + 10.3

			local color = Color( 255, 255, 255 )

			local function Paint( yOffset, isOpen )

				-- Don't render if we are out of bounds
				if y2 + yOffset < 0 or y + yOffset > panelTall then
					return
				end

				local alpha = 255

				if not self.IsOpen then

					if RealTime() >= StartTime then
						alpha = math.max( 0, 255 * ( 1 - math.TimeFraction( StartTime, DieTime, RealTime() ) ) )

						if alpha == 0 then
							return
						end
					end

				end

				color.a = alpha

				surface.SetDrawColor( color )
				surface.SetMaterial( mat )

				surface.DrawTexturedRect( x, y + yOffset, w, h )

			end

			table.insert( self.Children, Paint )

		end

	end

	self.CurLine	= nil
	self.CurFont	= nil
	self.CurColor	= nil

	self.SegmentBuffer = nil

	if not self:GetRebuilding() then
		self:UpdateScrollBar()
	end

	if self:GetShouldScrollDown() then
		self.Scroll:ScrollToBottom( self:GetRebuilding() )
	end

end

function PANEL:AppendColor( col )
	self.CurColor = col
end

function PANEL:AppendFont( font )
	self.CurFont = font
end

function PANEL:AppendText( text )

	if #text == 0 then
		return
	end

	text = utf8.force( text )

	surface.SetFont( self.CurFont )

	local w, h = self:GetSize()

	-- Adjust for scrollbar size
	w = w - self.Scroll:GetRealWidth()

	local function NewSegment()

		local segment = {
			x		= self.CurX,
			y		= self.CurY,
			Text	= {},
			Font	= self.CurFont,
			Type	= "Text",
			Line	= self.CurLine,
			Color	= self.CurColor
		}

		table.insert( self.SegmentBuffer, segment )

		return segment

	end

	local segment = NewSegment()
	local lastSpace = nil

	for p, c in utf8.codes( text ) do

		c = utf8.char(c)

		local cW, cH = surface.GetTextSize( c ); cH = cH + self.VPadding

		if self.CurX + cW > w or c == "\n" then

			if c == "\n" then
				lastSpace = nil
				cH = cH / 2
			end

			--
			-- If we are able to word-wrap, rather than char-wrap, do so.
			--
			local carryOver = {}

			if lastSpace then

				for i = lastSpace + 1, #segment.Text do
						table.insert( carryOver, segment.Text[ i ] )
						segment.Text[ i ] = nil
				end

				lastSpace = nil

			end

			--
			-- Reset the upvalues for our new line.
			--
			self.CurX = 0
			self.CurY = self.CurY + self.CurLine.Height
			segment = NewSegment()

			--
			-- Apply our carried over chars, we know that we won't reach the line's max length here.
			--
			for _, c in ipairs( carryOver ) do

				local cW, cH = surface.GetTextSize( c ); cH = cH + self.VPadding

				if cH > self.CurLine.Height then
					self.CurLine.Height = cH
				end

				self.CurX = self.CurX + cW

				table.insert( segment.Text, c )

			end

		end

		if c == " " then
			lastSpace = #segment.Text + 1
		end

		if c == "\n" or c == "\r" then
			continue
		end

		if cH > self.CurLine.Height then
			self.CurLine.Height = cH
		end

		self.CurX = self.CurX + cW

		table.insert( segment.Text, c )

	end

end

function PANEL:AppendImage( image )

	local w, h = self:GetSize()

	-- Adjust for scrollbar size
	w = w - self.Scroll:GetRealWidth()

	print(image:GetString( "$normalmap" ) )

	local mat = image
	local iW, iH = mat:Width(), mat:Height() + self.VPadding

	if self.CurX + iW > w then
		self.CurX = 0
		self.CurY = self.CurY + self.CurLine.Height
	end

	if iH > self.CurLine.Height then
		self.CurLine.Height = iH
	end

	local segment = {
		x		= self.CurX,
		y		= self.CurY,
		Mat		= mat,
		Type	= "Image",
		Width	= iW,
		Height	= iH - self.VPadding,
		Line	= self.CurLine
	}

	self.CurX = self.CurX + iW

	table.insert( self.SegmentBuffer, segment )

end

function PANEL:AppendSpacer( height )
	self.CurY = self.CurY + height
end

function PANEL:Open()

	self.Scroll:SetAlpha( 255 )
	self.IsOpen = true

end

function PANEL:Close()

	self.Scroll:SetAlpha( 0 )
	self.IsOpen = false

	self.Scroll:ScrollToBottom()

end

function PANEL:OnMouseWheeled( delta )
	return self.Scroll:OnMouseWheeled( delta )
end

function PANEL:OnVScroll( offset )
	self:SetScrollOffset( offset )
end

function PANEL:UpdateScrollBar()
	self.Scroll:SetUp( self:GetTall(), self.CurY )
end

function PANEL:Paint( w, h )

	if not self.IsOpen then
		DisableClipping( true )
	end

	for k, v in ipairs( self.Children ) do

		v( self:GetScrollOffset(), self.IsOpen )

	end

	DisableClipping( false )

end

vgui.Register( "ExText", PANEL, "Panel" )