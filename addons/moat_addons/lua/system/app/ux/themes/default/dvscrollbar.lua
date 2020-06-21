local PANEL = {}

AccessorFunc( PANEL, "m_HideButtons", "HideButtons" )

function PANEL:Init()

    self.Offset = 0
    self.Scroll = 0
    self.CanvasSize = 1
    self.BarSize = 1
	self.LerpTarget = 0
	self.moving = false

    self.btnUp = vgui.Create( "DButton", self )
    self.btnUp:SetText( "" )
    self.btnUp.DoClick = function( self ) self:GetParent():AddScroll( -1 ) end
    self.btnUp.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonUp", panel, w, h ) end

    self.btnDown = vgui.Create( "DButton", self )
    self.btnDown:SetText( "" )
    self.btnDown.DoClick = function( self ) self:GetParent():AddScroll( 1 ) end
    self.btnDown.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "ButtonDown", panel, w, h ) end

    self.btnGrip = vgui.Create( "DScrollBarGrip", self )

    self:SetSize( 15, 15 )
    self:SetHideButtons( false )

end

function PANEL:SetEnabled( b )

    if ( !b ) then

        self.Offset = 0
        self:SetScroll( 0 )
        self.HasChanged = true

    end

    self:SetMouseInputEnabled( b )
    self:SetVisible( b )

    -- We're probably changing the width of something in our parent
    -- by appearing or hiding, so tell them to re-do their layout.
    if ( self.Enabled != b ) then

        self:GetParent():InvalidateLayout()

        if ( self:GetParent().OnScrollbarAppear ) then
            self:GetParent():OnScrollbarAppear()
        end

    end

    self.Enabled = b

end

function PANEL:Value()

    return self.Pos

end

function PANEL:BarScale()

    if ( self.BarSize == 0 ) then return 1 end

    return self.BarSize / ( self.CanvasSize + self.BarSize )

end

function PANEL:SetUp( _barsize_, _canvassize_ )

    self.BarSize = _barsize_
    self.CanvasSize = math.max( _canvassize_ - _barsize_, 1 )

    self:SetEnabled( _canvassize_ > _barsize_ )

    self:InvalidateLayout()

end

function PANEL:OnMouseWheeled( dlta )

    if ( !self:IsVisible() ) then return false end

    -- We return true if the scrollbar changed.
    -- If it didn't, we feed the mousehweeling to the parent panel

    return self:AddScroll( dlta * -2 )

end

local smooth_scrolling = GetConVar("moat_continue_scrolling"):GetInt()

function PANEL:AddScroll(dlta)
        local OldScroll = self.LerpTarget or self:GetScroll()

        if (smooth_scrolling > 0) then
            dlta = dlta * 75
        else
            dlta = dlta * 50
        end

        self.LerpTarget = math.Clamp(self.LerpTarget + dlta, -self.btnGrip:GetTall(), self.CanvasSize + self.btnGrip:GetTall())
        return OldScroll != self:GetScroll()
end

function PANEL:SetScroll( scrll )

    if ( !self.Enabled ) then self.Scroll = 0 return end

    self.Scroll = math.Clamp( scrll, 0, self.CanvasSize )

    self:InvalidateLayout()

    -- If our parent has a OnVScroll function use that, if
    -- not then invalidate layout (which can be pretty slow)

    local func = self:GetParent().OnVScroll
    if ( func ) then

        func( self:GetParent(), self:GetOffset() )

    else

        self:GetParent():InvalidateLayout()

    end

end

function PANEL:AnimateTo( scrll, length, delay, ease )
	
	self.LerpTarget = scrll

end

function PANEL:GetScroll()

    if ( !self.Enabled ) then self.Scroll = 0 end
    return self.Scroll

end

function PANEL:GetOffset()

    if ( !self.Enabled ) then return 0 end
    return self.Scroll * -1

end

function PANEL:Think()
	if (self.ScrollOnExtend) then
		if (self.StoredCanvas and self.StoredCanvas < self.CanvasSize and self.LerpTarget == self.StoredCanvas) then
			self:SetScroll(self.CanvasSize)
			self.LerpTarget = self.CanvasSize
		end

		self.StoredCanvas = self.CanvasSize
	end

    if (input.IsMouseDown(MOUSE_LEFT) and not M_INV_DRAG) then
        self.LerpTarget = self:GetScroll()
    end
        
    local frac = FrameTime() * 5

    if (smooth_scrolling > 0) then
        if (math.abs(self.LerpTarget - self:GetScroll()) <= (self.CanvasSize/10)) then frac = FrameTime() * 2 end
    else
        frac = FrameTime() * 10
    end
        
    local newpos = Lerp(frac, self:GetScroll(), self.LerpTarget)
    newpos = math.Clamp(newpos, 0, self.CanvasSize)

    self:SetScroll(newpos)

    if (self.LerpTarget < 0 and self:GetScroll() == 0) then
        self.LerpTarget = 0
    end

    if (self.LerpTarget > self.CanvasSize and self:GetScroll() == self.CanvasSize) then
        self.LerpTarget = self.CanvasSize
    end
end

function PANEL:Paint( w, h )

    derma.SkinHook( "Paint", "VScrollBar", self, w, h )
    return true

end

function PANEL:OnMousePressed()

    local x, y = self:CursorPos()

    local PageSize = self.BarSize

    if ( y > self.btnGrip.y ) then
        self:SetScroll( self:GetScroll() + PageSize )
    else
        self:SetScroll( self:GetScroll() - PageSize )
    end

end

function PANEL:OnMouseReleased()

    self.Dragging = false
    self.DraggingCanvas = nil
    self:MouseCapture( false )

    self.btnGrip.Depressed = false

end

function PANEL:OnCursorMoved( x, y )

    if ( !self.Enabled ) then return end
    if ( !self.Dragging ) then return end

    local x, y = self:ScreenToLocal( 0, gui.MouseY() )

    -- Uck.
    y = y - self.btnUp:GetTall()
    y = y - self.HoldPos

    local BtnHeight = self:GetWide()
    if ( self:GetHideButtons() ) then BtnHeight = 4 end

    local TrackSize = self:GetTall() - BtnHeight * 2 - self.btnGrip:GetTall()

    y = y / TrackSize

    self:SetScroll( y * self.CanvasSize )

end

function PANEL:Grip()

    if ( !self.Enabled ) then return end
    if ( self.BarSize == 0 ) then return end

    self:MouseCapture( true )
    self.Dragging = true

    local x, y = self.btnGrip:ScreenToLocal( 0, gui.MouseY() )
    self.HoldPos = y

    self.btnGrip.Depressed = true

end

function PANEL:PerformLayout()

    local Wide = self:GetWide()
    local BtnHeight = Wide
    if ( self:GetHideButtons() ) then BtnHeight = 4 end
    local Scroll = self:GetScroll() / self.CanvasSize
    local BarSize = math.max( self:BarScale() * ( self:GetTall() - ( BtnHeight * 2 ) ), 10 )
    local Track = self:GetTall() - ( BtnHeight * 2 ) - BarSize
    Track = Track + 1

    Scroll = Scroll * Track

    self.btnGrip:SetPos( 0, BtnHeight + Scroll )
    self.btnGrip:SetSize( Wide, BarSize )

    if ( BtnHeight > 4 ) then
        self.btnUp:SetPos( 0, 0, Wide, Wide )
        self.btnUp:SetSize( Wide, BtnHeight )

        self.btnDown:SetPos( 0, self:GetTall() - BtnHeight )
        self.btnDown:SetSize( Wide, BtnHeight )
        
        self.btnUp:SetVisible( true )
        self.btnDown:SetVisible( true )
    else
        self.btnUp:SetVisible( false )
        self.btnDown:SetVisible( false )
        self.btnDown:SetSize( Wide, BtnHeight )
        self.btnUp:SetSize( Wide, BtnHeight )
    end

end

--derma.DefineControl( "DVScrollBar", "A Scrollbar", PANEL, "Panel")