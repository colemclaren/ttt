ITEM.ID = 1113
ITEM.Name = "Riot Model"
ITEM.Description = "I think they're going B guys"
ITEM.Model = "models/player/riot.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end