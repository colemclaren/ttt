
ITEM.ID = 546

ITEM.Name = "Masked Breen Model"

ITEM.Description = "It's got to be said. There's something very BDSM about this Model"

ITEM.Model = "models/player/sunabouzu.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end