local self, info = CAC.Detections:RegisterDetection ("Speedhack", CAC.ReasonArrayDetection)

info:SetName ("Speedhack")
info:SetKickName ("Speedhack (please rejoin if this is incorrect)")
info:SetDescription ("Occurs when a client sends movement commands at a higher rate than expected.\nThis could be a speedhack attempt or a result of lag.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end