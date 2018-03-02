function CAC.PlayerListBoxMenu (self)
	local menu = CAC.Menu ()
	
	menu:AddEventListener ("MenuOpening",
		function (_, selectedItems)
			local plural = #selectedItems ~= 1
			
			menu:GetItemById ("Copy name"             ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam ID"         ):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy Steam profile URL"):SetEnabled (#selectedItems > 0)
			menu:GetItemById ("Copy IP address"       ):SetEnabled (#selectedItems > 0)
			
			local hasIncidents = false
			for i = 1, #selectedItems do
				if selectedItems [i]:GetControl ():GetPlayerSession () and
				   selectedItems [i]:GetControl ():GetPlayerSession ():GetIncident () then
					hasIncidents = true
					break
				end
			end
			menu:GetItemById ("Copy incident ID"      ):SetEnabled (hasIncidents)
			
			if #selectedItems == 1 and
			   selectedItems [1]:GetControl ():GetPlayerSession () and
			   selectedItems [1]:GetControl ():GetPlayerSession ():HasDetections () then
				menu:GetItemById ("Copy detection list"   ):SetEnabled (true)
			else
				menu:GetItemById ("Copy detection list"   ):SetEnabled (false)
			end
			
			menu:GetItemById ("Copy name"             ):SetText ("Copy name"              .. (plural and "s"  or ""))
			menu:GetItemById ("Copy Steam ID"         ):SetText ("Copy Steam ID"          .. (plural and "s"  or ""))
			menu:GetItemById ("Copy Steam profile URL"):SetText ("Copy Steam profile URL" .. (plural and "s"  or ""))
			menu:GetItemById ("Copy IP address"       ):SetText ("Copy IP address"        .. (plural and "es" or ""))
			menu:GetItemById ("Copy incident ID"      ):SetText ("Copy incident ID"       .. (plural and "s"  or ""))
			
			local canAbortResponse         = false
			local hasAbortableKickResponse = false
			local hasAbortableBanResponse  = false
			for i = 1, #selectedItems do
				if selectedItems [i]:GetControl ():GetLivePlayerSession () and
				   selectedItems [i]:GetControl ():GetLivePlayerSession ():GetLiveIncident () then
					local liveIncident = selectedItems [i]:GetControl ():GetLivePlayerSession ():GetLiveIncident ()
					local incident     = selectedItems [i]:GetControl ():GetPlayerSession     ():GetIncident     ()
					canAbortResponse = canAbortResponse or liveIncident:CanAbortResponse ()
					hasAbortableKickResponse = hasAbortableKickResponse or incident:GetResponse () == CAC.DetectionResponse.Kick
					hasAbortableBanResponse  = hasAbortableBanResponse  or incident:GetResponse () == CAC.DetectionResponse.Ban
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
			return control:GetPlayer ():GetName ()
		end
	)
	
	AddCopyButton ("Copy Steam ID",
		function (control)
			if control:GetPlayerSession () then
				return control:GetPlayerSession ():GetAccountInformation ():GetSteamId ()
			elseif control:GetPlayer () and
			       control:GetPlayer ():IsValid () then
				return control:GetPlayer ():SteamID ()
			else
				return "[Steam ID not available]"
			end
		end
	)
	
	AddCopyButton ("Copy Steam profile URL",
		function (control)
			if control:GetPlayerSession () then
				return "https://steamcommunity.com/profiles/" .. control:GetPlayerSession ():GetAccountInformation ():GetCommunityId ()
			elseif control:GetPlayer () and
			       control:GetPlayer ():IsValid () then
				return "https://steamcommunity.com/profiles/" .. control:GetPlayer ():SteamID64 ()
			else
				return "[Steam profile URL not available]"
			end
		end
	)
	
	AddCopyButton ("Copy IP address",
		function (control)
			if not control:GetPlayerSession () then return "[IP address not available]" end
			return CAC.IPToString (control:GetPlayerSession ():GetLocationInformation ():GetIP ())
		end
	)
	
	menu:AddSeparator ()
	
	AddCopyButton ("Copy detection list",
		function (control)
			if not control:GetPlayerSession () then return nil end
			if not control:GetPlayerSession ():HasDetections () then return nil end
			
			return control:GetPlayerSession ():GetDetectionListText ()
		end
	)
	
	AddCopyButton ("Copy incident ID",
		function (control)
			if not control:GetPlayerSession () then return nil end
			if not control:GetPlayerSession ():GetIncident () then return nil end
			
			return control:GetPlayerSession ():GetIncident ():GetQualifiedIncidentId ()
		end
	)
	
	menu:AddSeparator ()
	
	menu:AddItem ("Abort response")
		:SetIcon ("icon16/clock_stop.png")
		:AddEventListener ("Click",
			function (_, selectedItems)
				for i = 1, #selectedItems do
					if selectedItems [i]:GetControl ():GetLivePlayerSession () and
					   selectedItems [i]:GetControl ():GetLivePlayerSession ():GetLiveIncident () and
					   selectedItems [i]:GetControl ():GetLivePlayerSession ():GetLiveIncident ():CanAbortResponse () then
						local liveIncident = selectedItems [i]:GetControl ():GetLivePlayerSession ():GetLiveIncident ()
						liveIncident:DispatchEvent ("AbortResponse")
					end
				end
			end
		)
	
	return menu
end