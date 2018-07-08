
ITEM.ID = 202

ITEM.Name = "GMan Model"

ITEM.Description = "Good Morning"

ITEM.Model = "models/player/gman_high.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end