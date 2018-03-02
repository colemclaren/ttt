ITEM.ID = 1110
ITEM.Name = "Phoenix Model"
ITEM.Description = "Rush A"
ITEM.Model = "models/player/phoenix.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end