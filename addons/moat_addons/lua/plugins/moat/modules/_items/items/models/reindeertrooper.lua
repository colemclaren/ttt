ITEM.ID = 7009 --models/gonzo/crimboclonesv2/reindeer/reindeer.mdl
ITEM.Name = "Green Lantern Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/greenlantern.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end