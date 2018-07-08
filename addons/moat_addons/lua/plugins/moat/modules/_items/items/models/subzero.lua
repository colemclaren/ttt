
ITEM.ID = 561

ITEM.Name = "Sub Zero Model"

ITEM.Description = "About -1472.18 to be exact"

ITEM.Model = "models/player/subzero.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end