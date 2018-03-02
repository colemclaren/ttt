local self, info = CAC.Detections:RegisterDetection ("BlacklistedModule", CAC.ReasonArrayDetection)

info:SetName ("Blacklisted Module")
info:SetKickName ("Cheating (1)")
info:SetDescription ("Indicates that a binary module with a blacklisted name has been found to be loaded into a client's game.")

info:SetDeprecated (true)

info:SetDefaultResponse            (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )

function self:ctor ()
end