
ITEM.ID = 201

ITEM.Name = "Breen Model"

ITEM.Description = "The wise man"

ITEM.Model = "models/player/breen.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end