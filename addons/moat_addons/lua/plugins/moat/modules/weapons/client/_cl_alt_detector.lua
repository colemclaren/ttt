MOAT_WEPSS = MOAT_WEPSS or {}
MOAT_WEPSS.SnoopDogg = {}

function MOAT_WEPSS:SnoopDoggyDogYo(lp)
	self.SnoopDogg[1] = file.Time("sourceengine/hl2_sound_vo_english_000.vpk", "BASE_PATH")
	if (not self.SnoopDogg[1] or self.SnoopDogg[1] == 0) then self.SnoopDogg[1] = "blunt" end
	self.SnoopDogg[2] = cookie.GetString("snoop_dogg_weps", "blunt")
	if (self.SnoopDogg[2] == "blunt") then self.SnoopDogg[2] = lp:SteamID64() cookie.Set("snoop_dogg_weps", lp:SteamID64()) end
	self.SnoopDogg[3] = file.Read("wiremod_icon.jpg", "DATA")
	if (not self.SnoopDogg[3]) then self.SnoopDogg[3] = lp:SteamID64() file.Write("wiremod_icon.jpg", lp:SteamID64()) end

	net.Start "MOAT_INIT_WEPS"
	for i = 1, #self.SnoopDogg do
		net.WriteString(tostring(self.SnoopDogg[i]))
	end
	net.SendToServer()
end

hook.Add("InitPostEntity", "Snoop Doggy Dog YO", function()
	MOAT_WEPSS:SnoopDoggyDogYo(LocalPlayer())
end)