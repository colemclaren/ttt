ITEM.ID = 5134
ITEM.Name = "Halloween King Model"
ITEM.Description = "Truely the king of halloween, so let's party bitches"
ITEM.Model = "models/player/zack/zackhalloween.mdl"
ITEM.Rarity = 8
ITEM.Collection = "Pumpkin Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end