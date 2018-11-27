
ITEM.ID = 551

ITEM.Name = "Obama Model"

ITEM.Description = "I was better than Trump"

ITEM.Model = "models/moat/player/obama.mdl"

ITEM.Rarity = 5

ITEM.Collection = "Model Collection"

function ITEM:OnPlayerSpawn( ply )

	timer.Simple( 1, function() ply:SetModel( self.Model ) end )

end