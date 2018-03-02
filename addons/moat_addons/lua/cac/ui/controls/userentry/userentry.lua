local _R = debug.getregistry ()

local self = {}

--[[
	Events:
		ActorReferenceChanged (IActorReference actorReference)
			Fired when the selected ActorReference has changed.
]]

function self:Init ()
	self:SetFont (CAC.Font ("Roboto", 18))
	self:SetHelpTextFont (CAC.Font ("Roboto", 18, false, true))
	
	self:SetHelpText ("Steam ID or group name")
	
	self:SetKeyboardMap (CAC.UserEntryKeyboardMap)
	
	self.LastFocusKillTime = nil
	
	self.SuggestionFrame = nil
	
	self.ActorReference = nil
	
	self:AddEventListener ("GotFocus",
		function (_)
			self:OpenSuggestionFrame ()
		end
	)
	
	self:AddEventListener ("TextChanged",
		function (_)
			if self:IsFocused () then
				self:OpenSuggestionFrame ()
				
				if self:GetSuggestionFrame () and
				   self:GetSuggestionFrame ():IsVisible () then
					self:GenerateSuggestions (self:GetText ())
				end
			end
			
			self:SetActorReference (CAC.IActorReference.FromString (self:GetText ()))
		end
	)
end

function self:DrawTextEntryText (textColor, highlightColor, caretColor)
	if (self:IsFocused () and self.LastFocusKillTime ~= CurTime ()) or
	   not self:GetActorReference () then
		_R.Panel.DrawTextEntryText (self, textColor, highlightColor, caretColor)
	else
		local text1
		local text2
		
		if self.ActorReference:IsUserReference () then
			text1 = self.ActorReference:GetDisplayName ()
			text2 = self.ActorReference:GetUserId ()
		elseif self.ActorReference:IsGroupReference () then
			text1 = self.ActorReference:GetGroupDisplayName (self.ActorReference:GetGroupId ())
			if self.ActorReference:GetGroupSystem () then
				text2 = self.ActorReference:GetGroupSystem ():GetName () .. " group"
			else
				text2 = self.ActorReference:GetGroupSystemId () .. " group"
			end
		end
		text2 = "(" .. text2 .. ")"
		
		surface.SetFont (self:GetFont ())
		local text1Width, text1Height = surface.GetTextSize (text1)
		surface.SetTextColor (textColor)
		surface.SetTextPos (3, 0.5 * (self:GetHeight () - text1Height))
		surface.DrawText (text1)
		
		surface.SetFont (CAC.Font ("Roboto", 14))
		local text2Width, text2Height = surface.GetTextSize (text2)
		surface.SetTextColor (CAC.Colors.Gray)
		surface.SetTextPos (3 + text1Width + 4, 0.5 * (self:GetHeight () - text2Height) + 1)
		surface.DrawText (text2)
	end
end

function self:OnRemoved ()
	if self:GetSuggestionFrame () then
		self.SuggestionFrame:Remove ()
		self.SuggestionFrame = nil
	end
end

function self:GetActorReference ()
	return self.ActorReference
end

function self:SetActorReference (actorReference)
	if self.ActorReference == actorReference then return self end
	
	self.ActorReference = actorReference
	
	if self.ActorReference then
		self:SetTextColor (CAC.Colors.Green)
	else
		self:SetTextColor (CAC.Colors.Black)
	end
	
	self:DispatchEvent ("ActorReferenceChanged", self.ActorReference)
	
	return self
end

function self:GetSuggestionFrame ()
	if self.SuggestionFrame and not self.SuggestionFrame:IsValid () then
		self.SuggestionFrame = nil
	end
	
	return self.SuggestionFrame
end

-- Internal, do not call
function self:CommitSuggestion (actorReference)
	self:SetActorReference (actorReference)
	if actorReference then
		if self.ActorReference:IsUserReference () then
			self:SetText (self.ActorReference:GetUserId ())
		elseif self.ActorReference:IsGroupReference () then
			self:SetText (self.ActorReference:ToString ())
		end
		
		self:SetCaretPos (CAC.UTF8.Length (self:GetText ()))
	end
	
	if self:GetSuggestionFrame () then
		self:GetSuggestionFrame ():SetVisible (false)
	end
	
	self:KillFocus ()
	self.LastFocusKillTime = CurTime ()
end

function self:CreateSuggestionFrame ()
	if self:GetSuggestionFrame () then return end
	
	-- self:Create is not used, since that parents the suggestion frame to us
	-- which we don't want, since it'll steal our keyboard focus.
	self.SuggestionFrame = vgui.Create ("CACUserEntrySuggestionFrame")
	self.SuggestionFrame:SetControl (self)
	
	self.SuggestionFrame:AddEventListener ("ItemChosen",
		function (_, actorReference)
			self:CommitSuggestion (actorReference)
		end
	)
end

function self:OpenSuggestionFrame ()
	if not self:GetSuggestionFrame () then
		self:CreateSuggestionFrame ()
	end

	self.SuggestionFrame:SetVisible (true)
	self.SuggestionFrame:SetPos (self:LocalToScreen (-4, self:GetHeight ()))
	self.SuggestionFrame:SetSize (self:GetWidth () + 8, 400)

	self:GenerateSuggestions (self:GetText ())
end

function self:GenerateSuggestions (searchText)
	searchText = string.Trim (searchText)
	
	self.SuggestionFrame:Clear ()
	
	local actorReference = CAC.IActorReference.FromString (string.Trim (searchText))
	if actorReference then
		self.SuggestionFrame:AddActorReference (actorReference)
	end
	
	-- Group suggestions
	for groupSystem in CAC.SystemRegistry:GetSystemEnumerator ("GroupSystem") do
		if groupSystem:IsAvailable () then
			self:GenerateGroupSuggestions (groupSystem, searchText)
		end
	end
	
	-- User suggestions
	self:GenerateUserSuggestions (searchText)
	
	if not self.SuggestionFrame:IsEmpty () then
		self.SuggestionFrame:SelectByIndex (1)
	end
end

function self:GenerateUserSuggestions (searchText)
	local lowercaseSearchText = string.lower (searchText)
	
	for _, ply in ipairs (player.GetAll ()) do
		if not ply:IsBot () then
			if string.find (string.lower (ply:SteamID ()), lowercaseSearchText, 1, true) or
			   CAC.UTF8.MatchTransliteration (ply:Nick (), searchText) then
				self.SuggestionFrame:AddActorReference (CAC.UserReference (ply:SteamID ()))
			end
		end
	end
end

function self:GenerateGroupSuggestions (groupSystem, searchText)
	local lowercaseSearchText = string.lower (searchText)
	
	for groupId in groupSystem:GetGroupEnumerator () do
		if string.find (string.lower (groupId), lowercaseSearchText, 1, true) or
		   string.find (string.lower (groupSystem:GetGroupDisplayName (groupId)), lowercaseSearchText, 1, true) or
		   string.find (string.lower (groupSystem:GetName ()), lowercaseSearchText, 1, true) or
		   string.find (string.lower (groupSystem:GetId () .. "/" .. groupId), lowercaseSearchText, 1, true) then
			self.SuggestionFrame:AddActorReference (CAC.GroupReference (groupSystem:GetId (), groupId))
		end
	end
end

CAC.Register ("CACUserEntry", self, "CACTextEntry")