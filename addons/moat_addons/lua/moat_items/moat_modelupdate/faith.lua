
ITEM.ID = 535

ITEM.Name = "Faith Model"

ITEM.Description = "Parkour"

ITEM.Model = "models/player/faith.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end