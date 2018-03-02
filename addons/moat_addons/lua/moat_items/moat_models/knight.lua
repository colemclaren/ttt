
ITEM.ID = 545

ITEM.Name = "Knight Model"

ITEM.Description = "I think you're in the wrong Era, Mate"

ITEM.Model = "models/player/knight.mdl"

ITEM.Rarity = 6

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end