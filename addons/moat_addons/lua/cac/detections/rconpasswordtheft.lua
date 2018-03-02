local self, info = CAC.Detections:RegisterDetection ("RconPasswordTheft", CAC.ReasonArrayDetection)

info:SetName ("RCON Password Theft")
info:SetKickName ("Cheating (5)")
info:SetDescription ("Occurs when a client downloads the server's .cfg file containing the RCON password.")

info:SetDefaultResponse            (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )

function self:ctor ()
end