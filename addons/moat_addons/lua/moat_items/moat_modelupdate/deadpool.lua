
ITEM.ID = 531

ITEM.Name = "Deadpool Model"

ITEM.Description = "Please don't operate Guns with your Baby Hands."

ITEM.Model = "models/player/deadpool.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end