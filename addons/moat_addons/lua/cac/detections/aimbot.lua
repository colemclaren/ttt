local self, info = CAC.Detections:RegisterDetection ("Aimbot", CAC.ReasonArrayDetection)

info:SetName ("Aimbot")
info:SetKickName ("Cheating (6)")
info:SetDescription ("Occurs when the player makes movements that could be the result of using an aimbot. Lag spikes may be confused for aimbot snapping in some cases.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end