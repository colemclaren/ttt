ITEM.ID = 7008 --"models/player/christmas/santa.mdl"
ITEM.Name = "Jolly Santa Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/christmas/santa.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end