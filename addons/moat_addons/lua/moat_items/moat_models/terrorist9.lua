ITEM.ID = 1120
ITEM.Name = "Female Police Model"
ITEM.Description = "Wow the police are here"
ITEM.Model = "models/player/police_fem.mdl"
ITEM.Rarity = 4
ITEM.Collection = "Titan Collection"

function ITEM:OnPlayerSpawn( ply )
	timer.Simple( 1, function() ply:SetModel( self.Model ) end )
end