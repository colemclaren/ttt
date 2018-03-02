local self, info = CAC.Detections:RegisterDetection ("AntiScreenshot", CAC.ReasonArrayDetection)

info:SetName ("Anti-Screenshot")
info:SetKickName ("Anti-screenshot (please rejoin if this is incorrect)")
info:SetDescription ("Occurs when screen capturing returns incorrect data on a client.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end