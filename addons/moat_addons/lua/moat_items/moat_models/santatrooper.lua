ITEM.ID = 7011 --models/gonzo/crimboclonesv2/santa/santa.mdl
ITEM.Name = "Jesus Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/jesus/jesus.mdl"
ITEM.Rarity = 7
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end