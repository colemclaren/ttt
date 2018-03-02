
ITEM.ID = 527

ITEM.Name = "Boba Fett Model"

ITEM.Description = "Unfortunatley your Jetpack is out of fuel on this model"

ITEM.Model = "models/player/bobafett.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end