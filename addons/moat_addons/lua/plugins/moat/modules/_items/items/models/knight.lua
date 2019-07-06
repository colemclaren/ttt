
ITEM.ID = 545

ITEM.Name = "Knight Model"

ITEM.Description = "Fixd"

ITEM.Model = "models/moat/player/knight_fixed.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end