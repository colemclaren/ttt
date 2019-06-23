
ITEM.ID = 545

ITEM.Name = "Yoshi Model"

ITEM.Description = "Extra Salsa"

ITEM.Model = "models/player/yoshi.mdl"

ITEM.Rarity = 9

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end