local self, info = CAC.Detections:RegisterDetection ("AnticheatTruthEngineering", CAC.ReasonArrayDetection)

info:SetName ("Anticheat Truth Engineering")
info:SetKickName ("Anticheat Truth Engineering (0)")
info:SetDescription ("Occurs when functions the anticheat uses are tampered with to return invalid data, or unsolicited data is received from a client.\nThis could indicate a failed anticheat bypass attempt.")

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end