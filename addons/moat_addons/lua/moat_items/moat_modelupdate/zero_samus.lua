
ITEM.ID = 563

ITEM.Name = "Zero Suit Samus"

ITEM.Description = "Her eyes are up there! Weirdo"

ITEM.Model = "models/player/samusz.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end