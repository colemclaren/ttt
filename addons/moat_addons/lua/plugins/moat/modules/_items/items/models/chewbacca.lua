
ITEM.ID = 528

ITEM.Name = "Chewbacca Model"

ITEM.Description = "WUUH HUUGUUGHGHG HUURH UUH UGGGUH"

ITEM.Model = "models/moat/player/chewbacca.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end