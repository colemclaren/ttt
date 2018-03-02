
ITEM.ID = 536

ITEM.Name = "Freddy Kruger Model"

ITEM.Description = "Invading people's dreams since 1984"

ITEM.Model = "models/player/freddykruger.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end