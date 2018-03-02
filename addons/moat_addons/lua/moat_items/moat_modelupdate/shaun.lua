
ITEM.ID = 555

ITEM.Name = "Shaun Model"

ITEM.Description = "Why are you still here? You should be watching Shaun of the Dead right now"

ITEM.Model = "models/player/shaun.mdl"

ITEM.Rarity = 4

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end