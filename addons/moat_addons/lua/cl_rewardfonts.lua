--Modern MOTD Fonts
local function LoadModernMOTDFonts()
if REWARDS.FontsLoaded then return end

REWARDS.FontsLoaded = true
end
LoadModernMOTDFonts()
hook.Add("InitPostEntity", "REWARDS_InitPostLoadFonts", LoadModernMOTDFonts)