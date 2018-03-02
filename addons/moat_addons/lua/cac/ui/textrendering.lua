function CAC.DrawHighlightedText (text, highlightSubstring, r, g, b, a)
	surface.SetTextColor (r, g, b, a)
	
	if highlightSubstring and
	   #highlightSubstring > 0 then
		local position = 1
		while position <= #text do
			local success, startPosition, endPosition = CAC.UTF8.MatchTransliteration (text, highlightSubstring, position)
			if success then
				surface.SetTextColor (r, g, b, a)
				surface.DrawText (string.sub (text, position, startPosition - 1))
				surface.SetTextColor (CAC.Colors.Red)
				surface.DrawText (string.sub (text, startPosition, endPosition))
				position = endPosition + 1
			else
				surface.SetTextColor (r, g, b, a)
				surface.DrawText (string.sub (text, position))
				position = #text + 1
			end
		end
	else
		surface.DrawText (text)
	end
end