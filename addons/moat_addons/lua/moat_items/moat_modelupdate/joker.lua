
ITEM.ID = 544

ITEM.Name = "Joker Model"

ITEM.Description = "You wanna know how I got these Scars? HAHA"

ITEM.Model = "models/player/joker.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end