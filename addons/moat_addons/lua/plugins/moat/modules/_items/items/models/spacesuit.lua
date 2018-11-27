
ITEM.ID = 559

ITEM.Name = "Space Suit Model"

ITEM.Description = "Went to the Moon and back. Killed a bunch of Terrorists. Didn't even take off the Suit"

ITEM.Model = "models/moat/player/spacesuit.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end