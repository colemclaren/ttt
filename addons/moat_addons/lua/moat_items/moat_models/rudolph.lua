ITEM.ID = 7005 --models/gonzo/crimboclonesv2/rudolph/rudolph.mdl
ITEM.Name = "Superman Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/superman.mdl"
ITEM.Rarity = 6
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end