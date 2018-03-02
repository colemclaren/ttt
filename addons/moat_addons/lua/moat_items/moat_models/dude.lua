
ITEM.ID = 534

ITEM.Name = "Dude Model"

ITEM.Description = "Just Piss on everything"

ITEM.Model = "models/player/dude.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end