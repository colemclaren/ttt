local self, info = CAC.Detections:RegisterDetection ("AutoBunnyHop", CAC.ReasonArrayDetection)

info:SetName ("Auto Bunny Hop")
info:SetKickName ("Auto Bhop")
info:SetDescription ("Occurs when the player bunny hops perfectly 8 times in a row.")

info:SetDefaultResponse            (CAC.DetectionResponse.Ignore, CAC.DetectionResponse.Ignore)
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end