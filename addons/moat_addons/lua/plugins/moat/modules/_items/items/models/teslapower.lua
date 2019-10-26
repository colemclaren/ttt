
ITEM.ID = 562

ITEM.Name = "Tesla Power Model"

ITEM.Description = "Temporarily osama model until proper power replacement is found by a conscience scientist" -- "If you aren't using a weapon with the Tesla Talent whilst wearing this skin, you're doing it wrong"

ITEM.Model = "models/code_gs/osama/osamaplayer.mdl" -- "models/player/teslapower.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end