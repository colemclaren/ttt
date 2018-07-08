--Haven

local GDCWSettings = {}


CreateClientConVar( "gdcwbulletimpact", "1", FCVAR_REPLICATED + FCVAR_NOTIFY + FCVAR_ARCHIVE )

function GDCWSettings.Panel(CPanel)


	CPanel:AddControl( "Header", { 
		Text = "GDCW Settings", 
		Description = "Adjust the settings for GDCW Weapons" 
		})					
		
	CPanel:AddControl("Slider", {
		Label = "Bullet Impact Effects",
		Type = "Float",
		Min = 0,
		Max = 3,
		Command = "gdcwbulletimpact",
	})
		
	
end

function GDCWSettings.AddPanel()

	spawnmenu.AddToolMenuOption( "Options", "GDCW Settings", "", "Performance", "", "", GDCWSettings.Panel, {} )

end
hook.Add( "PopulateToolMenu", "AddGDCWSettingsPanel", GDCWSettings.AddPanel )


