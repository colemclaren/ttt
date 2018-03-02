function CAC.UserBlacklistListBoxMenu (self)
	local menu = CAC.Menu ()
	
	menu:AddEventListener ("MenuOpening",
		function (_, selectedItems)
			local plural = #selectedItems ~= 1
			
			menu:GetItemById ("Copy name"             ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam ID"         ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam profile URL"):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy reason"           ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy entry"            ):SetEnabled (#selectedItems > 0)
			
			menu:GetItemById ("Copy name"             ):SetText ("Copy name"              .. (plural and "s"   or "" ))
			menu:GetItemById ("Copy Steam ID"         ):SetText ("Copy Steam ID"          .. (plural and "s"   or "" ))
			menu:GetItemById ("Copy Steam profile URL"):SetText ("Copy Steam profile URL" .. (plural and "s"   or "" ))
			menu:GetItemById ("Copy reason"           ):SetText ("Copy reason"            .. (plural and "s"   or "" ))
			menu:GetItemById ("Copy entry"            ):SetText ("Copy entr"              .. (plural and "ies" or "y"))
		end
	)
	
	local function AddCopyButton (name, lineGenerator)
		local function GenerateText ()
			local lines = {}
			
			local selectedItems = self:GetSelectedItems ()
			for i = 1, #selectedItems do
				lines [#lines + 1] = lineGenerator (selectedItems [i]:GetControl ())
			end
			
			return table.concat (lines, "\n")
		end
		menu:AddItem (name)
			:SetIcon ("icon16/page_copy.png")
			:AddEventListener ("Click",
				function (_, selectedItems)
					CAC.Clipboard:SetText (GenerateText ())
				end
			)
			:AddEventListener ("MouseEnter",
				function (self)
					self:SetToolTipText (GenerateText ())
				end
			)
	end
	
	AddCopyButton ("Copy name",
		function (control)
			local blacklistEntry = control:GetBlacklistEntry ()
			return blacklistEntry:GetDisplayName ()
		end
	)
	
	AddCopyButton ("Copy Steam ID",
		function (control)
			local blacklistEntry = control:GetBlacklistEntry ()
			return blacklistEntry:GetSteamId ()
		end
	)
	
	AddCopyButton ("Copy Steam profile URL",
		function (control)
			local blacklistEntry = control:GetBlacklistEntry ()
			return "https://steamcommunity.com/profiles/" .. CAC.SteamIdToCommunityId (blacklistEntry:GetSteamId ())
		end
	)
	
	AddCopyButton ("Copy reason",
		function (control)
			local blacklistEntry = control:GetBlacklistEntry ()
			return blacklistEntry:GetReason ()
		end
	)
	
	menu:AddSeparator ()
	
	AddCopyButton ("Copy entry",
		function (control)
			local blacklistEntry = control:GetBlacklistEntry ()
			return blacklistEntry:GetDisplayName () .. ", " ..
			       blacklistEntry:GetSteamId () .. ", " ..
			       "https://steamcommunity.com/profiles/" .. CAC.SteamIdToCommunityId (blacklistEntry:GetSteamId ()) .. ", " ..
			       blacklistEntry:GetReason ()
		end
	)
	
	return menu
end