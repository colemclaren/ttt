
ITEM.ID = 526

ITEM.Name = "Altair Model"

ITEM.Description = "Actually gives you the ability to jump 200ft into hay"

ITEM.Model = "models/burd/player/altair.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end