
ITEM.ID = 549

ITEM.Name = "Normal Model"

ITEM.Description = "This isn't a Normal Model. A Normal Model is Gigi Hadid"

ITEM.Model = "models/moat/player/normal.mdl"

ITEM.Rarity = 7

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end