function CAC.LuaScanResultListBoxMenu (self)
	local menu = CAC.Menu ()
	
	menu:AddEventListener ("MenuOpening",
		function (_, selectedItems)
			local entryCount              = 0
			local commentCount            = 0
			local patchableCount          = 0
			local patchableUnpatchedCount = 0
			
			for i = 1, #selectedItems do
				local luaScanResultEntry = selectedItems [i]:GetControl ():GetLuaScanResultEntry ()
				if luaScanResultEntry then
					entryCount = entryCount + 1
					if luaScanResultEntry:GetLuaSignature ():GetComment () then
						commentCount = commentCount + 1
					end
					if luaScanResultEntry:IsPatchable () then
						patchableCount = patchableCount + 1
						if not luaScanResultEntry:IsPatched () then
							patchableUnpatchedCount = patchableUnpatchedCount + 1
						end
					end
				end
			end
			
			local plural                   = entryCount              ~= 1
			local patchablePlural          = patchableCount          ~= 1
			local patchableUnpatchedPlural = patchableUnpatchedCount ~= 1
			
			menu:GetItemById ("Copy name"   ):SetEnabled (entryCount > 0)
			menu:GetItemById ("Copy path"   ):SetEnabled (entryCount > 0)
			menu:GetItemById ("Copy hash"   ):SetEnabled (entryCount > 0)
			menu:GetItemById ("Copy comment"):SetEnabled (entryCount > 0)
			menu:GetItemById ("Copy code"   ):SetEnabled (entryCount > 0)
			menu:GetItemById ("Copy entry"  ):SetEnabled (entryCount > 0)
			
			menu:GetItemById ("Run patch"   ):SetEnabled (patchableUnpatchedCount > 0)
			
			menu:GetItemById ("Copy name"   ):SetText ("Copy name"    .. (entryCount              > 1 and "s"   or ""  ))
			menu:GetItemById ("Copy path"   ):SetText ("Copy path"    .. (entryCount              > 1 and "s"   or ""  ))
			menu:GetItemById ("Copy hash"   ):SetText ("Copy hash"    .. (entryCount              > 1 and "es"  or ""  ))
			menu:GetItemById ("Copy comment"):SetText ("Copy comment" .. (commentCount            > 1 and "es"  or ""  ))
			menu:GetItemById ("Copy entry"  ):SetText ("Copy entr"    .. (entryCount              > 1 and "ies" or "y" ))
			
			menu:GetItemById ("Run patch"   ):SetText ("Run patch"    .. (patchableUnpatchedCount > 1 and "es"  or ""  ))
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
	
	local function GetQualifiedIdentifier (luaScanResultEntry)
		local name = luaScanResultEntry:GetName ()
		
		if luaScanResultEntry:IsNetReceiver () then
			return "net.Receivers" .. (CAC.Lua.IsValidVariableName (name) and ("." .. name) or (" [\"" .. CAC.String.EscapeNonprintable (name) .. "\"]"))
		elseif luaScanResultEntry:IsConsoleCommand () then
			return "concommand.GetTable ()" .. (CAC.Lua.IsValidVariableName (name) and ("." .. name) or (" [\"" .. CAC.String.EscapeNonprintable (name) .. "\"]"))
		elseif luaScanResultEntry:IsHook () then
			local eventName = luaScanResultEntry:GetEventName ()
			return "hook.GetTable ()" ..
				   (CAC.Lua.IsValidVariableName (eventName) and ("." .. eventName) or (" [\"" .. CAC.String.EscapeNonprintable (eventName) .. "\"]")) ..
				   (CAC.Lua.IsValidVariableName (name     ) and ("." .. name     ) or (" [\"" .. CAC.String.EscapeNonprintable (name     ) .. "\"]"))
		end
		
		return nil
	end
	
	AddCopyButton ("Copy name",
		function (control)
			local luaScanResultEntry = control:GetLuaScanResultEntry ()
			if not luaScanResultEntry then return nil end
			return GetQualifiedIdentifier (luaScanResultEntry)
		end
	)
	
	AddCopyButton ("Copy path",
		function (control)
			local luaScanResultEntry = control:GetLuaScanResultEntry ()
			if not luaScanResultEntry then return nil end
			return luaScanResultEntry:GetLuaSnapshotEntry ():GetFormattedLocation ()
		end
	)
	
	AddCopyButton ("Copy hash",
		function (control)
			local luaScanResultEntry = control:GetLuaScanResultEntry ()
			if not luaScanResultEntry then return nil end
			return string.format ("%08x", luaScanResultEntry:GetLuaSnapshotEntry ():GetHash ())
		end
	)
	
	AddCopyButton ("Copy comment",
		function (control)
			local luaScanResultEntry = control:GetLuaScanResultEntry ()
			if not luaScanResultEntry then return nil end
			return luaScanResultEntry:GetLuaSignature ():GetComment ()
		end
	)
	
	AddCopyButton ("Copy code",
		function (control)
			local luaScanResultEntry = control:GetLuaScanResultEntry ()
			if not luaScanResultEntry then return nil end
			return "-- " .. luaScanResultEntry:GetLuaSnapshotEntry ():GetFormattedLocation () .. "\n" .. luaScanResultEntry:GetLuaSnapshotEntry ():GetCode ()
		end
	)
	
	menu:AddSeparator ()
	
	AddCopyButton ("Copy entry",
		function (control)
			local luaScanResultEntry = control:GetLuaScanResultEntry ()
			if not luaScanResultEntry then return nil end
			return GetQualifiedIdentifier (luaScanResultEntry) .. ", " ..
			       luaScanResultEntry:GetLuaSnapshotEntry ():GetFormattedLocation () .. ", " ..
			       string.format ("%08x", luaScanResultEntry:GetHash ()) .. ", " ..
			       (CAC.LuaEntryPointClass [luaScanResultEntry:GetLuaSignature ():GetClass ()] or "Unknown") .. ", " ..
			       (luaScanResultEntry:GetLuaSignature ():GetAddonName () or "Unknown addon") .. ", " ..
			       (luaScanResultEntry:GetLuaSignature ():GetComment () or "")
		end
	)
	
	menu:AddSeparator ()
	
	menu:AddItem ("Run patch")
		:SetIcon ("icon16/delete.png")
		:AddEventListener ("Click",
			function (_, selectedItems)
				for i = 1, #selectedItems do
					local luaScanResultEntry = selectedItems [i]:GetControl ():GetLuaScanResultEntry ()
					if luaScanResultEntry then
						luaScanResultEntry:DispatchEvent ("ApplyPatch")
					end
				end
			end
		)
	
	return menu
end