
ITEM.ID = 545

ITEM.Name = "Alice Model"

ITEM.Description = "My knight model used to be a planetary yoshi at one point"

ITEM.Model = "models/player/alice.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end