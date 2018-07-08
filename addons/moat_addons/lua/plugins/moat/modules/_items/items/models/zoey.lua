
ITEM.ID = 564

ITEM.Name = "Zoey Model"

ITEM.Description = 'Killing Terrorists is the same as killing Infected "Zombies", right? Hmm...'

ITEM.Model = "models/player/zoey.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end