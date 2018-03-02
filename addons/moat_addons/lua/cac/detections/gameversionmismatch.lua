local self, info = CAC.Detections:RegisterDetection ("GameVersionMismatch", CAC.ReasonArrayDetection)

info:SetName ("Game Version Mismatch")
info:SetKickName ("Game Version Mismatch (update your game or tell the server owner to update)")
info:SetDescription ("Occurs when the server's game version does not match the player's, so some anticheat checks can't be done.")

info:SetDefaultResponse            (CAC.DetectionResponse.Ignore, CAC.DetectionResponse.Ignore)
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end