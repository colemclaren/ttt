local self, info = CAC.Detections:RegisterDetection ("ProbableClientsideLuaExecution", CAC.ReasonArrayDetection)

info:SetName ("Probable Clientside Lua Execution")
info:SetDescription ("Occurs when the anticheat suspects a client has executed lua code not provided by the server, but cannot reliably determine it.")

info:SetDeprecated (true)

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Ignore)
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Ignore)
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Ignore)

function self:ctor ()
end