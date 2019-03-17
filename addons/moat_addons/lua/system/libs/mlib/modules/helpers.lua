
if (SERVER) then
	util.AddNetworkString("Moat.ScreenShake")

	local meta = FindMetaTable("Player")
	function meta:ScreenShake(amp, freq, dur, rad)
		net.Start("Moat.ScreenShake")
		net.WriteFloat(amp or 0)
		net.WriteFloat(freq or 0)
		net.WriteFloat(dur or 0)
		net.WriteFloat(rad or 0)
		net.Send(self)
	end
	
	function util.GlobalScreenShake(amp, freq, dur, rad)
		net.Start("Moat.ScreenShake")
		net.WriteFloat(amp or 0)
		net.WriteFloat(freq or 0)
		net.WriteFloat(dur or 0)
		net.WriteFloat(rad or 0)
		net.Broadcast()
	end
else
	local vec0 = Vector(0, 0, 0)
	net.Receive("Moat.ScreenShake", function()
		local amp = net.ReadFloat()
		local freq = net.ReadFloat()
		local dur = net.ReadFloat()
		local rad = net.ReadFloat()

		util.ScreenShake(vec0, amp, freq, dur, rad)
	end)
end