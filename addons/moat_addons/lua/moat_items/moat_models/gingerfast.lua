ITEM.ID = 7007 --models/players/gingerfast.mdl
ITEM.Name = "Flash Model"
ITEM.Description = "A special model from the holiday season"
ITEM.Model = "models/player/superheroes/flash.mdl"
ITEM.Rarity = 5
ITEM.Collection = "Holiday Collection"

function ITEM:OnPlayerSpawn(ply)
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end