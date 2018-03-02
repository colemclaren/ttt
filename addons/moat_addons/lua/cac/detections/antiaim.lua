local self, info = CAC.Detections:RegisterDetection ("AntiAim", CAC.ReasonArrayDetection)

info:SetName ("Anti-Aim")
info:SetKickName ("Cheating (4)")
info:SetDescription ("Occurs when player eye angles are outside the normal range.\nThis could be an attempt to mess up hitboxes to make it difficult for other players to hit them.\nThis could also be due to other scripts setting the player's eye angles.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end