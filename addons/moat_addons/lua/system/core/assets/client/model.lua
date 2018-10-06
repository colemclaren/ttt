function cdn.Model(mdl, pnl)
	pnl.ModelPanel = vgui.Create("DButton", pnl)
	pnl.ModelPanel:SetPos(0, 0)
	pnl.ModelPanel:SetSize(64, 64)
	pnl.ModelPanel:SetText ""
	pnl.ModelPanel.Paint = function() end

	cdn.ModelIcon(mdl, function(img)
		if (IsValid(pnl.ModelPanel)) then
			pnl.ModelPanel:SetImage(img)
			pnl.ModelPanel:SetVisible(true)
		end
	end)
end