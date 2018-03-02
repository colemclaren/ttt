local self, info = CAC.Detections:RegisterDetection ("ILuaInterfaceDetours", CAC.ReasonArrayDetection)

info:SetName ("ILuaInterface Detours")
info:SetKickName ("Cheating (0)")
info:SetDescription ("Occurs when the anticheat finds evidence of a lua file stealer or pre-initialization lua injector.\nFalse positives may happen in the unlikely event of bad RAM or memory corruption.")

info:SetDeprecated (true)

info:SetDefaultResponse            (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumAllowedResponse     (CAC.DetectionResponse.Ban,    CAC.DetectionResponse.Ban   )
info:SetRecommendedResponse        (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )
info:SetMaximumRecommendedResponse (CAC.DetectionResponse.Kick,   CAC.DetectionResponse.Kick  )

function self:ctor ()
end
