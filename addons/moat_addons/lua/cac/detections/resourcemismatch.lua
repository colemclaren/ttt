local self, info = CAC.Detections:RegisterDetection ("ResourceMismatch", CAC.ReasonArrayDetection)

info:SetName ("Resource Mismatch")
info:SetKickName ("resource mismatch (validate your game files)")
info:SetDescription ("Occurs when a client's game resources do not match the server's.")

info:SetDeprecated (true)

info:SetDefaultResponse            (CAC.DetectionResponse.Ignore, CAC.DetectionResponse.Ignore)
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end
