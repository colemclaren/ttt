ITEM.ID = 1112
ITEM.Name = "Urban Model"
ITEM.Description = "Choose your team"
ITEM.Model = "models/player/urban.mdl"
ITEM.Rarity = 3
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end