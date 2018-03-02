local self, info = CAC.Detections:RegisterDetection ("AnticheatTruthTimeout", CAC.ReasonArrayDetection)

info:SetName ("Anticheat Timeout")
info:SetKickName ("Anticheat Truth Engineering (2)")
info:SetDescription ("Occurs when a client does not reply to an anticheat data request, while continuing to send movement commands to the server.\nThis could also occur if the player is lagging heavily and unlucky enough.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  ) 
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end
