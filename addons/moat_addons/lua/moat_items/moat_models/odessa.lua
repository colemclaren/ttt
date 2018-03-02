
ITEM.ID = 197

ITEM.Name = "Odessa Model"

ITEM.Description = "Security guard for hire"

ITEM.Model = "models/player/odessa.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end