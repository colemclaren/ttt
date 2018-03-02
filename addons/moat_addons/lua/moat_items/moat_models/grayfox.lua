
ITEM.ID = 538

ITEM.Name = "Chell Model"

ITEM.Description = "How nice. There are no jiggle boobs"

ITEM.Model = "models/player/p2_chell.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end