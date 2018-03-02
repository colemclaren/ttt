
ITEM.ID = 200

ITEM.Name = "Barney Model"

ITEM.Description = "I'm not a bad guy"

ITEM.Model = "models/player/barney.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end