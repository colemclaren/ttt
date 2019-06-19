
local PANEL = {}

AccessorFunc( PANEL, "NumSlider", "NumSlider" )

AccessorFunc( PANEL, "m_fSlideX", "SlideX" )
AccessorFunc( PANEL, "m_fSlideY", "SlideY" )

AccessorFunc( PANEL, "m_iLockX", "LockX" )
AccessorFunc( PANEL, "m_iLockY", "LockY" )

AccessorFunc( PANEL, "m_fSlideX2", "SlideX2" )
AccessorFunc( PANEL, "m_fSlideY2", "SlideY2" )
AccessorFunc( PANEL, "m_iLockX2", "LockX2" )
AccessorFunc( PANEL, "m_iLockY2", "LockY2" )

AccessorFunc( PANEL, "Dragging", "Dragging" )
AccessorFunc( PANEL, "m_bTrappedInside", "TrapInside" )
AccessorFunc( PANEL, "m_iNotches", "Notches" )

Derma_Hook( PANEL, "Paint", "Paint", "Slider" )

function PANEL:CreateKnob()
    local Knob = self:Add "DButton"
    Knob:SetText ""
    Knob:SetSize(15, 15)
    Knob:NoClipping(true)
    Knob.Paint = function( panel, w, h ) derma.SkinHook( "Paint", "SliderKnob", panel, w, h ) end
    Knob.OnCursorMoved = function(panel, x, y)
        self:TransferKnob(panel)
		local x, y = panel:LocalToScreen(x, y)
		x, y = self:ScreenToLocal(x, y)
		self:OnKnobMoved(panel, x, y)
    end

    AccessorFunc( Knob, "m_fSlideX", "SlideX" )
    AccessorFunc( Knob, "m_fSlideY", "SlideY" )
    
    AccessorFunc( Knob, "m_iLockX", "LockX" )
    AccessorFunc( Knob, "m_iLockY", "LockY" )

    Knob:SetSlideY(0.5)
    Knob:SetLockY(0.5)
    
    table.insert(self.Knobs, Knob)
    
    self:TransferKnob(Knob)

    return Knob
end

function PANEL:TransferKnob(knob)
    if (IsValid(self.CurrentActive)) then
        self.CurrentActive:SetZPos(0)
    end

    knob:SetZPos(1)
    self.CurrentActive = knob
end


function PANEL:Init()
    self:SetMouseInputEnabled( true )
    
    self.Knobs = {}

    self:CreateKnob():SetSlideX(0)
    self:CreateKnob():SetSlideX(1)
end

--
-- Are we currently editing?
--
function PANEL:IsEditing()
    local any_depressed = false

    for _, Knob in pairs(self.Knobs) do
        any_depressed = any_depressed or Knob.Depressed
    end

	return self.Dragging or any_depressed
end

function PANEL:SetBackground( img )
	if (not self.BGImage) then
		self.BGImage = self:Add "DImage"
	end

	self.BGImage:SetImage(img)
	self:InvalidateLayout()
end

function PANEL:SetImage(strImage)
end

function PANEL:SetImageColor(color)
end

function PANEL:OnKnobMoved(Knob, x, y)
    if (not self.Dragging and not Knob.Depressed) then
        return
    end

    local w, h = self:GetSize()
	local iw, ih = Knob:GetSize()

	if ( self.m_bTrappedInside ) then
		w = w - iw
		h = h - ih

		x = x - iw * 0.5
		y = y - ih * 0.5
	end

	x = math.Clamp(x, 0, w) / w
	y = math.Clamp(y, 0, h) / h

	if (Knob.m_iLockX) then x = Knob.m_iLockX end
	if (Knob.m_iLockY) then y = Knob.m_iLockY end

	x, y = self:TranslateValues(Knob, x, y)

	Knob:SetSlideX(x)
	Knob:SetSlideY(y)

    self:InvalidateLayout()
    
    self:NotifyChange(Knob, x, y)
end

function PANEL:NotifyChange(knob, x, y) end

function PANEL:TranslateValues(knob, x, y)
    local left, right

    for i, v in ipairs(self.Knobs) do
        if (v == knob) then
            left = self.Knobs[i - 1]
            right = self.Knobs[i + 1]
            break
        end
    end
    

    if (left and x < left:GetSlideX()) then
        x = left:GetSlideX()
    elseif (right and x > right:GetSlideX()) then
        x = right:GetSlideX()
    end

	return x, y
end

function PANEL:OnMousePressed(mcode)
	self:SetDragging(true)
	self:MouseCapture(true)
end

function PANEL:OnMouseReleased(mcode)
	self:SetDragging(false)
	self:MouseCapture(false)
end

function PANEL:PerformLayout()
    local w, h = self:GetSize()
    
    for _, Knob in pairs(self.Knobs) do
        local iw, ih = Knob:GetSize()

        if (self.m_bTrappedInside) then
            w = w - iw
            h = h - ih
            Knob:SetPos((Knob.m_fSlideX or 0) * w, (Knob.m_fSlideY or 0) * h)
        else
            Knob:SetPos((Knob.m_fSlideX or 0) * w - iw * 0.5, (Knob.m_fSlideY or 0) * h - ih * 0.5)
        end

        if (self.BGImage) then
            self.BGImage:StretchToParent( 0, 0, 0, 0 )
            self.BGImage:SetZPos( -10 )
        end
    end
end

function PANEL:GetDragging()
	return self:IsEditing()
end

derma.DefineControl("DMultiSlider", "", PANEL, "Panel")
