
ITEM.ID = 556

ITEM.Name = "Agent Smith Model"

ITEM.Description = "This model looks an awful lot like Agent K from Men in Black"

ITEM.Model = "models/player/smith.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end