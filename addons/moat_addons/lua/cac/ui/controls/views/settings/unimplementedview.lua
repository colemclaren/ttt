local self = {}

function self:Init ()
end

function self:Paint (w, h)
	local height = 192
	local barWidth = w / 32
	
	local y0 = 0.5 * (h - height)
	local gradient = 1
	
	local text = "Not implemented yet"
	surface.SetFont (CAC.Font ("Roboto", 32))
	local textWidth, textHeight = surface.GetTextSize (text)
	
	local paddedTextWidth  = textWidth  + 48
	local paddedTextHeight = textHeight + 48
	
	-- Stencil
	render.SetStencilPassOperation (STENCIL_REPLACE)
	render.SetStencilFailOperation (STENCIL_REPLACE)
	render.SetStencilZFailOperation (STENCIL_REPLACE)
	render.SetStencilTestMask (0xFF)
	render.SetStencilWriteMask (0xFF)
	render.SetStencilReferenceValue (1)
	
	render.SetStencilEnable (true)
	render.ClearStencil ()
	render.SetStencilCompareFunction (STENCIL_NEVER)
	
	surface.SetDrawColor (CAC.Colors.Black)
	surface.DrawRect (0.5 * (w - paddedTextWidth), 0.5 * (h - paddedTextHeight), paddedTextWidth, paddedTextHeight)
	
	render.SetStencilCompareFunction (STENCIL_NOTEQUAL)
	
	-- Stripes
	draw.NoTexture ()
	
	surface.SetDrawColor (CAC.Colors.Salmon)
	for x = 0, w + gradient * height, barWidth * 2 do
		surface.DrawPoly (
			{
				{ x = x,                                y = y0          }, 
				{ x = x + barWidth,                     y = y0          }, 
				{ x = x + barWidth - gradient * height, y = y0 + height },
				{ x = x            - gradient * height, y = y0 + height }
			}
		)
	end
	
	surface.SetDrawColor (CAC.Colors.Gray)
	for x = barWidth, w + gradient * height, barWidth * 2 do
		surface.DrawPoly (
			{
				{ x = x,                                y = y0          }, 
				{ x = x + barWidth,                     y = y0          }, 
				{ x = x + barWidth - gradient * height, y = y0 + height },
				{ x = x            - gradient * height, y = y0 + height }
			}
		)
	end
	
	render.SetStencilEnable (false)
	
	-- Text rectangle
	render.SetStencilEnable (true)
	render.ClearStencil ()
	render.SetStencilCompareFunction (STENCIL_NEVER)
	
	paddedTextWidth  = textWidth + 32
	paddedTextHeight = textHeight + 32
	surface.SetDrawColor (CAC.Colors.Black)
	surface.DrawRect (0.5 * (w - paddedTextWidth), 0.5 * (h - paddedTextHeight), paddedTextWidth, paddedTextHeight)
	
	render.SetStencilCompareFunction (STENCIL_NOTEQUAL)
	
	paddedTextWidth  = textWidth + 48
	paddedTextHeight = textHeight + 48
	surface.SetDrawColor (CAC.Colors.Gray)
	surface.DrawRect (0.5 * (w - paddedTextWidth), 0.5 * (h - paddedTextHeight), paddedTextWidth, paddedTextHeight)
	
	render.SetStencilEnable (false)
	
	-- Text
	surface.SetTextPos (0.5 * (w - textWidth), 0.5 * (h - textHeight))
	surface.SetTextColor (CAC.Colors.Gray)
	surface.DrawText (text)
end

CAC.Register ("CACUnimplementedView", self, "CACPanel")