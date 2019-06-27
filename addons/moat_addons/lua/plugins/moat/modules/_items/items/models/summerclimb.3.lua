
ITEM.ID = 49

ITEM.Name = "Zelda Model"

ITEM.Description = "It's dangerous to go alone! Take this... model"

ITEM.Model = "models/player/zelda.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Summer Climb Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end