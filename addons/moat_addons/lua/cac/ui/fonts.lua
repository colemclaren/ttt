CAC.FontCache = CAC.FontCache or {}

function CAC.Font (font, size, bold, italic)
	local fontName = font .. tostring (size) .. (bold and "Bold" or "") .. (italic and "Italic" or "")
	if not CAC.FontCache [fontName] then
		surface.CreateFont (fontName,
			{
				font      = font,
				size      = size,
				weight    = bold and 800 or 500,
				blursize  = 0,
				scanlines = 0,
				antialias = true,
				underline = false,
				italic    = italic,
				strikeout = false,
				symbol    = false,
				rotary    = false,
				shadow    = false,
				additive  = false,
				outline   = false
			}
		)
		CAC.FontCache [fontName] = fontName
	end
	
	return CAC.FontCache [fontName]
end