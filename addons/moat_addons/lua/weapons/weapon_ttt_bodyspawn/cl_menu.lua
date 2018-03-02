DEATHFAKER = {}



-- The local configuration menu

function DEATHFAKER.OpenDFConfig(parent)

	local ply = LocalPlayer()

	

	local w, h = parent:GetSize()

	

	Panel = vgui.Create( "DPanel", parent)

	Panel:SetPaintBackground(false)

	Panel:SetSize( w, h)

	

	-- Headshot CheckBox

	local HeadshotCB = vgui.Create( "DCheckBoxLabel", Panel )

	HeadshotCB:SetText( "Headshot" )

	HeadshotCB:SetPos( 10, 30 )

	HeadshotCB:SetSize( 100, 20 )

	HeadshotCB:SetChecked(ply.df_headshot)

	HeadshotCB.OnChange = function()

		if HeadshotCB:GetChecked() then

		  RunConsoleCommand("ttt_df_headshot", "1")

		  ply.bloodmode = true

		else

		  RunConsoleCommand("ttt_df_headshot", "0")

		  ply.bloodmode = false

		end

	end

	

	-- BodyName ComboBox

	local DLabel = vgui.Create( "DLabel", Panel )

	DLabel:SetPos( 10, 50 )

	DLabel:SetSize( 100, 20)

	DLabel:SetText( "Body Name:" )

	

	local NameComboBox = vgui.Create( "DComboBox", Panel )

	NameComboBox:SetPos( 150, 50 )

	NameComboBox:SetSize( 140, 20 )

	

	local plys = player.GetAll()

	

	local value = ply:Name()

	

	if ply.df_bodyname and player.GetByUniqueID( ply.df_bodyname ) then

		value = player.GetByUniqueID( ply.df_bodyname ):Name()

	end

	

	NameComboBox:SetValue( value )

	for i= 1,#plys do

		NameComboBox:AddChoice( plys[i]:Name(), plys[i]:UniqueID())

	end

	

	NameComboBox.OnSelect = function( panel, index, value, data )

		RunConsoleCommand("ttt_df_select_player", data)

		ply.df_bodyname = data

	end

	

	-- Role ComboBox

	local DLabel = vgui.Create( "DLabel", Panel )

	DLabel:SetPos( 10, 75 )

	DLabel:SetSize( 100, 20)

	DLabel:SetText( "Body Role:" )

	

	local RoleComboBox = vgui.Create( "DComboBox", Panel )

	RoleComboBox:SetPos( 150, 75 )

	RoleComboBox:SetSize( 140, 20 )

	

	local data = 1

	

	if ply.df_role then

		data = ply.df_role

	end



	RoleComboBox:AddChoice( "Innocent", 0, data==0 )

	RoleComboBox:AddChoice( "Traitor", 1, data==1 )

	RoleComboBox:AddChoice( "Detective", 2, data==2 )

	

	RoleComboBox.OnSelect = function( panel, index, value, data )

		RunConsoleCommand("ttt_df_select_role", data)

		ply.df_role = data

	end

	

	-- Weapon ComboBox

	local DLabel = vgui.Create( "DLabel", Panel )

	DLabel:SetPos( 10, 100 )

	DLabel:SetSize( 100, 20)

	DLabel:SetText( "Used Weapon:" )

	

	local WeaponCB = vgui.Create( "DComboBox", Panel )

	WeaponCB:SetPos( 150, 100 )

	WeaponCB:SetSize( 140, 20 )

	

	local weps = weapons.GetList()

	

	-- Default Weapon, Only Clientside!! (Change in shared.lua too)

	if not ply.df_weapon then ply.df_weapon = "weapon_ttt_m16" end

	

	for i= 1,#weps do

		if (weps[i]["Base"] == "weapon_tttbase" and weps[i]["Kind"] == WEAPON_HEAVY) then

			WeaponCB:AddChoice( weps[i]["PrintName"], weps[i]["ClassName"], weps[i]["ClassName"] == ply.df_weapon)

		end

	end

	

	-- Special Damages

	WeaponCB:AddChoice("Fall Damage", "-1", ply.df_weapon == "-1")

	WeaponCB:AddChoice("Explosion Damage", "-2", ply.df_weapon == "-2")

	WeaponCB:AddChoice("Object Damage", "-3", ply.df_weapon == "-3")

	WeaponCB:AddChoice("Fire Damage", "-4", ply.df_weapon == "-4")

	WeaponCB:AddChoice("Water Damage", "-5", ply.df_weapon == "-5")

	

	WeaponCB.OnSelect = function( panel, index, value, data )

		RunConsoleCommand("ttt_df_select_weapon", data)

		ply.df_weapon = data

	end

	

	return Panel

end