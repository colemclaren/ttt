-- weapon_vape_juicy.lua
-- Defines a vape with selectable cloud colors

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "Juicy Vape"

SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB: Change Juice Flavor\nReload: Play Sound\n\nThis vape contains a flavor for everyone!"

SWEP.VapeAccentColor = nil

SWEP.VapeID = 20

--Add your own flavors here, obviously
JuicyVapeJuices = {
	{name = "Mountain Dew", color = Color(150,255,100,255)},
	{name = "Cheetos", color = Color(255,180,100,255)},
	{name = "Razzleberry", color = Color(250,100,200,255)},
	{name = "Banana", color = Color(255,255,100,255)},
	{name = "Black Licorice", color = Color(40,40,40,255)},
	{name = "Churro", color = Color(210,180,140,255)},
	{name = "Skittles", color = nil}, --nil means rainbow
}

if SERVER then
	function SWEP:Initialize()
		self.juiceID = 0
		timer.Simple(0.1, function() SendVapeJuice(self, JuicyVapeJuices[self.juiceID+1]) end)
	end

	util.AddNetworkString("VapeTankColor")
	util.AddNetworkString("VapeMessage")
end

function SWEP:SecondaryAttack()
	if (self.SecondaryAttackWait and self.SecondaryAttackWait > CurTime()) then return end
	self.SecondaryAttackWait = CurTime() + 1

	if SERVER then
		if not self.juiceID then self.juiceID = 0 end
		self.juiceID = (self.juiceID + 1) % (#JuicyVapeJuices)
		SendVapeJuice(self, JuicyVapeJuices[self.juiceID+1])

		--Client hook isn't called in singleplayer...
		if game.SinglePlayer() then	self.Owner:SendLua([[surface.PlaySound("weapons/smg1/switch_single.wav")]]) end
	else
		if IsFirstTimePredicted() then
			surface.PlaySound("weapons/smg1/switch_single.wav")
		end
	end
end

if SERVER then
	function SendVapeJuice(ent, tab)
		local col = tab.color
		if col then
			local min = math.min(col.r,col.g,col.b)*0.8
			col = (Vector(col.r-min, col.g-min, col.b-min)*1.0)/255.0
		else
			--means rainbow tank
			col = Vector(-1,-1,-1)
		end
		net.Start("VapeTankColor")
		net.WriteEntity(ent)
		net.WriteVector(col)
		net.Broadcast()

		if IsValid(ent.Owner) then
			net.Start("VapeMessage")
			net.WriteString("Loaded "..tab.name.." flavor juice")
			net.Send(ent.Owner)
		end
	end
else
	net.Receive("VapeTankColor", function()
		local ent = net.ReadEntity()
		local col = net.ReadVector()
		if IsValid(ent) then ent.VapeTankColor = col end
	end)

	VapeMessageDisplay = ""
	VapeMessageDisplayTime = 0

	net.Receive("VapeMessage", function()
		VapeMessageDisplay = net.ReadString()
		VapeMessageDisplayTime = CurTime()
	end)

	hook.Add("HUDPaint", "VapeDrawJuiceMessage", function()
		local alpha = math.Clamp((VapeMessageDisplayTime+3-CurTime())*1.5,0,1)
		if alpha == 0 then return end

		surface.SetFont("Trebuchet24")
		local w,h = surface.GetTextSize(VapeMessageDisplay)
		draw.WordBox(8, ((ScrW() - w)/2)-8, ScrH() - (h + 24), VapeMessageDisplay, "Trebuchet24", Color(0,0,0,128*alpha), Color(255,255,255,255*alpha))
	end)
end