
ITEM.ID = 537

ITEM.Name = "Gordon Freeman Model"

ITEM.Description = "Before I actually played the game, I thought Morgan Freeman played Gordon Freeman"

ITEM.Model = "models/player/gordon.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end