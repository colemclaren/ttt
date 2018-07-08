ITEM.ID = 1109
ITEM.Name = "Leet Model"
ITEM.Description = "Rush B"
ITEM.Model = "models/player/leet.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end