local self = {}
CAC.MoveHandler = CAC.MakeConstructor (self)

function self:ctor ()
	CAC:AddEventListener ("Initialize", "CAC.MoveHandler",
		function ()
			CAC.Settings:GetSettingsGroup ("DetectorSettings"):AddEventListener ("Changed", "CAC.MoveHandler",
				function ()
					self:Initialize ()
				end
			)
			
			self:Initialize ()
		end
	)
end

function self:dtor ()
	hook.Remove ("SetupMove", "CAC.MoveHandler")
	CAC.Settings:GetSettingsGroup ("DetectorSettings"):RemoveEventListener ("Changed", "CAC.MoveHandler")
	CAC:RemoveEventListener ("Initialize", "CAC.MoveHandler")
end

-- Internal, do not call
function self:Initialize ()
	hook.Remove ("SetupMove", "CAC.MoveHandler")
	
	local code = "hook.Add (\"SetupMove\", \"CAC.MoveHandler\",\n"
	code = code .. "\tfunction (ply, moveData, userCmd)\n"
	code = code .. "\t\tCAC.TimeoutDetector:OnSetupMove (ply, moveData, userCmd)\n"
	
	for detectorName in CAC.Settings:GetSettingsGroup ("DetectorSettings"):GetDetectorEnumerator () do
		if CAC [detectorName] and CAC.Settings:GetSettingsGroup ("DetectorSettings"):IsDetectorEnabled (detectorName) then
			CAC [detectorName]:Reset ()
			code = code .. "\t\tCAC." .. detectorName .. ":OnSetupMove (ply, moveData, userCmd)\n"
		end
	end
	
	code = code .. "\tend\n"
	code = code .. ")\n"
	
	RunStringEx (code, "CAC.MoveHandler")
end

CAC.MoveHandler = CAC.MoveHandler ()
CAC:AddEventListener ("Unloaded",
	function ()
		CAC.MoveHandler:dtor ()
	end
)