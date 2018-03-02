
ITEM.ID = 196

ITEM.Name = "Bald Monk Model"

ITEM.Description = "Hummmmmm...."

ITEM.Model = "models/player/monk.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end