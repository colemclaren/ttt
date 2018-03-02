local self, info = CAC.Detections:RegisterDetection ("ClientsideLuaExecution", CAC.ReasonArrayDetection)

info:SetName ("Clientside Lua Execution")
info:SetDescription ("Occurs when a client has executed lua code that has not been provided by the server.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Ignore) -- Default to kick for now due to networking corruption issues.
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ignore)
info:SetRecommendedResponse        (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ignore)
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ignore)

function self:ctor ()
end