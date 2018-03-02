local self, info = CAC.Detections:RegisterDetection ("AnticheatCheckFailure", CAC.ReasonArrayDetection)

info:SetName ("Anticheat Check Failure")
info:SetKickName ("Anticheat Truth Engineering (1)")
info:SetDescription ("Occurs when an anticheat check unexpectedly could not be carried out.")

info:SetDefaultResponse            (CAC.DetectionResponse.Ignore, CAC.DetectionResponse.Ignore)
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Ignore, CAC.DetectionResponse.Ignore)
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end