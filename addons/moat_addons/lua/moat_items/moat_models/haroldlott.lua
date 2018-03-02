
ITEM.ID = 539

ITEM.Name = "Harold Lott Model"

ITEM.Description = "LOADSA MONEY"

ITEM.Model = "models/player/haroldlott.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end