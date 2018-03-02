local self = {}
CAC.LiveIncidentSender = CAC.MakeConstructor (self, CAC.ObjectSender)

function self:ctor (ply, object)
end

function self:HandleAbortResponse (inBuffer)
	if not CAC.Permissions.PlayerHasPermission (self:GetPlayer (), "ViewMenu") then return end
	
	self:GetObject ():AbortResponse (self:GetPlayer ())
end

function self:HookObject (liveIncident)
	if not liveIncident then return end
	
	liveIncident:AddEventListener ("PlayerChanged", "CAC.LiveIncidentSender." .. self:GetHashCode (),
		function (_, ply)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("PlayerChanged")
			
			if ply and ply:IsValid () then
				outBuffer:Boolean (true)
				outBuffer:UInt32 (ply:UserID ())
			else
				outBuffer:Boolean (false)
				outBuffer:UInt32 (0)
			end
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	liveIncident:AddEventListener ("ResponseCountdownChanged", "CAC.LiveIncidentSender." .. self:GetHashCode (),
		function (_, countdown)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("ResponseCountdownChanged")
			liveIncident:GetResponseCountdown ():Serialize (outBuffer)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
	
	liveIncident:AddEventListener ("ReviewedByAdminChanged", "CAC.LiveIncidentSender." .. self:GetHashCode (),
		function (_, reviewedByAdmin)
			local outBuffer = self:DispatchEvent ("CreateOutBuffer") or CAC.StringOutBuffer ()
			outBuffer:StringN8  ("ReviewedByAdminChanged")
			outBuffer:Boolean   (reviewedByAdmin)
			self:DispatchEvent  ("DispatchPacket", outBuffer)
		end
	)
end

function self:UnhookObject (liveIncident)
	if not liveIncident then return end
	
	liveIncident:RemoveEventListener ("PlayerChanged",            "CAC.LiveIncidentSender." .. self:GetHashCode ())
	liveIncident:RemoveEventListener ("ResponseCountdownChanged", "CAC.LiveIncidentSender." .. self:GetHashCode ())
	liveIncident:RemoveEventListener ("ReviewedByAdminChanged",   "CAC.LiveIncidentSender." .. self:GetHashCode ())
end
