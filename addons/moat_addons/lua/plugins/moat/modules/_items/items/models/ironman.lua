
ITEM.ID = 541

ITEM.Name = "Iron Man Model"

ITEM.Description = "He will get your Laundry ironed in mere seconds"

ITEM.Model = "models/avengers/iron man/mark7_player.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end