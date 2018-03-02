function CAC.IncidentListBoxMenu (self)
	local menu = CAC.Menu ()
	
	menu:AddEventListener ("MenuOpening",
		function (_, selectedItems)
			local plural = #selectedItems ~= 1
			
			menu:GetItemById ("Copy name"             ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam ID"         ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam profile URL"):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy IP address"       ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy incident ID"      ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy detection list"   ):SetEnabled (#selectedItems == 1)
			
			menu:GetItemById ("Copy name"             ):SetText ("Copy name"              .. (plural and "s"  or ""))
			menu:GetItemById ("Copy Steam ID"         ):SetText ("Copy Steam ID"          .. (plural and "s"  or ""))
			menu:GetItemById ("Copy Steam profile URL"):SetText ("Copy Steam profile URL" .. (plural and "s"  or ""))
			menu:GetItemById ("Copy IP address"       ):SetText ("Copy IP address"        .. (plural and "es" or ""))
			menu:GetItemById ("Copy incident ID"      ):SetText ("Copy incident ID"       .. (plural and "s"  or ""))
			
			local canAbortResponse         = false
			local hasAbortableKickResponse = false
			local hasAbortableBanResponse  = false
			for i = 1, #selectedItems do
				if selectedItems [i]:GetControl ():GetLiveIncident () then
					local liveIncident = selectedItems [i]:GetControl ():GetLiveIncident ()
					local incident     = selectedItems [i]:GetControl ():GetIncident     ()
					canAbortResponse = canAbortResponse or liveIncident:CanAbortResponse ()
					hasAbortableKickResponse = hasAbortableKickResponse or incident:GetResponse () == CAC.DetectionResponse.Kick
					hasAbortableBanResponse  = hasAbortableBanResponse  or incident:GetResponse () == CAC.DetectionResponse.Ban
				end
			end
			
			if not hasAbortableKickResponse and not hasAbortableBanResponse then
				for i = 1, #selectedItems do
					if selectedItems [i]:GetControl ():GetIncident () then
						local incident     = selectedItems [i]:GetControl ():GetIncident     ()
						hasAbortableKickResponse = hasAbortableKickResponse or incident:GetResponse () == CAC.DetectionResponse.Kick
						hasAbortableBanResponse  = hasAbortableBanResponse  or incident:GetResponse () == CAC.DetectionResponse.Ban
					end
				end
			end
			
			menu:GetItemById ("Abort response"):SetEnabled (canAbortResponse)
			if not hasAbortableKickResponse and not hasAbortableBanResponse then
				menu:GetItemById ("Abort response"):SetText ("Abort ban")
			elseif not hasAbortableKickResponse and hasAbortableBanResponse then
				menu:GetItemById ("Abort response"):SetText ("Abort ban")
			elseif hasAbortableKickResponse and not hasAbortableBanResponse then
				menu:GetItemById ("Abort response"):SetText ("Abort kick")
			else
				menu:GetItemById ("Abort response"):SetText ("Abort kick / ban")
			end
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
			return control:GetIncident ():GetPlayerName ()
		end
	)
	
	AddCopyButton ("Copy Steam ID",
		function (control)
			return control:GetIncident ():GetPlayerSteamId ()
		end
	)
	
	AddCopyButton ("Copy Steam profile URL",
		function (control)
			if not control:GetIncident ():GetPlayerSession () then
				return "https://steamcommunity.com/profiles/" .. CAC.SteamIdToCommunityId (control:GetIncident ():GetPlayerSteamId ())
			end
			return "https://steamcommunity.com/profiles/" .. control:GetIncident ():GetPlayerSession ():GetAccountInformation ():GetCommunityId ()
		end
	)
	
	AddCopyButton ("Copy IP address",
		function (control)
			if not control:GetIncident ():GetPlayerSession () then return "[IP address not available]" end
			return CAC.IPToString (control:GetIncident ():GetPlayerSession ():GetLocationInformation ():GetIP ())
		end
	)
	
	menu:AddSeparator ()
	
	AddCopyButton ("Copy detection list",
		function (control)
			if not control:GetIncident ():GetPlayerSession () then return nil end
			if not control:GetIncident ():GetPlayerSession ():HasDetections () then return nil end
			
			return control:GetIncident ():GetPlayerSession ():GetDetectionListText ()
		end
	)
	
	AddCopyButton ("Copy incident ID",
		function (control)
			return control:GetIncident ():GetQualifiedIncidentId ()
		end
	)
	
	menu:AddSeparator ()
	
	menu:AddItem ("Abort response")
		:SetIcon ("icon16/clock_stop.png")
		:AddEventListener ("Click",
			function (_, selectedItems)
				for i = 1, #selectedItems do
					if selectedItems [i]:GetControl ():GetLiveIncident () and
					   selectedItems [i]:GetControl ():GetLiveIncident ():CanAbortResponse () then
						local liveIncident = selectedItems [i]:GetControl ():GetLiveIncident ()
						liveIncident:DispatchEvent ("AbortResponse")
					end
				end
			end
		)
	
	return menu
end