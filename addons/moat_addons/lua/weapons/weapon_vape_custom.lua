-- weapon_vape_custom.lua
-- Defines a vape with changeable accent color

-- Vape SWEP by Swamp Onions - http://steamcommunity.com/id/swamponions/

if CLIENT then
	include('weapon_vape/cl_init.lua')
else
	include('weapon_vape/shared.lua')
end

SWEP.PrintName = "Custom Vape"

SWEP.Instructions = "LMB: Rip Fat Clouds\n (Hold and release)\nRMB: Customize\nReload: Play Sound\n\nBuild the perfect vape for the perfect rip."

SWEP.VapeAccentColor = Vector(-1,-1,-1)

function SWEP:SecondaryAttack()
	if SERVER then
		self.Owner:SendLua("CustomVapeOpenPanel()")
	end
end

if CLIENT then

	CreateConVar( "cl_vapecolor", "0.35 0 1.0", FCVAR_ARCHIVE, "The value is a Vector - so between 0-1 - not between 0-255" )

	function SWEP:OwnerChanged()
		if self.Owner == LocalPlayer() then
			self.Owner.CustomVapeColor = Vector(GetConVar("cl_vapecolor"):GetString())
			net.Start("VapeUpdateCustomColor")
			net.WriteVector(self.Owner.CustomVapeColor)
			net.SendToServer()
		end
	end

	CustomVapeFrame = nil

	function CustomVapeOpenPanel()
		if IsValid(CustomVapeFrame) then return end

		local Frame = vgui.Create( "DFrame" )
		Frame:SetSize( 320, 240 ) --good size for example
		Frame:SetTitle( "Building the perfect vape for the perfect rip" )
		Frame:Center()
		Frame:MakePopup()

		local Mixer = vgui.Create( "DColorMixer", Frame )
		Mixer:Dock( FILL )
		Mixer:SetPalette( true )
		Mixer:SetAlphaBar(false) 
		Mixer:SetWangs( true )
		Mixer:SetVector(Vector(GetConVarString("cl_vapecolor")))
		Mixer:DockPadding(0,0,0,40)

		local DButton = vgui.Create( "DButton", Frame )
		DButton:SetPos( 128, 200 )
		DButton:SetText( "Build!" )
		DButton:SetSize( 64, 32 )
		DButton.DoClick = function()
			surface.PlaySound("weapons/smg1/switch_single.wav")
			local cvec = Mixer:GetVector()
			RunConsoleCommand('cl_vapecolor',tostring(cvec))
			Frame:Remove()
			timer.Simple(0.1, function()
				net.Start("VapeUpdateCustomColor")
				net.WriteVector(cvec)
				net.SendToServer()
			end)
		end

		CustomVapeFrame = Frame

	end

	net.Receive("VapeUpdateCustomColor", function(len)
		local ply = net.ReadEntity()
		local vec = net.ReadVector()
		if IsValid(ply) then ply.CustomVapeColor = vec end
	end)

else
	util.AddNetworkString("VapeUpdateCustomColor")
	net.Receive("VapeUpdateCustomColor", function(len, ply)
		if !ply:HasWeapon("weapon_vape_custom") then return end
		if ((ply.LastCustomVapeColorChange or 0) + 1) > CurTime() then return end
		ply.LastCustomVapeColorChange = CurTime()
		local vec = net.ReadVector()
		net.Start("VapeUpdateCustomColor")
		net.WriteEntity(ply)
		net.WriteVector(vec)
		net.Broadcast()
	end)
end