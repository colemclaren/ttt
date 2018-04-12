include('shared.lua')
ENT.Tension = 200
function ENT:Initialize()
	if(self.SetSoundtrack) then self:SetSoundtrack("music/bosstracks/theme_dragon.mp3") end
end