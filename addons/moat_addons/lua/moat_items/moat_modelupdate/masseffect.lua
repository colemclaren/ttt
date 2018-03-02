
ITEM.ID = 567

ITEM.Name = "Mass Effect Model"

ITEM.Description = "Mass Effect? I think this was in the wrong Crate"

ITEM.Model = "models/player/masseffect.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end