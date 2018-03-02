function CAC.UserWhitelistListBoxMenu (self)
	local menu = CAC.Menu ()
	
	menu:AddEventListener ("MenuOpening",
		function (_, selectedItems)
			local userCount  = 0
			local groupCount = 0
			
			for i = 1, #selectedItems do
				local whitelistEntry = selectedItems [i]:GetControl ():GetWhitelistEntry ()
				local actorReference = whitelistEntry:GetActorReference ()
				
				if actorReference:IsUserReference () then
					userCount  = userCount  + 1
				elseif actorReference:IsGroupReference () then
					groupCount = groupCount + 1
				end
			end
			
			local plural      = #selectedItems ~= 1
			local groupPlural = groupCount     ~= 1
			local userPlural  = userCount      ~= 1
			
			menu:GetItemById ("Copy name"             ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam ID"         ):SetEnabled (userCount      > 0)
			menu:GetItemById ("Copy Steam profile URL"):SetEnabled (userCount      > 0)
			menu:GetItemById ("Copy entry"            ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Remove"                ):SetEnabled (#selectedItems > 0)
			
			menu:GetItemById ("Copy name"             ):SetText ("Copy name"              .. (plural     and "s"   or "" ))
			menu:GetItemById ("Copy Steam ID"         ):SetText ("Copy Steam ID"          .. (userPlural and "s"   or "" ))
			menu:GetItemById ("Copy Steam profile URL"):SetText ("Copy Steam profile URL" .. (userPlural and "s"   or "" ))
			menu:GetItemById ("Copy entry"            ):SetText ("Copy entr"              .. (plural     and "ies" or "y"))
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
			local actorReference = control:GetWhitelistEntry ():GetActorReference ()
			if actorReference:IsUserReference () then
				return actorReference:GetDisplayName ()
			elseif actorReference:IsGroupReference () then
				return actorReference:GetGroupDisplayName ()
			end
		end
	)
	
	AddCopyButton ("Copy Steam ID",
		function (control)
			local actorReference = control:GetWhitelistEntry ():GetActorReference ()
			if not actorReference:IsUserReference () then return nil end
			
			return actorReference:GetUserId ()
		end
	)
	
	AddCopyButton ("Copy Steam profile URL",
		function (control)
			local actorReference = control:GetWhitelistEntry ():GetActorReference ()
			if not actorReference:IsUserReference () then return nil end
			
			return "https://steamcommunity.com/profiles/" .. CAC.SteamIdToCommunityId (actorReference:GetUserId ())
		end
	)
	
	menu:AddSeparator ()
	
	AddCopyButton ("Copy entry",
		function (control)
			local whitelistStatus = control:GetWhitelistEntry ():GetWhitelistStatus ()
			local actorReference  = control:GetWhitelistEntry ():GetActorReference ()
			
			if actorReference:IsUserReference () then
				return actorReference:ToString () .. ", " ..
				       actorReference:GetDisplayName () .. ", " ..
				       (CAC.WhitelistStatus [whitelistStatus] or whitelistStatus)
			elseif actorReference:IsGroupReference () then
				return actorReference:ToString () .. ", " ..
				       actorReference:GetDisplayName () .. ", " ..
				       (CAC.WhitelistStatus [whitelistStatus] or whitelistStatus)
			end
		end
	)
	
	menu:AddSeparator ()
	
	menu:AddItem ("Remove")
		:SetIcon ("icon16/delete.png")
		:AddEventListener ("Click",
			function (_, selectedItems)
				for i = 1, #selectedItems do
					selectedItems [i]:GetListBox ():GetUserWhitelist ():DispatchEvent ("RemoveEntry", selectedItems [i]:GetControl ():GetWhitelistEntry ())
				end
			end
		)
	
	return menu
end