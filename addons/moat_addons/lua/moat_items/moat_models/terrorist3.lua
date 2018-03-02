ITEM.ID = 1114
ITEM.Name = "SWAT Model"
ITEM.Description = "Don't stand out too much from the terrorists"
ITEM.Model = "models/player/swat.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end