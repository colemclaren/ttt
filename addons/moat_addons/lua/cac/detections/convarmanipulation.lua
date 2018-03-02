local self, info = CAC.Detections:RegisterDetection ("ConVarManipulation", CAC.ReasonArrayDetection)

info:SetName ("Console Variable Manipulation")
info:SetDescription ("Occurs when a client's value of sv_allowcslua and sv_cheats does not match the server's.\nThis could happen due to a bad connection.\nAlso occurs when these convars have been tampered with.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end