local self, info = CAC.Detections:RegisterDetection ("SeedManipulation", CAC.ReasonArrayDetection)

info:SetName ("Seed Manipulation")
info:SetKickName ("Cheating (2)")
info:SetDescription ("Occurs when player command numbers are manipulated.\nThis could indicate an attempt to manipulate the spread of shots or may be due to extreme lag and bad luck.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end