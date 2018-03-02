
ITEM.ID = 199

ITEM.Name = "Eli Model"

ITEM.Description = "I bet you can't guess why he lost a leg"

ITEM.Model = "models/player/eli.mdl"

ITEM.Rarity = 3

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end