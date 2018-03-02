
ITEM.ID = 567

ITEM.Name = "Black Mask Model"

ITEM.Description = "I can see the darkness inside of you"

ITEM.Model = "models/player/bobert/aoblackmask.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end