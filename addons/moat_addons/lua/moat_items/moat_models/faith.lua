
ITEM.ID = 535

ITEM.Name = "Ninja Model"

ITEM.Description = "Hide in the shadows comrade"

ITEM.Model = "models/vinrax/player/ninja_player.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end