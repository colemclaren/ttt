
ITEM.ID = 195

ITEM.Name = "Magnusson Model"

ITEM.Description = "Hello doctor"

ITEM.Model = "models/player/magnusson.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end